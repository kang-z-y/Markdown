# 系统 & 服务管理进阶 02

- [自定义 Yum 仓库](#自定义-yum-仓库)
- [网络 Yum 仓库](#网络-yum-仓库)
- [DNS 服务基础](#dns-服务基础)
- [邮件的收发](#邮件的收发)
- [NTP 时间同步](#邮件的收发)

## 自定义 Yum 仓库

- [预备知识](#预备知识)
  - Yum 仓库的特点
- [构建及配置仓库](#构建及配置仓库)
  - 使用第三方 RPM 包建库
  - 配置客户端文件

### 预备知识

#### Yum 仓库特点

- 作为 yum 源需要准备的内容
  - 大量的 ==.rpm== 软件安装包文件
  - 针对这些软件包的 ==repodata/== 仓库档案
- ***repodata/*** 仓库档案数据
  - ***filelists.xml.gz*** ==软件包的文件安装清单==
  - ***primary.xml.gz*** ==软件包的基本/主要信息==
  - ***other.xml.gz*** ==软件包的其他信息==
  - ***repomd.xml*** ==提供 *.xml.gz* 下载和校验信息==

### 构建及配置仓库

#### 使用第三方 RPM 包建库

- 需要额外创建 *repodata/* 档案
  - 将搜集的 *.rpm* 包文件集中到指定目录
  
  ```bash
  # 准备从互联网下载的软件包，真机的数据包传递到虚拟机中
  scp /root/tools.tar.gz root@192.168.88.1:/root/

  # 虚拟机进行 tar 解包
  tar -xf /root/tools.tar.gz -C /
  ls /tools/other/
  ```

- 需要额外创建 *repodata/* 档案
  - 针对此目录使用 **`createrepo`** 工具创建仓库档案
  
  ```sh
  # 生成仓库数据文件
  createrepo /tools/other/

  ls /tools/other/
  ```

#### 配置客户端文件

- 书写 yum 客户端配置文件
  - 指定本地 Yum 源
  
  ```bash
  vim /etc/yum.repos.d/CentOS7.repo
  ```

- 配置内容
  
  ```repo
  [myrpm]
  name=myrpm
  baseurl=file:///tools/other/    # 指定本地路径
  enabled=1
  gpgcheck=0
  ```

- 查看 yum 源信息
  
  ```bash
  yum repolist [-v]
  ```

## 网络 Yum 仓库

- [Web 服务方式](#web-服务方式)
  - 构建 Web 服务
  - 客户端测试
- [FTP 服务方式](#ftp-服务方式)
  - 构建 FTP 服务
  - 客户端测试

### Web 服务方式

#### 构建 Web 服务

- 装包启动服务
  
  ```bash
  yum -y install httpd
  systemctl restart httpd
  echo Web Test > /var/www/html/index.html
  curl httpd://127.0.0.1
  ```

- 提供光盘内容（注意虚拟 Web 主机的影响）
  
  ```bash
  mkdir /var/www/html/rocky/
  mount /dev/cdrom /var/www/html/rocky/
  ls /var/www/html/rocky/
  curl http://192.168.88.1/rocky/ # 本机 IP 地址
  ```

#### 客户端测试 1

- 客户端虚拟机，书写仓库配置文件
  - 命令

    ```bash
    curl http://192.168.88.1/rocky/
    mkdir /etc/yum.repos.d/bak
    mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/bak/
    vim /etc/yum.repos.d/mydvd.repo
    ```

  - 配置
  
    ```repo
    [app]
    name=Rocky AppStream
    baseurl=http://192.168.88.1/rocky/AppStream
    enabled=1
    gpgcheck=0
    [base]
    name=Rocky BaseOS
    baseurl=http://192.168.88.1/rocky/BaseOS
    enabled=1
    gpgcheck=0
    ```

  - 检查
  
    ```bash
    yum clean all
    yum repoinfo
    ```

- 拓扑图

  <div align=center> <img alt="yum web服务拓扑图" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/yum%20web服务拓扑图.png width=100%/> </div>

### FTP 服务方式

#### 构建 FTP 服务

- 装包启动服务
  
  ```bash
  yum -y install vsftpd
  systemctl restart vsftpd
  echo FTP Test > /var/ftp/ftptest.txt
  curl ftp://192.168.88.1 # 将 /etc/vsftpd/vsftpd.conf 中的 anonymous_enable=NO 改为 YES，重启服务
  ```

- 提供光盘内容
  
  ```bash
  mkdir /var/ftp/dvd
  mount /dev/cdrom /var/ftp/dvd
  ls /var/ftp/dvd
  curl ftp://192.168.88.1/dvd/
  ```

#### 客户端测试 2

- 客户端虚拟机，书写仓库配置文件
  
  ```bash
    [app]
    name=DVD AppStream
    baseurl=ftp://192.168.88.1/dvd/AppStream
    enabled=1
    gpgcheck=0
    [base]
    name=DVD BaseOS
    baseurl=ftp://192.168.88.1/dvd/BaseOS
    enabled=1
    gpgcheck=0
  ```

- 拓扑图
  
  <div align=center> <img alt="yum ftp服务拓扑图" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/yum%20ftp服务拓扑图.png width=100%/> </div>

## DNS 服务基础

- [DNS 工作原理](#dns-工作原理)
  - DNS 解析的作用
  - DNS 的分布式结构
  - DNS 域名管理
- [BIND 服务分析](#bind-服务分析)
  - BIND 域名服务
  - named.conf 配置文件
  - 地址库文件
- [单区域 DNS 服务](#单区域-dns-服务)
  - 快速搭建 DNS 服务器
  - DNS 查询测试
  - DNS 查询的工作方式

### DNS 工作原理

#### DNS 解析的作用

- 为什么需要 DNS 系统
  - <www.baidu.com> 与 119.75.217.56 相比更方便记忆
  - 互联网中的 114 查号台 / 导航员
- DNS 服务器的功能
  - 正向解析：根据注册的域名查找其对应的 IP 地址
  - 反向解析：根据 IP 地址查找对应的注册域名（不常用）

#### DNS 的分布式结构

- 大型、分布式的互联网 DNS 解析库

![DNS 的分布式结构](https://img-blog.csdnimg.cn/direct/5da6dafa3bb74b3f8cfb60865c3ec8fb.png#pic_center)

- **F**ull **Q**ualified **D**omain **N**ame，完全合格的域名
  - = 站点名.域名后缀
  - = 站点名.…….二级域.一级域
- 常见的顶级/一级域名
  - 国家/地区域：`.cn`、`.us`、`.kr`、`.hk`、`.tw`、……
  - 组织域：`.com`、`.net`、`.edu`、`.org`、`.gov`、`.mil`、……

#### DNS 域名管理

- IANA，互联网数字分配机构
  - Internet Assigned Numbers Authority
  - 整个域名系统的最高权威机构
  - 主管 DNS 根、`.int`、`.arpa` 等国际化域名资源
- CNNIC，中国互联网络信息中心
  - China Internet Network Information Center
  - 主管国家顶级域 `.cn`
- 域名注册/购买服务商
  - 阿里云，<https://www.aliyun.com/>
  - 华为云，<https://www.huaweicloud.com/>
  - 腾讯云，<https://cloud.tencent.com/>

### BIND 服务分析

#### BIND 域名服务

- BIND（Berkeley Internet Name Daemon）
  - 伯克利 Internet 域名服务
  - 官方站点：<https://www.isc.org>
- BIND 服务器端程序
  - 主要执行程序：`/usr/sbin/named`
  - 系统服务：**named**
  - 默认端口：TCP/UDP **53**
  - 运行时的虚拟根环境：`/var/named/chroot/`
- 主配置文件：**`/etc/named.conf`**
- 地址库文件：**`/vaar/named/……`**

#### `named.conf` 配置文件

![DNS主配置文件](https://img-blog.csdnimg.cn/direct/c7cd5b9537a844e4b237ccba4ad1d53e.png#pic_center)

- 全局配置部分
  - 设置监听地址/端口、地址库存放位置等
  > options {
    listen-on port 53 {192.168.88.1}; //监听地址和端口
    **directory "/var/named"; //地址文件的默认位置**
    allow-query {any;}; //允许任何客户机查询
    ……
    //listen-on-v6 port 53 {::1;};
    //Include "/etc/named.rfc1912.zones"; //可载入的其他配置
  } [^1]

[^1]: 清理冗余配置，三种注释方法：
  `#` 注释一整行或行内的部分文字
  `//` 注释一整行或行内的部分文字
  `/* */` 可注释连续的多行文字

- 区域配置部分
  - 定义 DNS 区域、类型、地址文件路径等
  - 关键词 `IN` 表示 Internet，可省略
  > zone "stu.cn" IN { //定义正向区域，和负责解析的域名
      type master; //区域类型为主 DNS 服务器
      file "stu.cn.zone"; //地址库文件名
  };
- 检查配置语法
  - 格式：`named-checkconf [配置文件]`
  - `named-checkconf /etc/named.conf` 如果有错，则修正错误；无错误，则无输出

#### 地址库文件

- 模板：`/var/named/named.localhost`
  - 可以复制并重命名该文件 `cp -p /var/named/named.localhost /var/named/stu.cn.zone`
    - `-p` 保证文件复制时权限不会变更

![DNS 地址库模板](https://img-blog.csdnimg.cn/direct/c7b2812b272543218a3e8d78862693de.png#pic_center)

- 全局 TTL 配置项及 SOA 记录
  - $TTL（Time To Live，生存时间）
  - SOA（Start Of Authority，授权信息开始）
  - 分号 `;` 开始的部分表示注释
  > @ IN SOA 区域名. 区域管理邮箱. (
    ……
  ) [^2]

[^2]: 在当前文件内，本区域名可简写为 `@`

---

- DNS 资源解析记录：
  - NS，域名服务器（Name Server）声明记录
  - A，地址（Address）解析记录，仅用于正向解析区域
  - CNAME，解析记录的别名
  > stu.cn. IN NS ns.stu.cn.
  > ns.stu.cn IN A 192.168.88.1
  > svr1.stu.cn IN A 192.168.88.1
  > <www.stu.cn> IN A 192.168.4.100
  > pc2.stu.cn IN A 192.168.4.207
- 可以简写为：
  >  NS ns[^3]
  > ns A 192.168.88.1
  > svr1 A 192.168.88.1
  > www A 192.168.4.100
  > pc2 A 192.168.4.207

[^3]:开头有空格

![DNS 地址库文件](https://img-blog.csdnimg.cn/direct/7a2b7e367aa34003bbf849978f0de0f7.png#pic_center)

##### 补充

- 最低优先级的通配方式，表示没有该站点时（如：`nslookup aaaaaaaa.stu.cn`），匹配该条结果
  > `* A 192.168.1.1`
- 直接写域名本身，表示在查询该域名本身时（如：`nslookup stu.cn`），匹配该条结果
  > `stu.cn. A 192.168.1.2` [^4]
- 内置函数：`$GENERATE` 制造连续的数字
  - `$GENERATE 1-50 pc$ A 192.168.1.$`
- 解析记录的别名：将一个新的站点名，指向已经存在的站点
  - 格式：`vip CNAME ftp`

[^4]:域名后必须加个点 `.`，此为域名的完整格式

![DNS 地址库文件 补充](https://img-blog.csdnimg.cn/direct/28a8b5b07f3747099de56b22a9cc35c3.png#pic_center)

---

- 检查配置语法
  - 格式：`named-checkzone 区域名 配置文件`

  ```sh
  cd /var/named/
  named-checkzone stu.cn stu.cn.zone
  ```

### 单区域 DNS 服务

#### 快速搭建 DNS 服务器

- 基本思路
  1. 安装 *bind*、*bind-chroot* 包
  2. 配置文件
     1. 建立主配置文件 `/etc/named.conf`
     2. 建立地址库文件 `.var/named/……`
  3. 启动 *named* 服务

#### DNS 查询测试

- 为客户机设置默认使用的 DNS
  `vim /etc/resolv.conf`
  > nameserver 192.168.88.1
- 查询命令：`nslookup`、`host`、`dig`
  - `nslookup 查询目标` 查询域名解析
  - `host 查询目标 [DNS服务器地址]`
  - `dig 查询目标`

#### 补充（`/etc/hosts` 文件与 `/etc/resolv.conf` 文件）

1. `/etc/hosts` 文件：域名解析最高优先级，直接进行解析
2. `/etc/resolv.conf` 文件：指定 DNS 服务器地址，需要访问 DNS 服务器

#### DNS 查询的工作方式

- 递归查询（递归解析）：客户端发送请求给首选 DNS 服务器，首选 DNS 服务器与其他的 DNS 服务器交流，最终将解析结果带回来
- 迭代查询（迭代解析）：客户端发送请求给首选 DNS 服务器，首选 DNS 服务器告知下一个 DNS 服务器地址，……
- 现在互联网一般使用“一次递归，多次迭代”的方式进行 DNS 查询

![DNS 查询的工作方式](https://img-blog.csdnimg.cn/direct/0274c3cfc43d4261915936048e0100fc.png#pic_center)

- 根域 DNS 服务器全部不支持递归查询
  - ``

## 邮件的收发

- 基础邮件服务
  - 电子邮件通信
- `mail` 命令发信/收信
  - 使用 `mail` 命令

### 基础邮件服务

#### 电子邮件通信

- 电子邮件服务器的基本功能
  - 为用户提供电子邮箱存储空间（==用户名@邮件域名==）
  - 处理用户发出的邮件 —— 传递给收件服务器
  - 处理用户受到的邮件 —— 投递到邮箱

### `mail` 命令发信/收信

#### 使用 `mail` 命令

- `mail` 发信操作
  - `mail -s '邮箱标题' 收件人[@收件域]……`
