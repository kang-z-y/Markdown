# RHCSA 红帽认证系统管理员

[腾讯文档](https://docs.qq.com/doc/DSFVQTUJEUUxpaHlT)
[虚拟软件及环境](https://pan.baidu.com/s/1jrih1wxbNm0XiGRiFZeQvw?pwd=1234)

## 环境说明

### 真机

#### server1.lab0.example.com 主机的 IP 地址为：172.25.0.254/24

- 该主机默认提供如下服务
  - 提供 RHEL9 软件源 <http://server1.lab0.example.com/rhel9/BaseOS>
  - 提供 RHEL9 软件源 <http://server1.lab0.example.com/rhel9/AppStream>
  - 提供 DNS 服务，为区域 lab.example.com 中相关站点提供解析
  - 提供 NTP 网络时间服务
  - 提供 NFS 文件服务，共享 */rhome/ldapuser0* 目录

#### 考试过程中可能会用到的容器镜像

- 镜像仓库位置在 <http://registry.lab.example.com:5000>
- ==实际考试==仓库使用默认的 80 端口
- ==实际考试==访问仓库需要账户和密码，账户和密码会提供给你（模拟环境免密码）

#### 真机初始化虚拟机

- `rht-vmctl reset [虚拟机名称]`
- 如：`rht-vmctl reset red`

#### 真机查看操作结果

- `rhcsa 01`

### 虚拟机 red（RHEL9）

- 预先设置好 root 口令为 redhat

### 虚拟机 blue（RHEL9）

- 提供 2 块额外的磁盘 */dev/vdb、/dev/vdc*，大小均为 10G
- 预先准备好大小约为 200MiB 的逻辑卷 */dev/test/vo*，格式化为 xfs 文件系统

## 考题

- 真机上操作

  ```sh
  rht-vmctl reset red #还原 red 命令
  virt-manager #VMware 环境需要运行。其他打开“虚拟系统管理器”即可
  ```

- red 虚拟机：利用 root 用户的密码为 redhat

### 考试内容概述

六大方面：

- 网络管理
- 软件包管理
- 用户管理
- 权限管理
- 空间管理
- 基础服务管理（Web 服务、计划任务、时间服务器、NFS 共享、触发挂载）

### 一、虚拟机 red 练习题

#### 01.配置网络地址

问题描述
: 虚拟机 red 的管理口令为 redhat
  请为此虚拟机配置以下网络参数：

  1. 主机名：red.lab0.example.com
  2. IP 地址：172.25.0.25/24
  3. 默认网关：172.25.0.254
  4. DNS 服务器：172.25.0.254

解析
: 相关命令：`nmcli`、`ip`

- 开启 root 身份远程管理

  ```sh
  vim etc/ssh/sshd_config # 修改远程管理配置
  # PermitRootLogin yes # 修改原有配置为 yes

  systemctl restart sshd # 重启远程管理服务
  ```

- 配置完成 IP 地址网络参数后，可以在**真机**上进行远程管理 red 虚拟机
  - `ssh root@172.25.0.25`

#### 02.配置默认软件仓库 YUM

问题描述
: <http://server1.lab0.example.com/rhel9/BaseOS>
  <http://server1.lab0.example.com/rhel9/AppStream>
: 请配置你的虚拟机，以将这些位置作为默认软件源

#### 03.调试 SELinux

问题描述
: 配置 httpd 在 82 端口上提供 Web 服务，满足以下要求：

  1. 此 Web 服务器能够提供 */var/www/html* 中所有现有的 HTML 文件
  2. 此 Web 服务器在系统启动时自动启动
  3. 确保 SELinux 保护机制运行在 Enforcing 模式

  ```sh
  vim /etc/httpd/conf/httpd.conf
  # 修改 Listen 82

  #设置 SELinux 需要 semanage 命令
  yum provides semanage
  #找到提供命令的软件
  yum -y install policycoreutils-python-utils

  semanage port -l | grep http 找到 http 的端口类型名
  semanage port -a -t http_prot_t -p tcp 82
  #-l：列出   -a：添加    -t：类型    -p：协议

  systemctl enable httpd
  #Created symlink /etc/systemd/system/multi-user.target.wants/httpd.service -> /usr/lib/systemd/system/httpd.service.  

  systemctl restart httpd

  yum -y remove firewalld
  ```

#### 4.配置用户账户

问题描述
: 创建用户 tammy，其用户 ID 为 2020，此用户的密码应当是 ilovelinux

#### 5.创建用户账户

问题描述
: 根据下列要求创建用户及组帐号

  1. 名为 admins 的组
  2. 用户 zhsan，其附属组为 admins
  3. 用户 lisi，其附属组还属于 admins
  4. 用户 wangwu，没有可交互的登录 Shell，且不属于 admins 组
  5. zhsan、lisi、wangwu 的密码都应该是 ilovelinux

#### 6.配置 cron 计划任务

问题描述
: 配置计划任务
  : 以用户 zhsan 的身份 每 5 分钟执行一次命令 `logger "RH200 Test"`

#### 7.配置文件权限

问题描述
: 将文件 */etc/hosts* 复制为 */var/tmp/hosts* 并按要求配置 */var/tmp/hosts* 的权限：

  1. 文件 */var/tmp/hosts* 属于 root 用户
  2. 文件 */var/tmp/hosts* 属于 root 组
  3. 任何用户对 */var/tmp/hosts* 都没有可执行权限
  4. **用户 zhsan 能够读取和写入 */var/tmp/hosts* 文件**
  5. **用户 lisi 无法读取或写入 */var/tmp/hosts* 文件**
  6. 所有其他用户（当前或未来）能够读取 */var/tmp/hosts* 文件

#### 8.创建共用目录

问题描述
: 创建具有以下特点的共用目录：

  1. */home/tools* 的组的所有权是 admins
  2. 此目录能被 admins 组的成员读取、写入和访问，除 root 外其他用户没有这些权限
  3. 在此目录下创建的文件，其组的所有权自动设置为 admins 组

#### 9.配置 NTP 时间客户端

问题描述
: 设置你的系统，使其成为 server1.lab0.example.com 的 NTP 客户端。

  ```sh
  yum -y install chrony
  vim /etc/chrony.conf
  #server 172.25.0.254 iburst

  systemctl restart chronyd
  systemctl enable chronyd
  ```

#### 10.配置 autofs

问题描述
: 按照以下要求，通过 autofs 自动挂载远程用户的主目录：
  
  1. *server1.lab0.example.com(172.25.0.254)* 通过 NFS 共享目录 */rhome* 到你的系统，此文件系统中包含为用户 ldapuser0 预配置的主目录
  2. 预设用户 ldapuser0 的登录密码是 password
  3. **预设用户 ldapuser0 的主目录是 `server1.lab0.example.com:/rhome/ldapuser0`**
  4. **预设用户 ldapuser0 的主目录应自动挂载到本地的 */rhome/ldapuser0* 目录**
  5. 挂载后的主目录必须可供用户 ldapuser0 写入

解析
: 将 *172.25.0.254:/rhome/ldapuser0* 进行触发挂载到本地的 */rhome/ldapuser0*

  ```sh
  yum -y install autofs nfs-utils
  vim /etc/auto.master
  # 添加行 /rhome /etc/ldapuser0.misc

  vim /etc/ldapuser0.misc
  # 添加行 ldapuser0 -fstype=nfs,rw 172.25.0.254:/rhome/ldapuser0

  systemctl restart autofs
  systemctl enable autofs

  ls /rhome/ldapuser0
  df -h /rhome/ldapuser0
  ```

#### 11.查找文件

问题描述
: 1. 通过命令找出 */etc/* 目录下大小超过 2MB 的文件，并将其副本放入 */root/findfiles* 目录。
  2. 编写脚本（*/root/abc.sh*），脚本可以实现查找并拷贝文件，具体要求如下：
    在 */usr* 查找，小于 10M、权限包含 sgid、用户为 root 的文件，并拷贝到 */root/findfiles*

解析
: `-perm -g=s` 包含 sgid 权限的数据

##### 补充内容：创建用于定位文件的脚本

问题描述
: 创建名为 mysearch 的脚本，用于定位 */usr* 下的文件
  - [ ] 脚本 mysearch 应定位到 */usr* 下面所有小于 10M 并有设置组 ID 权限的文件
  - [ ] 将脚本 mysearch 放置在 */uer/local/bin* 下面
  - [ ] 执行时，脚本 mysearch 应将查找到的文件列表保存到 */root/myfiles*

#### 12.查找字符串

问题描述
: 找出文件 */etc/man_db.conf* 中包含字符串 sbin 的所有行，将其副本按原始顺序存放到文件 */root/out.txt* 中不得包含空行，且所有行必须是 */etc/man_db.conf* 中原始行的准确副本

#### 13.创建归档

问题描述
: 创建一个名为 */root/backup.tar.bz2* 的 tar 归档，其应该包含 */usr/local/* 的内容。此归档文件必须使用 bzip2 进行压缩

解析
: 安装 *tar bzip2*
  `-P` 绝对路径方式进行归档压缩

#### 14.执行程序

问题描述
: 主机上有一个程序 rhcsa，要求运行该程序，屏幕上则显示 *hello tedu*

#### 15.系统用户密码的有效期

问题描述
: 在系统中新增的用户，要求 25 天后密码自动失效，密码过期前 5 天警告

解析
: 相关文件 `/etc/login.defs`

#### 16.配置容器服务（高难度）

问题描述
: 利用仓库服务器（注册表服务器）上面的 nginx 镜像，创建一个名为 logserver 的容器。
  : 1、使用 Containerfile 自定义镜像，比如：在镜像中写入一个文件
    2、将其配置为以 systemd 服务的形式运行，仅面向用户 tammy
    3、该服务应命名为 container-logserver，并将其设置为开机自动启动

#### 17.为容器配置持久存储（扩展上一个任务的 logserver 容器服务）

问题描述
: 1、将服务配置为启动时自动将主机中的 */tmp/test* 目录挂载到容器中的 */opt/hello* 目录
  2、将服务配置为启动时自动将主机中的 */home/tammy/container_logserver* 目录挂载到容器中的 */usr/share/nginx/html* 目录
  3、在 red 执行如下命令：
    `logger -p local5.info "This is an RHCSA exam"`
    容器的 */usr/share/nginx/html/rhcsa.log* 和容器主机上的 */home/tammy/container_logserver/rhcsa.log* 中均显示消息 *This is an RHCSA exam*

### 虚拟机 blue 练习题

- 中心
  - 还原 blue
    - `rht-vmctl reset blue` KVM，开启**虚拟机系统管理器**
  - 打开虚拟系统管理软件

- 家

  ```sh
  rht-vmctl reset blue
  virt-manager # VMware 显示虚拟系统管理器
  ```

#### 18.设置 root 密码，并设置网络参数

问题描述
: 获得系统 blue 的管理权限，并将 blue 的 root 密码设置为 *redhat*
: blue 虚拟机配置网络参数为：
  : 主机名：blue.lab0.example.com
    IP 地址：172.25.0.26/24
    默认网关：172.25.0.254
    DNS 服务器：172.25.0.254

#### 19.配置软件仓库 YUM

问题描述
: <http://server1.lab0.example.com/rhel9/BaseOS>
  <http://server1.lab0.example.com/rhel9/AppStream>
  请配置你的虚拟机，以将这些位置作为默认软件源。

#### 20.调整逻辑卷大小

问题描述
: 将逻辑卷 vo 及其文件系统大小调整到 300MiB。确保文件系统内容保持不变。

解析
: 将众多的物理卷（pv），组建成卷组（vg），然后再从卷组中划分逻辑卷（lv）

  ```sh
  vgs
  lvs

  lvextend -L 300M /dev/test/vo
  if blkid /dev/test/vo | grep -q xfs; then
    xfs_growfs /dev/test/vo # xfs
  else
    resize2fs /dev/test/vo # ext4
  fi
  
  df -h /vo
  ```


#### 23.配置系统调优

问题描述
: 为你的系统选择建议的 tuned 配置集并将它设为默认设置。

解析
: 命令

  ```sh
  yum -y install tuned
  systemctl enable tuned --now

  tuned-adm active # 显示当前方案
  tuned-adm recommend # 查看推荐方案（比 virtual-guest）
  tuned-adm profile virtual-guest # 切换为指定优化方案
  tuned-adm active
  ```

#### 24.配置 sudo 提权

问题描述
: 为你的系统配置 sudo 提权，具体要求如下：
  1、创建 user1 用户，设置用户密码为 test。
  2、授权 user1 组中的任何用户都可以无密码执行管理员命令。

解析
: `visudo` 或 */etc/sudoers*
