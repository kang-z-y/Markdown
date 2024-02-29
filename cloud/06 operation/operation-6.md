# Linux 高级运维 06

- RPM 打包
- VPN 服务器
- systemd 服务管理

## RPM 打包

- 基本概念
  - 应用场景
- 软件打包
  - 打包流程
  - 安装 rpm-build
  - 准备源码软件
  - 编写编译配置文件
  - 编译 RPM 包

### 基本概念

#### 应用场景

- 官方未提供 RPM包
- 官方 RPM 无法自定义
- 大量源码包，希望提供统一的软件管理机制

### 软件打包

- 打包流程
  - 准备源码软件
  - 安装 *rpm-build*
  - **编写编译配置**
  - 编译 RPM 包

- 安装 rpm-build
  - 编译打包 RPM 的命令工具

    ```sh
    yum -y install rpm-build
    rpmbuild -ba test.spec # 生成 rpmbuild 目录
    ls
    ```

- 准备源码软件
  - 将源码包复制到 rpmbuild 子目录

    ```sh
    cp nginx-1.22.1.tar.gz rpmbuild/SOURCES/
    ```

- 编写编译配置文件
  - 新建 SPEC 文件

    ```sh
    vim /root/rpmbuild/SPECS/nginx.spec
    ```

  - 配置内容（参考：[项目打包rpm包](https://blog.csdn.net/zd147896325/article/details/119673178)）

    ```spec
    Name:nginx
    Version:1.22.1
    Release: 1
    Summary: nginx is a web server software.
    #Group:
    License:GPL
    URP:www.nginx.org
    Source0:nginx-1.22.1.tar.gz

    BuildRoot: %(mktemp-ud %{_tmppath}/%{name}-%{version}-%{release})
    #BuildRequires:
    Requires:pcre-devel openssl-devel
    %description
    nginx is an HTTP and reverse proxy server.

    %post
    useradd nginx

    %prep
    %setup -q

    %build
    ./configure
    make %{?_smp_mflags}

    %install
    rm -rf %{buildroot}
    make install DESTDIR=%{buidlroot}

    %clean
    rm -rf %{buildroot}

    %files
    %doc
    /usr/local/nginx/*

    %changelog
    ```

- 编译 RPM 包
  - 使用 spec 文件编译 RPM 包
  
    ```sh
    rpmbuild -ba /root/rpmbuild/SPECS/nginx.spec
    ```

  - 安装测试 RPM 包

    ```sh
    rpm -qpi XXX.rpm
    rpm -qpl XXX.rpm
    rpm -ivh XXX.rpm
    ```

## VPN 服务器

- GRE VPN
  - VPN 概述
  - 拓扑图
  - GRE 模块
  - 创建 VPN 隧道
  - 测试连通性
- PPTP VPN
  - 概述
  - 拓扑图
  - 部署 VPN 服务器
  - Windows 客户端
- L2TP+IPSec VPN
  - 概述
  - 拓扑图
  - 部署 L2TP+IPSec 服务器
  - Windows 客户端

### GRE VPN

- VPN 概述
  - Virtual Private Network（虚拟专用网络）
    - 在<font color=red>公用网络上</font>建立<font color=red>专用似有网络</font>，进行加密通讯
    - 多用于为集团公司的各地子公司建立连接
    - 连接完成后，各个地区的子公司可以向局域网一样通讯
    - 在企业网络中有广泛应用
    - <font color=red>偶尔可以用于翻墙</font>
    - 目前主流的 VPN 技术（*GRE、PPTP、L2TP+IPSec、SSL*）

- 拓扑图
  - 出差在外，连接公司的服务器
  - 或者，分公司之间的连接

  <div align=center> <img alt="GRE-VPN拓扑图" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/GRE-VPN拓扑图.png width=80%/> </div>

- GRE 模块
  - Linux 内核模块
    - **ipo_gre**
  - 加载模块

    ```sh
    lsmod | grep ip_gre # 显示模块列表
    modprobe ip_gre     # 加载模块
    modinfo ip_gre      # 查看模块信息
    ```

  - 缺点：缺少加密机制

- 创建 VPN 隧道
  - Client

    ```sh
    modprobe ip_gre
    ip tunnel add tun0 mode gre remote 201.1.2.5 local 201.1.2.10
    ip link set tun0 up
    ip addr add 10.10.10.10/8 peer 10.10.10.5/8 dev tun0
    firewall-cmd --set-default-zone=trusted
    ```

  - VPN 服务器

    ```sh
    modprobe ip_gre
    ip tunnel add tun0 mode gre remote 201.1.2.10 local 201.1.2.5
    ip link set tun0 up
    ip addr add 10.10.10.5/8 peer 10.10.10.10/8 /dev tun0
    echo "1" > /proc/sys/net/ipv4/ip_forward
    firewall-cmd --set-default-zone=trusted
    ```

- 测试连通性
  - Client

    ```sh
    ping 10.10.10.5
    ping 192.168.88.5
    ```

  - proxy

    ```sh
    ping 10.10.10.10
    ```

### PPTP VPN

- 概述
  - PPTP（Point to Point Tunneling Protocol），点对点隧道协议
  - 支持密码身份验证
  - 支持 MPPE（Microsoft Point-to-Point Encryption）加密

- 拓扑图
  - 拓扑图沿用之前实验的拓扑结构
  - 使用==一台 Windows 主机作为客户端==
  - ==Windows IP 地址为：201.1.2.20./24==

- 部署 VPN 服务器
  - 安装软件

    ```sh
    yum install pptpd-1.4.0-2.el7.x86_64.rpm
    rpm -qc pptpd
    ```

  - 修改配置文件
    - ***/etc/pptpd.conf***
    - ***/etc/ppp/options.pptpd***
    - ***/etc/ppp/chap-secrets***

    ```conf
    # /etc/pptpd.conf
    localip 201.1.2.5 # 服务器本地 IP
    remoteip 192.168.3.1-50 # 分配给客户端的 IP 池
    ```

    ```pptpd
    # /etc/ppp/options.pptpd
    require-mppe-128 # 使用 MPPE 加密数据
    ms-dns 8.8.8.8 # DNS 服务器
    ```

    ```secrets
    # /etc/ppp/chap-secrets
    jacob      *          123456    *
    # 用户名    服务器标记    密码    客户端
    ```

    ```sh
    echo "1" > /proc/sys/net/ipv4/ip_forward
    ```

  - 启动服务

    ```sh
    systemctl start pptpd
    firewall-cmd --set-default-zone=trusted
    ```

  - 翻墙设置

    ```sh
    iptables -t nat -A POSTROUTING -s 192.168.3.0/24 -j SNAT --to-source 201.1.2.5
    ```

- Windows 客户端
  - 配置 IP 地址：201.1.2.20
  - 建立 VPN
  - 测试
    - `ping 201.1.2.5`
      `ping 192.168.4.5`

### L2TP+IPSec VPN

- 概述
  - Layer Two Tunneling Protocol（L2TP），第二层隧道协议
  - L2TP 建立主机之间的 VPN 隧道，压缩、验证
  - IPSec 提供数据加密、数据校验、访问控制的功能
- 拓扑图
  - 沿用之前实验的拓扑结构
  - 使用另一台 VPN 服务器，配置 IP 地址
- 部署 L2TP+IPSec 服务器
  - 安装软件

    ```sh
    yum -y install  libreswan
    yum install xl2tpd-1.3.8-2.el7.x86_64.rpm
    ```

  - 创建 IPSec 加密配置文件（***/etc/ipsec.d/myipsec.conf***）

    ```conf
    conn IDC-PSK-NAT
        rightsubnet=vhost:%priv       # 允许的 VPN 虚拟网络
        also=IDC-PSK-noNAT
    
    conn IDC-PSK-noNAT
        authby=secrets                 # 加密认证
            ike=2des-sha1;modp1024           # 算法
            phase2alg=aes256-sha1;modp2048   # 算法
        pfs=no
        auto=add
        keyingtries=3
        rekey=no
        ikelifetime=8h
        keylife=3h
        type=transport
        lift=201.1.2.10     # 重要，服务器本机的外网 IP
        right=%any      # 允许任何客户端连接
        rightprotoport=17/%any
    ```

    - 新建 IPSec 预定义共享密钥

    ```sh
    cat /etc/ipsec.secrets # 不要修改该文件
    # include /etc/ipsec.d/*.secrets
    echo '201.1.2.10 %any: PSK "randpass"' > /etc/ipsec.d/mypass.secrets # 新建文件，randpass 为密钥
    ```

    - 启动 IPSec 服务

    ```sh
    systemctl start ipsec
    netstat -ntulp | grep pluto
    ```

    - 修改 xl2tp 配置文件
      ***/etc/xl2tpd/xl2tpd.conf***
      ***/etc/ppp/options.xl2tpd***
      ***/etc/ppp/chap-secrets***

    ```conf
    # /etc/xl2tpd/xl2tpd.conf
    [global]
    [lns default]
    ip range = 192.168.3.128-192.168.3.254 # 分配给客户端的 IP 池
    local ip = 201.1.2.10 # 服务 IP 地址
    ```

    ```xl2tpd
    # /etc/ppp/options.xl2tpd
    require-mschap-v2 # 添加一行
    #crtscts          # 注释或删除该行
    #lock             # 注释或删除该行
    ```

    ```secrets
    # /etc/ppp/chap-secrets

    jacob     *     123456      *
    ```

  - 启动 XL2TP 服务

    ```sh
    systemctl start xl2tpd
    netstat -ntulp | grep xl2tpd
    ```

  - 翻墙

    ```sh
    echo "1" > /proc/sys/net/ipv4/ip_forward
    firewall-cmd --set-default-zone=trusted
    iptables -t nat -A POSTROUTING -s 192.168.3.0/24 -j SNAT --to-source 201.1.2.10
    ```

- Windows 客户端
  - 配置 IP 地址：201.1.2.20
  - 建立 VPN 连接（与之前的实验一致）
  - 默认拨号有些版本的 windows 系统会报错：需要做如下设置：
    - <kbd>win</kbd>+<kbd>r</kbd>，输入 *regedit*，然后回车
    - 找到下面的注册表子项
      ***HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Services\\Rasman\\Parameters***
    - 在编辑菜单上，单击“新建” -> “DWORD值”
    - 在“名称”框中，键入 “*ProhibitIpSec*”
      在“数值数据”框中，键入“*1*”，然后单击“确定”
    - 退出注册表编辑器，然后重新启动计算机
  - 测试
    - `ping 201.1.2.5`
      `ping 192.168.4.5`

## systemd

- 概述
  - systemd 简介
  - systemctl 命令
  - Unit 文件
  - Unit 文件语法
- systemd 案例
  - 脚本管理
  - Nginx 服务管理
  - 注意事项

### 概述

#### systemd 简介

- systemd 是 Linux 系统的一组基本构建块
- 它提供了一个系统和服务管理器
- 它作为 **PID 1** 运行并启动系统的其余部分进程
- 控制 systemd 的主要命令是 **<font color=red>systemd</font>**

#### systemd 命令

@import "operation-6-1.csv"

#### Unit 文件

- systemd 管理服务时会读取对应的配置文件，也就是 unit 文件
- 读取 Unit 文件的目录（优先级由高到低）
  - ***/etc/systemd/system***（设置了开机自启动的 Unit 文件）
  - ***/usr/lib/systemd/system/***（所有已经安装软件的 Unit 文件）
- Unit 文件范例

  ```unit
  
  ```