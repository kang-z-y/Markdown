# 第一阶段笔记

[腾讯文档](https://docs.qq.com/s/-_tEwCNmD-PFR_jzzUgABG)

云计算学院NSD课程全阶段软件：
链接：<https://pan.baidu.com/s/10D0hA3DqfmfUjoq4tIvgYA>
提取码：**1wzg**

## 一

- 服务器
  : 能够为其他计算机提供服务的更高级的电脑
    –机架式
    –塔式
    –机柜式
    –刀片式
- 服务器的类型尺寸
  : Unit
  - 1u=1.75英寸=44.45毫米=4.445 厘米
  - 2u则是1u的2倍为8.89cm
- 典型服务模式
  : C/S，Client/Server架构
  - 由服务器提供资源或某种功能
  - 客户机使用资源或功能

- 网络位
  : 类似身份证号的前6位，用来表示区域
- 主机位
  : 用来表示在区域中编号

- 表示网络名称
  : 网络位不变，主机位全为0
- 相同网络(区域)通信：
  - 192.168.1.1=来自192.168.1.0网络，在这个区域中编号1的计算机
  - 192.168.1.2=来自192.168.1.0网络，在这个区域中编号2的计算机

- 不同网络(区域)通信：
  - 192.168.1.1=来自192.168.1.0网络，在这个区域中编号1的计算机
  - 192.168.3.2=来自192.168.3.0网络，在这个区域中编号2的计算机

- ==网络位.网络位.网络位.主机位==

- 总结：192.168.1.200 ==> 192 ==> C类:192~223 ==> 网.网.网.主 ==> 192.168.1.0网络

- 表示网络名称：网络位不变，主机位全为0

- 子网掩码
  : 为计算机标识IP地址的网络位与主机位，利用二进制的1标识网络位，利用二进制的0标识主机位
  - 192.168.1.1  255.255.255.0  =  192.168.1.1/24

- ipconfig
  : windows查看IP地址命令
- ping
  : 测试网络通信,默认进行4次，每一次有去有回
  - 格式：`ping 对方的IP地址`
  - 例子：`ping 192.168.1.200`

- PC>ping   192.168.1.2
  > Pinging 192.168.1.2 with 32 bytes of data:
Reply from 192.168.1.2: bytes=32 time=2ms TTL=128
Reply from 192.168.1.2: bytes=32 time=0ms TTL=128
Reply from 192.168.1.2: bytes=32 time=0ms TTL=128
Reply from 192.168.1.2: bytes=32 time=0ms TTL=128
Ping statistics for 192.168.1.2:
Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
Minimum = 0ms, Maximum = 2ms, Average = 0ms

- 配置IP地址方式:
  1. 手工配置
  2. DHCP自动获取(DHCP服务器)

- DNS服务器
  : 提供域名解析功能
  - <www.baidu.com> ==> DNS服务器(地图导航) ==> 百度的服务器  IP地址

- 网关地址
  : 路由器接口的地址，不同网络之间的通信会用到网关地址

## 二

- Linux是一种操作系统！！
- 操作系统
  : 一堆软件的集合，让计算机硬件正常的工作
- UNIX诞生
  : 1970-1-1
- Linux之父
  : Linus Torwalds
- 内核
  : 调配计算机硬件资源
  - 用户---->内核---->硬件
  - 内核版本号
    : 主版本.次版本.修订号
- 常见的Linux系列
  - Red Hat Enterprise Linux 6/7/8/9
  - Rocky Linux 8/9
  - Suse Linux Enterprise 12
  - Debian Linux 7.8
  - Ubuntu Linux 22.04

### 操作

步骤一：命令行界面字体调节
字体变大：ctrl shift +
字体变小：ctrl -

    [root@localhost ~]# pwd    #显示当前所在的位置
    [root@localhost ~]# cd   /   #切换到根目录下
    [root@localhost /]# pwd
    [root@localhost /]#  ls      #显示当前目录下内容
    [root@localhost /]# cd    /boot
    [root@localhost boot]# ls
    [root@localhost boot]# cd   /
    [root@localhost /]# ls
    [root@localhost /]# cd  /home
    [root@localhost home]# ls
    [root@localhost home]# cd   /root  
    [root@localhost ~]# ls

---

    [root@localhost etc]# ls  /       #查看根目录内容
    [root@localhost etc]# ls  /home
    [root@localhost etc]# ls  /opt
    [root@localhost etc]# ls  /boot
    [root@localhost etc]# ls  /var
    [root@localhost etc]# ls  /bin
    [root@localhost etc]# ls  /proc
    [root@localhost etc]# ls  /usr
    [root@localhost etc]# ls  /tmp
    [root@localhost etc]# ls  /mnt

- 蓝色：目录
- 黑色：文件

      [root@localhost /]# ls    /root/
      [root@localhost /]# ls    /root/anaconda-ks.cfg
      [root@localhost /]# cat     /root/anaconda-ks.cfg   #查看文件内容
      [root@localhost /]# cat    /root/initial-setup-ks.cfg
      [root@localhost /]# cat    /etc/passwd
      [root@localhost /]# cat    /etc/fstab
      [root@localhost /]# cat    /etc/group
      [root@localhost /]# cat    /etc/redhat-release  #查看系统版本

- less查看文本文件内容,适合查看内容较多文件

      [root@localhost /]# less  /etc/passwd
      按上、下键进行滚动
      按q键进行退出

#### `hostname` 命令练习

    [root@localhost /]# hostname
    localhost.localdomain
    [root@localhost /]# hostname   abc.haha.xixi   #临时设置
    [root@localhost /]# hostname
    abc.haha.xixi

    新开一个全新的命令行终端，查看提示符变化
    [root@abc ~]# hostname   nb.haha.com   #临时设置

    新开一个全新的命令行终端，查看提示符变化
    [root@nb ~]# hostname

    永久设置主机名
    ]# hostnamectl   set-hostname   nb.xixi.com
    ]# hostname

---

- 绝对路径
  : 以根开始的完整路径
  - 地球---》亚洲---》中国---》北京---》东城区---》珠市口街道---》珍贝大厦三层

- 相对路径
  : 以当前位置为参照的路径
  - 楼上 ==> 楼下  

        [root@localhost ~]# cd  /usr
        [root@localhost usr]# ls
        [root@localhost usr]# cd    games         #相对路径
        [root@localhost games]# pwd

        [root@localhost games]# cd   /
        [root@localhost /]# cd   /usr/games    #绝对路径
        [root@localhost games]# pwd

        ..  上一层目录（父目录）
        [root@haha games]# cd  /usr/games
        [root@haha games]# pwd
        /usr/games
        [root@haha games]# cd   ..
        [root@haha usr]# pwd
        /usr
        [root@haha usr]# cd  ..
        [root@haha /]# pwd
        /
        [root@haha /]#

- `ifconfig` 查看IP地址

      ]# ifconfig
      lo: 本机回环接口(此接口专门用于测试)
      IP永远为127.0.0.1
      127.0.0.1：永远代表本机
      ]# ifconfig   enp1s0   192.168.4.1  #临时设置IP
      ]# ifconfig  enp1s0

      ]# ping   192.168.4.1
      Ctrl  c：结束正在运行命令

- 列出CPU处理器信息

      [root@A ~]# lscpu
      型号名称：Intel(R) Core(TM) i5-4430 CPU @ 3.00GHz
      ……

- 列出内存信息
  
      [root@A ~]# cat   /proc/meminfo   #内存详细信息
      MemTotal:         997956 kB    #一共内存总和
      ……
      [root@A ~]# free  -h    #内存一共的大小

- 哲学：==一切皆文件==
- 硬盘表示
  : `/dev`：存放设备(硬盘、光驱、U盘、键盘……)相关的数据
  - Linux系统中第三块SCSI硬盘如何表示？
    : /dev/sdc

- 真机为Linux平台：
- KVM虚拟机硬盘的接口类型：独有的接口类型为vd
- 可以利用命令 `lsblk` 查看识别的硬盘

- `mkdir` 创建目录

      [root@A ~]# mkdir   /opt/test
      [root@A ~]# ls   /opt
      [root@A ~]# mkdir  /root/nsd01
      [root@A ~]# ls  /root

- `touch` 创建文本文件

      [root@A ~]# touch    /opt/1.txt
      [root@A ~]# ls   /opt
      [root@A ~]# touch    /opt/2.txt
      [root@A ~]# ls   /opt

- `head`、`tail` 命令（查看部分文件内容）
  - 格式
    : `head -n 数字 文件名`
    : `tail -n 数字 文件名`

          [root@A /]# head   -1    /etc/passwd
          [root@A /]# head   -2    /etc/passwd
          [root@A /]# head   -3    /etc/passwd
          [root@A /]# tail   -1   /etc/passwd
          [root@A /]# tail   -2   /etc/passwd
          [root@A /]# tail   -3   /etc/passwd

          作用：输出包含指定字符串的行
          [root@A /]# grep  root    /etc/passwd
          [root@A /]# grep  bash    /etc/passwd
          [root@A /]# grep  lisi    /etc/passwd
          [root@A /]# grep  zhangsan   /etc/passwd
          [root@A /]# grep  haha   /etc/passwd

- vim(文本编辑器)修改文件内容
  - 三个模式
    : 命令模式、插入模式(输入模式)、末行模式

- vim当文件不存在时，会自动创建此文件
- vim不能创建目录

      [root@A /]# vim    /opt/haxi.txt
      命--- i键 或者 o键 --->插入模式(Esc键回到命令模式)
      令
      模
      式--- 英文的冒号：--->末行模式(Esc键回到命令模式)

      命令模式  u      #可以实现撤销
      末行模式 :wq     #保存并退出
      末行模式 :q!     #强制不保存并退出

- 重启系统与关闭系统
  : 关机 `poweroff` 与重启操作系统 `reboot`

- 案例：拍摄快照
  : 关闭系统，拍摄虚拟机快照（还原数据作用）

- 在Linux中执行大多数命令时，都要找到命令所对应的程序

      [root@localhost /]#  hostname
      [root@localhost /]#  which  hostname     #查询命令对应的程序
      [root@localhost /]#  ls  /usr/bin/hostname
      [root@localhost /]#  which ifconfig     #查询命令对应的程序
      [root@localhost /]#  firefox
      [root@localhost /]#  which  firefox   #查询命令对应的程序

- 命令的执行依赖于解释器（默认解释器/bin/bash）
- 用户--->解释器（shell）--->内核--->硬件
- 绿色：可以执行的程序

- 命令行完整格式：`命令   [选项]…   [参数1]   [参数2]…`

      [root@localhost /]#  cat    --help           #查看命令帮助信息
      [root@localhost /]#  cat    -n    /etc/shells   #显示行号
      [root@localhost /]#  cat    -n    /etc/passwd
      [root@localhost /]#  cat    -n    /etc/redhat-release
      [root@localhost /]#  cat    -n    /etc/fstab  
      [root@localhost /]#  cat    -n    /etc/shadow
      [root@localhost /]#  cat    -n    /etc/hosts
      [root@localhost /]#  cat    -n    /etc/group

      [root@localhost /]#  ls   -l    /etc/passwd    #长格式显示
      [root@localhost /]#  ls   -l    /etc/fstab      #显示详细属性
      [root@localhost /]#  ls   -l    /etc/shells
      [root@localhost /]#  ls   -l    /etc/shadow   #长格式显示
      [root@localhost /]#  ls   -l    /etc/hosts    #长格式显示
      [root@localhost /]#  ls   -l    /etc/group    #长格式显示
      [root@localhost /]#  ls   -l    /etc/gshadow  #长格式显示

      [root@localhost /]#  ls   -l    /root #默认显示目录内容的详细属性

#### 快捷键

- <kbd>Tab</kbd> 键自动补全
  : 可补齐命令字、选项、参数、文件路径、软件名、服务名

        [root@localhost /]#  if(tab) (tab)        #列出以if开头的命令  
        [root@localhost /]#  ifco(tab)
        [root@localhost /]#  cat   /etc/re(tab) (tab)
        [root@localhost /]#  cat   /etc/red(tab)
        [root@localhost /]#  ls  /etc/sysconfig/network-scripts/
        [root@localhost /]#  ls  /et(tab)/sysco(tab)/netw(tab)- (tab)

        [root@nb ~]# ls -l  /boot/symvers-4.18.0-372.9.1.el8.x86_64.gz

- <kbd>Ctrl</kbd> + <kbd>c</kbd>
  : 结束正在运行的命令
- <kbd>Esc</kbd> + <kbd>.</kbd> 或 <kbd>Alt</kbd> + <kbd>.</kbd>
  : 粘贴上一个命令的参数

        [root@localhost ~]# ls    /etc/hosts
        [root@localhost ~]# ls  -l    Alt + .
        [root@localhost ~]# cat     Alt + .
        [root@localhost ~]# cat   -n    Alt + .

- <kbd>Ctrl</kbd> + <kbd>l</kbd>
  : 清空整个屏幕
- <kbd>Ctrl</kbd> + <kbd>u</kbd>
  : 从光标处清空至行首
- <kbd>Ctrl</kbd> + <kbd>k</kbd>
  : 从光标处清空至行尾
- <kbd>Home</kbd>
  : 从光标处快速到行首
- <kbd>End</kbd>
  : 从光标处快速到行尾
- <kbd>Ctrl</kbd> + <kbd>w</kbd>
  : 往回删除一个单词（以空格界定）

---

- `mount`
  : 挂载操作
    : 可以让目录成为设备的访问点
  - 光盘镜像文件，众多软件包
  - 命令行显示光盘镜像文件内容

1. 图形操作，将光盘镜像文件放入到虚拟机的光驱设备
   - 光盘镜像文件----》虚拟光驱设备---》访问点(目录)
   - `/dev/cdrom`
2. 使用 `mount` 命令进行挂载

       [root@nb ~]# mkdir   /dvd
       [root@nb ~]# mount  /dev/cdrom   /dvd  
       mount: /dvd: WARNING: device write-protected, mounted read-only.
       [root@nb ~]#  ls   /dvd

3. 使用umount命令进行卸载

       [root@nb /]# umount  /dvd
       [root@nb /]# ls /dvd

       [root@nb /]# mkdir  /mydvd
       [root@nb /]# mount /dev/cdrom  /mydvd
       mount: /mydvd: WARNING: device write-protected, mounted read-only.
       [root@nb /]# ls  /mydvd

注意事项：

1. 卸载：当前所在的路径是挂载点目录

       [root@localhost mydvd]# umount /mydvd
       umount: /mydvd：目标忙。
       (有些情况下通过 lsof(8) 或 fuser(1) 可以
       找到有关使用该设备的进程的有用信息)

2. 允许：一个设备，挂载到不同的挂载点目录
3. 不允许：一个挂载点目录，挂载多个设备
4. 建议挂载点目录，最好自行创建

- `~`
  : 表示用户的家目录
- 家目录
  : 专门储存用户个性化信息的目录
- `/root`
  : 管理员的家目录
- `/home`
  : 存储普通用户的家目录

        [root@localhost /]#  cd  ~root    #去往root用户的家目录
        [root@localhost /]#  pwd
        [root@localhost /]#  useradd  dc   #创建用户dc
        [root@localhost /]#  cd  ~dc       #去往dc用户的家目录
        [root@localhost /]#  pwd
        [root@localhost /]#  useradd  tom   #创建用户tom
        [root@localhost /]#  cd  ~tom       #去往tom用户的家目录
        [root@localhost /]#  pwd

#### `ls` — List

- 格式：ls [选项]... [目录或文件名]
- 常用命令选项：
  `-l`：以长格式显示，显示详细信息
  `-h`：提供易读的容量单位（K、M等）
  `-d`：显示目录本身（而不是内容）的属性

      [root@localhost /]# ls  -ld   /home
      [root@localhost /]# ls  -ld   /root
      [root@localhost /]# ls  -ld    /
      [root@localhost /]# ls  -l     /etc/passwd
      [root@localhost /]# ls  -lh   /etc/passwd

    `-A`：显示所有内容,包含隐藏数据
    `-R`：递归显示目录内容

      [root@localhost /]# ls  -A     /root
      [root@localhost /]# touch    /opt/.nsd.txt
      [root@localhost /]# ls    /opt/
      [root@localhost /]# ls   -A    /opt

      [root@localhost /]# ls  -R   /boot

  - 通配符
    `*`：任意多个任意字符

        [root@localhost /]# ls    /root/a*
        [root@localhost /]# ls    /boot/vm*
        [root@localhost /]# ls    /etc/*tab
        [root@localhost /]# ls    /etc/*.conf
        [root@localhost /]# ls    /etc/re*.conf
        [root@localhost /]# ls    /dev/tty*
        [root@localhost /]# ls   -d   /etc/r*
        [root@localhost /]# ls   -d   /etc/*as*

    `?`：单个字符（必须要有一个）

        [root@localhost /]# ls   /etc/??tab
        [root@localhost /]# ls   /dev/tty?
        [root@localhost /]# ls   /dev/tty??

    `[a-z]`:多个字符或连续范围中的一个，若无则忽略
    `{a,min,xy}`:多组不同的字符串，全匹配

        [root@localhost /]#  ls    /dev/tty[3-9]
        [root@localhost /]#  ls    /dev/tty[1-7]
        [root@localhost /]#  ls    /dev/tty{1,17,20}
        [root@localhost /]#  ls    /dev/tty{10,18,22,33}
        [root@localhost /]#  ls    /dev/tty{26,19,21,30,40}
        [root@localhost /]#  ls    /etc/{rw,fs}tab

#### 别名的定义：简化复杂的命令

    [root@localhost /]#  hostname
    [root@localhost /]#  alias   hn='hostname'   #临时定义别名
    [root@localhost /]#  hn
    [root@localhost /]#  alias           #查看系统中有哪些别名
    [root@localhost /]#  unalias    hn    #删除hn别名
    [root@localhost /]#  hn
    bash: hn: 未找到命令...
    [root@localhost /]#  alias     myls='ls   -l'
    [root@localhost /]#  myls   /etc/passwd

- 补充：定义永久的别名，修改用户家目录的 .bashrc

      [root@nb /]# vim   /root/.bashrc

      alias  hn='hostname'    #新增一行内容，在第二行进行书写

      [root@nb /]#

- 开启一个新的命令行终端，才会生效

      [root@nb /]# hn

      -p：连同父目录一并创建
      [root@localhost /]#  mkdir   -p    /opt/aa/bb/cc/dd
      [root@localhost /]#  ls   -R    /opt/aa       #递归显示目录内容
      [root@localhost /]#  mkdir    -p    /nsd04/test04
      [root@localhost /]#  ls   -R     /nsd04
      [root@localhost /]#  mkdir    -p    /cbd/abc01
      [root@localhost /]#  ls   -R     /cbd
      [root@localhost /]#  mkdir    -p    /xtt/stu01
      [root@localhost /]#  ls   -R     /xtt

---

#### rm删除(Remove)

- rm 删除 Remove
- 格式：rm [选项]... 文件或目录…
- 常用命令选项
  `-r`、`-f`：递归删除（含目录）、强制删除

      [root@localhost /]#
      [root@localhost /]#  ls     /opt
      [root@localhost /]#  rm     -rf     /opt/1.txt
      [root@localhost /]#  ls    /opt
      [root@localhost /]#  rm     -rf     /opt/aa
      [root@localhost /]#  ls     /opt

#### mv移动/剪切

- 格式：mv 原文件… 目标路径

      [root@localhost /]#  rm  -rf  /opt/*    #删除目录所有内容
      [root@localhost /]#  mkdir    /opt/nsd01
      [root@localhost /]#  touch    /opt/1.txt

      [root@localhost /]#  ls     /opt/
      [root@localhost /]#  mv     /opt/1.txt      /opt/nsd01
      [root@localhost /]#  ls    /opt/
      [root@localhost /]#  ls   /opt/nsd01

- 重命名：路径不变的移动

      [root@localhost /]#  ls   /opt/
      [root@localhost /]#  mv   /opt/nsd01    /opt/abc
      [root@localhost /]#  ls   /opt/

      [root@localhost /]#  mv    /opt/abc       /opt/student
      [root@localhost /]#  ls    /opt/

      [root@localhost /]#  mv    /opt/student     /mnt/stu01
      [root@localhost /]#  ls    /mnt/

#### cp

- 格式：cp [选项]... 原文件… 目标路径
  常用命令选项
  `-r`：递归，复制目录时必须有此选项

      [root@localhost /]#  cp      /etc/passwd       /opt
      [root@localhost /]#  ls     /opt
      [root@localhost /]#  cp    -r     /boot       /opt  
      [root@localhost /]#  ls     /opt
      [root@localhost /]#  cp    -r     /home      /opt
      [root@localhost /]#  ls     /opt

- 进行强制覆盖

      ]#  \cp  -r  /boot  /opt   #本次操作临时取消别名
      ]#  \cp  -r  /boot  /opt   #本次操作临时取消别名

- 复制可以支持两个以上的参数，永远把最后一个参数作为目标，其他的所有的参数都作为源数据

      ]# mkdir  /nsd10
      ]# cp -r  /etc/passwd   /etc/shadow  /home   /boot  /nsd10
      ]# ls   /nsd10

- 复制可以重新命名，目标路径下数据的名称

      [root@localhost /]#  cp    -r    /home   /opt/myhome
      [root@localhost /]#  ls    /opt
      [root@localhost /]#  cp    /etc/shells      /opt/s.txt
      [root@localhost /]#  ls    /opt

      [root@localhost /]#  ls     /opt
      [root@localhost /]#  cp    -r     /root     /opt/myroot
      [root@localhost /]#  ls    /opt
      [root@localhost /]#  cp   -r     /root      /opt/myroot  
      [root@localhost /]#  ls      /opt/myroot

- 复制与一个点进行连用，将数据复制到当前路径下

      [root@localhost /]#  cd    /etc/sysconfig/network-scripts/
      [root@localhost network-scripts]#  pwd
      [root@localhost network-scripts]#  cp   /etc/passwd     .  
      [root@localhost network-scripts]#  ls

#### grep命令的高级使用

- 基本：过滤包含关键字的行

      [root@nb opt]# grep  root   /etc/passwd
      [root@nb opt]# grep  bash   /etc/passwd

  - `-i`:忽略大小写

        [root@nb opt]# grep  man  /etc/man_db.conf
        [root@nb opt]# grep -i  man  /etc/man_db.conf

        [root@nb opt]# grep -i  ROOT  /etc/passwd

  - `-v`:取反匹配(不包含)

        [root@nb opt]# grep -v  root  /etc/passwd
        [root@nb opt]# grep -v  bash  /etc/passwd

- 高级使用
  - ^word 以字符串word开头
  - word$ 以字符串word结尾

        [root@localhost /]#  grep   ^root   /etc/passwd
        [root@localhost /]#  grep   ^bin     /etc/passwd

        [root@localhost /]#  grep   root$    /etc/passwd
        [root@localhost /]#  grep   bash$    /etc/passwd

  - ^$ 表示空行

        ]#  cat   /etc/default/useradd
        ]#  grep  ^$  /etc/default/useradd  #过滤空行
        ]#  grep -v  ^$  /etc/default/useradd  #过滤不要空行的内容

        ]#  cat   /etc/login.defs
        ]#  grep  ^$  /etc/login.defs  #过滤空行
        ]#  grep -v  ^$  /etc/login.defs  #过滤不要空行的内容

#### 案例：复制、删除、移动

1. 在目录/opt下创建一个子目录 nsd
2. 在目录/opt/nsd/创建文件readme.txt,利用vim写入内容 I Love Linux
3. 将/etc/passwd 和 /etc/resolv.conf同时拷贝到/opt/nsd目录下
4. 将文件 /etc/shells复制到 /root/ 下，同时 改名为 version.txt
5. 将文件 /root/version.txt 移动到/opt/nsd/目录下
6. 将/home目录复制到/opt/nsd/目录下

---

## 四

### 压缩

常见的压缩格式：
: gzip-----.gz
  bzip2-----.bz2
  xz------.xz

#### tar

- 制作压缩包，制作tar包（打包）
  格式:tar  选项   /路径/tar包名字   /被归档压缩的源数据
  - `-c`:创建    -f：指定tar包名字，必须在所有选项的最后
  `-z`  `-j`  `-J` :  gzip    bzip2   xz

        ]# tar -zcf   /root/cbd.tar.gz  /etc/passwd   /home
        ]# ls  /root

        ]# tar -jcf  /root/haha.tar.bz2  /etc/passwd   /home
        ]# ls   /root
        ]# tar -Jcf  /root/cctv.tar.xz  /etc/passwd    /home
        ]# ls   /root

- 解包
  格式:tar  选项   /路径/tar包名字   选项    /路径/释放的位置
  - `-x`：释放数据
  - `-f`：指定tar包名字，必须在所有选项的最后
  - `-C`：指定路径
  - `-t`：查看tar包内容

        ]# tar  -tf  /root/haha.tar.bz2  #查看tar包内容
        ]# mkdir   /nsd11
        ]# tar -xf  /root/haha.tar.bz2    -C     /nsd11
        ]# ls    /nsd11
        ]# ls    /nsd11/etc
        ]# ls    /nsd11/home

        ]# tar -zcf /root/zz.tar.gz   -C  /etc  passwd   shells    hosts

        ]# tar -tf  /root/zz.tar.gz

- 补充内容：只做归档不做压缩

      ]# tar  -cf  /root/test.tar  /etc/passwd  /home/  /boot

- 补充内容：只做压缩不做归档

      [root@nb ~]# gzip  /opt/2.txt
      [root@nb ~]# ls  /opt/
      2.txt.gz  haha.txt  nsd01  nsd03
      [root@nb ~]#

### 命令

#### 重定向

- 重定向(重新定向命令的输出)：
  将前面命令的输出，作为文件内容，写入到后面的文件
- `>`:覆盖重定向
  `>>`:追加重定向

      [root@A /]# head -5 /etc/passwd > /opt/p.txt
      [root@A /]# cat  /opt/p.txt
      [root@A /]# head -2 /etc/passwd > /opt/p.txt
      [root@A /]# cat  /opt/p.txt
      [root@A /]# hostname
      [root@A /]# hostname   >>   /opt/p.txt
      [root@A /]# cat  /opt/p.txt

#### echo命令的使用

    [root@localhost /]# echo     123456
    [root@localhost /]# echo   123456    >    /opt/p.txt
    [root@localhost /]# cat     /opt/p.txt
    [root@localhost /]# echo     hello  world
    [root@localhost /]# echo   hello  world    >>    /opt/p.txt
    [root@localhost /]# cat     /opt/p.txt
    [root@localhost /]# cat     /etc/hostname
    [root@localhost /]# echo    nb.tedu.cn    >    /etc/hostname
    [root@localhost /]# cat    /etc/hostname

#### 管道 | 操作：  传递

- 作用：将前面命令的输出，传递给后面命令，作为后面命令的参数

      ]#` head  -4  /etc/passwd   |      tail  -1
      ]# head  -8  /etc/passwd  |   tail  -1

      ]# cat -n  /etc/passwd  |  head  -8  | tail  -1
      ]# ifconfig  |  head  -`2

- 显示8~12行内容

      ]# head  -12  /etc/passwd   |    tail  -5
      ]# cat -n  /etc/passwd   |  head -12
      ]# cat -n  /etc/passwd  |  head  -12  |  tail -5

      ]# cat -n  /etc/passwd  |  head -12  |   tail -5  > /opt/pa.txt
      ]# cat  /opt/pa.txt

- Linux中大多数配置文件内容，以#开头的行为注释行
- 显示配置文件有效信息（去除以#开头的注释行和去除空行）

      ]# grep -v  ^#  /etc/login.defs
      ]# grep -v  ^#  /etc/login.defs  |  grep -v  ^$

      ]# grep -v ^# /etc/login.defs   |  grep -v ^$  > /opt/log.txt
      ]# cat  /opt/log.txt

- 格式：find [目录]  [条件]

- `-type` 类型（f文本文件、d目录、l快捷方式）

      [root@A /]# find    /boot     -type    d
      [root@A /]# find    /opt     -type    d
      [root@A /]# find    /etc     -type    l
      [root@A /]# find    /boot    -type    f

      [root@A /]# find    /boot     -type    d   |  cat   -n
      [root@A /]# find    /boot     -type    d   |  wc  -l

      [root@localhost /]# find    /etc    -name    "passwd"
      [root@localhost /]# find    /etc    -name    "*tab"
      [root@localhost /]# find    /etc    -name    "*.conf"
      [root@localhost /]# find  /root  -name  ".*"   #查找隐藏数据

      [root@localhost /]# find   /etc    -name   "*tab"   |  wc  -l
      [root@localhost /]# find   /etc    -name  "*.conf"   |  wc  -l
      [root@localhost /]# find   /etc   -name  "*.conf"  |  cat  -n

- 两个条件联合使用

      ]# mkdir   /mnt/cbd01
      ]# mkdir   /mnt/cbd02
      ]# touch   /mnt/cbd03.txt
      ]# find   /mnt/   -name   "cbd*"
      ]# find   /mnt/   -name   "cbd*"   -type   d
      ]# find   /mnt/   -name   "cbd*"   -type   f

      ]# find   /mnt/   -name   "cbd*" -o  -type   f    #两个满足其中一个

      -size  k M G
      ]# find   /boot   -size  +300k
      ]# find   /boot   -size  +10M
      ]# find   /boot   -size  +1M
      ]# find   /boot   -size  +10M    -size  -50M

- `-user` 用户名 （按照数据的所有者）

      [root@A /]# useradd  natasha  #创建用户
      [root@A /]# find  /home   -user    natasha
      [root@A /]# find    /      -user    natasha

- /proc：内存的数据，不占用硬盘空间

      [root@A /]# useradd  harry  #创建用户
      [root@A /]# find  /home   -user    harry
      [root@A /]# find    /      -user    harry

-mtime  数据的修改时间

-mtime  +90   #90天之前
-mtime  -10   #最近10天之内

三个月之前的数据
]# find  /var   -mtime  +90

处理find找到的数据，每查找的一个就传递一次
find [范围] [条件] -exec 处理命令 {} \;
-exec额外操作的开始
{} 永远表示前面find查找的结果
\; 额外操作的结束
]# find   /boot   -size     +10M

]# find  /boot  -size  +10M  -exec   cp  {}   /mnt   \;
]# ls    /mnt

两个条件联合使用
]# mkdir   /root/mytab
]# find    /etc   -name   "*tab"    -type   f

]# find   /etc    -name  "*tab"    -type   f
 -exec   cp       {}    /root/mytab    \;

[# ls    /root/mytab

案例：查找并处理文件
利用find查找，数据的所有者为 student，并且必须是文件,把它们拷贝到 /root/findfiles/ 文件夹中
]# useradd  student           #创建普通用户student
]# mkdir  /root/findfiles
]# find   /    -user  student   -type  f
]# find  /  -user student  -type  f  -exec cp  {}  /root/findfiles   \;

]# ls  -A  /root/findfiles/   #-A显示隐藏数据

[root@nb ~]# cp  /etc/passwd  /opt/pass.txt
[root@nb ~]# vim  /opt/pass.txt

读取文件内容
[root@localhost /]# echo  123456  >  /opt/aa.txt
[root@localhost /]# echo  hahaxixi  >  /opt/cc.txt
[root@localhost /]# vim    /opt/cc.txt
末行模式下    :r  /opt/aa.txt
末行模式下    :r  /etc/hosts
末行模式下    :r  /etc/shells

字符串替换
:1,10s/root/new/g 替换第1-10行所有的“root”
:%s/bin/haha/g 替换文件内所有的“bin”

[root@localhost /]# cp  /etc/passwd    /opt/s.txt
[root@localhost /]# vim  /opt/s.txt

开关参数的控制
:set nu或nonu    #显示/不显示行号
:set ai或noai      #启用/关闭自动缩进
[root@localhost /]# vim  /opt/s.txt

默认vim功能开关配置文件,用户家目录下 .vimrc
[root@nb ~]# vim   /root/.vimrc
set  nu
set  ai

[root@nb ~]# vim   /opt/s.txt      #测试是否开启行号功能

对比两个文件的内容
vimdiff同时比对或修改多个文件
[root@a ~]# echo hahaxixi > /opt/aa.txt
[root@a ~]# echo hahaabc > /opt/bb.txt
[root@a ~]# vimdiff  /opt/aa.txt   /opt/bb.txt
命令模式下Ctrl与w同时按下，然后左右键移动光标
末行模式wqa保存全部文件并退出

du  -sh   #查看目录占用硬盘的空间

  -s:不需要统计目录的子目录

[root@nb ~]# du  -sh  /etc
[root@nb ~]# du  -sh  /root
[root@nb ~]# du  -sh  /boot
[root@nb ~]# du  -sh  /

1.利用find查找/boot/ 目录下以 vm 开头且必须是文件，拷贝到/opt
find  /boot   -name 'vm*'  -type  f  
find  /boot   -name 'vm*'  -type  f  -exec  cp  {}   /opt  \;
2.利用find查找/boot/ 目录下为快捷方式
find  /boot   -type  l
3.利用find查找/etc 目录下，以 tab 作为结尾的且必须是文件
find  /etc   -name   '*tab'
4.创建目录结构/study/nsd01
mkdir  -p  /study/nsd01
5.在目录/study/nsd01创建文件abc.txt,利用重定向写入内容 abc.tedu.cn
echo  abc.tedu.cn  >  /study/nsd01/abc.txt
6.将/study/nsd01/abc.txt文件复制到/opt目录下，同时改名为 test.txt
cp  /study/nsd01/abc.txt    /opt/test.txt

1. 利用vim 修改文件/opt/test.txt将其原有内容全部删除，写入新的内容为www.sina.com

[root@nb ~]# mount  /dev/cdrom   /mnt
mount: /mnt: WARNING: device write-protected, mounted read-only.
[root@nb ~]# ls  /mnt
AppStream  EFI     isolinux  media.repo
BaseOS     images  LICENSE   TRANS.TBL
[root@nb ~]#

[root@localhost /]# rpm  -qa    #当前系统中所有已安装的软件包
[root@localhost /]# rpm  -q   firefox   #查看firefox是否安装
[root@localhost /]# rpm  -q  httpd #httpd构建Web服务器软件
未安装软件包 httpd

[root@localhost /]# rpm  -q   bash

[root@localhost /]# rpm  -qa  |   grep   firefox
[root@localhost /]# rpm  -qa  |    wc   -l

]# rpm  -qi   firefox       #查询软件信息
]# rpm  -ql   firefox   #查询软件安装了哪些内容(安装清单)
]# rpm  -ql    firefox   |   less

]# rpm  -qi   bash       #查询软件信息
]# rpm  -ql   bash   #查询软件安装了哪些内容(安装清单)
]# rpm  -ql    bash   |   less

[root@localhost ~]# which  vim  #查询命令对应的程序文件
/usr/bin/vim
[root@localhost ~]# rpm  -qf   /usr/bin/vim

[root@localhost ~]# rpm  -q   vim-enhanced

[root@localhost ~]# rpm  -qf   /usr/sbin/poweroff
[root@localhost ~]# rpm  -qf   /usr/sbin/ifconfig

[root@localhost /]# ls  /mnt/AppStream/Packages/v/vsftpd-3.0.3-35.el8.x86_64.rpm

查询软件包的安装清单：  
[root@localhost /]# rpm -qpl  /mnt/AppStream/Packages/v/vsftpd-3.0.3-35.el8.x86_64.rpm

查询软件包信息
[root@localhost /]# rpm -qpi  /mnt/AppStream/Packages/v/vsftpd-3.0.3-35.el8.x86_64.rpm

导入红帽签名信息(了解)
]# rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial

查询软件包信息（没有警告输出）
]# rpm -qpi /mnt/AppStream/Packages/v/vsftpd-3.0.3-35.el8.x86_64.rpm

]# rpm  -q   vsftpd    #查询是否安装vsftpd软件
]# rpm -ivh /mnt/AppStream/Packages/v/vsftpd-3.0.3-35.el8.x86_64.rpm     #安装软件包

]# rpm  -q   vsftpd
]# rpm  -ql   vsftpd   #查询安装清单

]# rpm  -evh   vsftpd   #卸载软件
]# rpm  -q   vsftpd

软件依赖关系:

自动解决依赖关系安装方式：yum安装

前提：构建软件包仓库

]# mkdir  /etc/yum.repos.d/haha
]# mv  /etc/yum.repos.d/*.repo   /etc/yum.repos.d/haha

]# ls  /etc/yum.repos.d/
]# ls  /etc/yum.repos.d/haha

[root@localhost /]# vim     /etc/yum.repos.d/xixi.repo  
[haha]
name=xixi
baseurl=file:///mnt/AppStream
enabled=1
gpgcheck=0
[xixi]
name=xixi
baseurl=file:///mnt/BaseOS
enabled=1
gpgcheck=0
[root@localhost /]# yum   repoinfo   #列出识别的仓库

Yum的使用
[root@localhost ~]# yum   -y   install  httpd
[root@localhost ~]# rpm   -q   httpd  #检测是否安装成功

[root@localhost ~]# yum   -y   install   bind-chroot
[root@localhost ~]# rpm   -q   bind-chroot

[root@localhost ~]# yum   -y   install   sssd
[root@localhost ~]# rpm   -q   sssd
[root@localhost ~]# yum   -y   install   gcc
[root@localhost ~]# rpm   -q    gcc

[root@localhost ~]# yum   remove   gcc
[root@localhost ~]# yum   remove   httpd

[root@localhost ~]# rpm  -q  gcc
[root@localhost ~]# rpm  -q  httpd

[root@localhost /]# yum list  ftp  #查询仓库是否有ftp软件
可安装的软件包        #表示当前系统没有安装该软件
ftp.x86_64        0.17-67.el7         nsd20
[root@localhost /]# yum  list  httpd
[root@localhost /]# yum  search  ftp   #包含ftp就匹配

]# yum  provides   /usr/bin/hostname
]# yum  provides  /etc/passwd #仓库中那个软件包产生该文件
]# yum  provides   guestmount #查询仓库中那个软件产生该程序

[root@svr1 ~]# rm   -rf  /usr/bin/hostname
[root@svr1 ~]# ls    /usr/bin/hostname
ls: 无法访问/usr/bin/hostname: 没有那个文件或目录
[root@svr1 ~]# yum  provides  /usr/bin/hostname  #查询仓库中那个软件，产生了此程序

[root@svr1 ~]# yum   -y    reinstall   hostname  #覆盖安装
[root@svr1 ~]# ls   /usr/bin/hostname

清空缓存(了解)
执行流程: yum命令--->/etc/yum.repos.d/*.repo--->baseurl=file:///mnt

[root@localhost ~]# yum  clean   all  #清空Yum的缓存
[root@localhost ~]# yum   repoinfo   #列出仓库信息

案例:Yum软件仓库管理

1. 将光驱设备挂载到/iso/linux目录，以/iso/linux目录作为其访问点
2. 利用/iso/linux目录提供光盘内容作为软件源，构建本地Yum仓库
3. 安装软件包httpd

]# mkdir  -p  /iso/linux
]# mount  /dev/cdrom   /iso/linux
]# ls  /iso/linux
]# rm  -rf  /etc/yum.repos.d/*
]# vim   /etc/yum.repos.d/iso.repo
[app]
baseurl=file:///iso/linux/AppStream
gpgcheck=0
[base]
baseurl=file:///iso/linux/BaseOS
gpgcheck=0
]# yum  -y  install   httpd    #安装软件测试

历史命令
[root@localhost ~]# history          #显示历史命令列表
[root@localhost ~]# history   -c    #清空历史命令
[root@localhost ~]# history   -w   #记住历史命令为空
[root@localhost ~]# history
[root@localhost ~]# cat   /etc/redhat-release
[root@localhost ~]# ls   /root
[root@localhost ~]# history
[root@localhost ~]# !cat  #指定最近一条以cat开头的历史命令
[root@localhost ~]# !ls   #指定最近一条以ls开头的历史命令

date查看系统时间/设置系统时间
]# date
]# date  -s    "2008-9-6   11:17:11"     #修改系统时间
]# date
]# date   -s    "2024-1-4   16:33:11"
]# date

date单独显示时间
[root@localhost ~]# date   +%Y     #显示年
[root@localhost ~]# date   +%m    #显示月
[root@localhost ~]# date   +%d     #显示日期
[root@localhost ~]# date   +%H    #显示时
[root@localhost ~]# date   +%M    #显示分
[root@localhost ~]# date   +%S     #显示秒
[root@localhost ~]# date   +%F    #显示年-月-日
[root@localhost ~]# date   +%T    #显示时:分:秒

zip归档工具，跨平台（Windows与Linux）
归档+压缩操作: zip  [-r]   备份文件.zip   被归档的文档...
[-r]:被归档的数据有目录，必须加上此选项
]# zip  -r     /opt/abc.zip      /etc/passwd     /home
]# ls   /opt/
释放归档+解压操作: unzip  备份文件.zip   [-d  目标文件夹]  
]# unzip  -l   /opt/abc.zip   #查看压缩包的内容
]# mkdir   /nsd20
]# unzip       /opt/abc.zip       -d    /nsd20
]# ls  /nsd20
]# ls   /nsd20/etc
]# ls   /nsd20/home

快捷方式的制作（链接文件、符号链接）
方式一：软链接
格式：ln  -s  /路径/源数据    /路径/快捷方式的名称   #软链接

[root@localhost /]# ls    /etc/hosts
[root@localhost /]# ln -s  /etc/hosts   /hs
[root@localhost /]# ls     /
[root@localhost /]# ls   -l     /hs

[root@localhost /]# ls   /opt
[root@localhost /]# ln -s  /opt   /haxi
[root@localhost /]# ls   -l   /haxi       #查看快捷方式详细属性
[root@localhost /]# ls   -l    /haxi/    #查看源目录内容详细数据

软链接优势：可以针对目录与文件制作快捷方式，支持跨分区
软链接缺点：源数据消失，快捷方式失效

方式二：硬链接
格式：ln    /路径/源数据    /路径/快捷方式的名称   #硬链接

硬链接优势：源数据消失，快捷方式仍然有效
[root@nb ~]# rm  -rf   /opt/*
[root@nb ~]# echo 123   >   /opt/A.txt
[root@nb ~]# ln   /opt/A.txt    /opt/B.txt
[root@nb ~]# ls   /opt/
A.txt  B.txt
[root@nb ~]# rm -rf   /opt/A.txt
[root@nb ~]# ls  /opt/
B.txt
[root@nb ~]# cat  /opt/B.txt
123

[root@nb ~]# rm -rf /opt/*
[root@nb ~]# echo 123 >  /opt/1.txt
[root@nb ~]# ln -s /opt/1.txt  /opt/2.txt  #制作软链接
[root@nb ~]# ln  /opt/1.txt  /opt/3.txt  #制作硬链接

[root@nb ~]# ls /opt
1.txt  2.txt  3.txt
[root@nb ~]# ls -i /opt       #i节点编号
33590532 1.txt  33582629 2.txt  33590532 3.txt

bc:计算器
[root@nb ~]# echo  1+6  |   bc
7
[root@nb ~]# echo 24*60*60  |  bc
86400
[root@nb ~]#

用户账号简介
作用: 1.可以登陆操作系统 2.不同的用户具备不同的权限
唯一标识：UID（编号从0开始的编号，默认最大60000）
zhangsan(UID 1200)
管理员root的UID：永远为0
普通用户的UID：默认从1000开始

组账号简介
作用: 方便管理用户
唯一标识：GID（编号从0开始的编号，默认最大60000）
原则：Linux一个用户必须至少属于一个组
组账户的分类：
基本组：一般情况与用户同名，一个用户必须有基本组，基本组只能有一个
附加组（从属组）：一个用户可以有多个附加组，也可以没有附加组

   useradd   tom
   组：tom   wudang   fudou  

/etc/passwd：存放用户基本信息配置文件
[root@localhost ~]# head -1  /etc/passwd   #显示文件第一行
root:x:0:0:root:/root:/bin/bash
用户名:密码占位符:UID:基本组GID:用户描述信息:家目录:解释器

[root@localhost ~]# useradd  wangwu  
[root@localhost ~]# grep  wangwu  /etc/passwd
用户名:密码占位符:UID:基本组GID:用户描述信息:家目录:解释器

创建新用户
– 格式：useradd [选项]... 用户名
• 常用命令选项
-u：指定 用户UID
-d：指定宿主目录（家目录），默认为 /home/用户名
-G：指定所属的附加组，-g指定基本组
-s：指定用户的登录解释器，默认为/bin/bash

-u：指定 UID 编号
[root@localhost ~]# useradd   nsd01  
[root@localhost ~]# ls   /home/    #查看家目录的产生
[root@localhost ~]# grep  nsd01   /etc/passwd   #查看nsd01信息
[root@localhost ~]# id  nsd01  #查看nsd01用户基本信息
[root@localhost ~]# id  gaga
id: gaga: no such user    #无此用户

[root@localhost ~]# useradd  -u  1500  nsd02  #指定UID创建用户
[root@localhost ~]# id   nsd02     #查看nsd02用户基本信息
[root@localhost ~]# grep   nsd   /etc/passwd   #查看用户信息
[root@localhost ~]# useradd   nsd03
[root@localhost ~]# grep   nsd    /etc/passwd
[root@localhost ~]# id   nsd03

-d：指定宿主目录（家目录），默认为 /home/用户名（不可以事先新建用户的家目录）
[root@localhost ~]# useradd  -d  /opt/nsd04   nsd04
[root@localhost ~]# grep   nsd04   /etc/passwd
[root@localhost ~]# ls  /opt/

[root@localhost ~]# useradd   -d  /opt/haha05   nsd05
[root@localhost ~]# grep  nsd05   /etc/passwd
[root@localhost ~]# ls   /opt/

-G：指定所属的附加组   -g：指定基本组 （了解一下）
[root@localhost ~]# groupadd   stugrp    #单独创建stugrp组
[root@localhost ~]# useradd  -G   stugrp   nsd06
[root@localhost ~]# id  nsd06

[root@localhost ~]# useradd  -G   stugrp   nsd07
[root@localhost ~]# id   nsd07
[root@localhost ~]# groupadd  tmooc  #单独创建tmooc组
[root@localhost ~]# useradd  -G  stugrp,tmooc  nsd11
[root@localhost ~]# id  nsd11

-s：指定用户解释器程序，默认/bin/bash
/sbin/nologin：禁止用户登录操作系统

]# useradd  -s  /sbin/nologin   nsd10
]# grep   nsd10    /etc/passwd
]# passwd  nsd10  #设置密码，密码没有屏幕显示，需要输入两次密码

]# useradd  -s  /sbin/nologin   nsd12
]# grep   nsd12   /etc/passwd

usermod命令
格式：usermod [选项]... 用户名
• 常用命令选项
-l：更改用户帐号的登录名称
-u：用户id
-d：家目录路径
-s：登录解释器
-G：附加组 #重置附加组

-l：更改用户帐号的登录名称

-u：用户id
-s：登录解释器
]# useradd   nsd13
]# id   nsd13
]# grep  nsd13  /etc/passwd
]# usermod  -l  stu13   nsd13      #修改用户名字
]# id  stu13
]# usermod  -u  1600   stu13     #修改用户的UID
]# id  stu13
]# usermod  -s   /sbin/nologin  stu13   #修改用户的解释器程序
]# grep  stu13  /etc/passwd

-d：家目录路径（默认不会自动创建新的家目录）
[root@localhost ~]# useradd   nsd16
[root@localhost ~]# grep  nsd16   /etc/passwd
[root@localhost ~]# ls   /home/

[root@localhost ~]# usermod   -md  /mnt/abc16   nsd16  #将用户原有的家目录进行移动，并且设置相应的权限
[root@localhost ~]# grep   nsd16   /etc/passwd
[root@localhost ~]# ls  /mnt

-G：修改用户的附加组    #重置附加组 （了解）
[root@localhost ~]# useradd   nsd17
[root@localhost ~]# id   nsd17
[root@localhost ~]# usermod  -G  stugrp   nsd17
[root@localhost ~]# id   nsd17
[root@localhost ~]# groupadd  tmooc   #创建组
[root@localhost ~]# usermod  -G  tmooc  nsd17
[root@localhost ~]# id   nsd17
[root@localhost ~]# groupadd  wudang   #创建组
[root@localhost ~]# usermod  -G  wudang,tmooc  nsd17
[root@localhost ~]# id   nsd17

切换用户身份
[root@nb ~]# passwd   nsd01
更改用户 nsd01 的密码 。  
新的 密码：                 #输入密码
无效的密码： 密码少于 8 个字符
重新输入新的 密码：    #重新输入密码
passwd：所有的身份验证令牌已经成功更新。
[root@nb ~]#  su  -  nsd01   #切换用户身份
[nsd01@nb ~]$ passwd
更改用户 nsd01 的密码 。
Current password:        #输入旧密码
新的 密码：          #输入新密码
重新输入新的 密码：   #重新输入一遍新密码
passwd：所有的身份验证令牌已经成功更新。
[nsd01@nb ~]$ exit

passwd命令，支持非交互式设置密码
--stdin：从标准输入（比如管道）取密码

]# echo  123   |   passwd  --stdin  nsd18
]# echo  123456   |   passwd  --stdin   nsd18
]# echo  redhat  |  passwd  --stdin   nsd18

/etc/shadow，保存密码字串/有效期等信息
每个用户记录一行，以：分割为9个字段
[root@localhost ~]# grep nsd01 /etc/shadow
上一次修改密码的时间：自1970-1-1到达上一次修改密码的时间，所经历的天数
字段1：用户帐号的名称
字段2：加密后的密码字符串
字段3：上次修改密码的时间
字段4：密码的最短有效天数，默认0
字段5：密码的最长有效天数，默认99999
字段6：密码过期前的警告天数，默认7
字段7：密码过期后多少天禁用此用户账号，默认值为空
字段8：帐号失效时间，默认值为空
字段9：保留字段（未使用）

主要的初始配置文件
~/.bashrc：每次进入新的Bash环境时执行(开启新的终端)
[root@localhost ~]# vim   /root/.bashrc  #定义永久别名
……
alias  hello='echo  您真帅'
……

开启新的终端进行测试：
[root@localhost ~]# hello

/etc/bashrc：全局配置文件，影响全体用户 (开启新的终端)
[root@localhost ~]# vim   /etc/bashrc
……
alias    myls='ls   -ld'
……

# 新开一个终端验证

[root@localhost ~]# useradd  nsd21
[root@localhost ~]# su  -  nsd21   #相当于开启新的终端
[nsd21@localhost ~]$ myls  /opt
[nsd21@localhost ~]$ exit
登出
[root@localhost ~]#

userdel命令
格式：userdel [-r] 用户名
添加 -r 选项，家目录/用户邮件也一并删除

[root@localhost ~]# userdel  -r  nsd18  #连同家目录一并删除
[root@localhost ~]# id  nsd18

[root@localhost ~]# userdel  nsd20  #不删除家目录，只删除用户信息
[root@localhost ~]# id  nsd20

组管理

[root@localhost ~]# groupadd    tarena    #新建一个组
[root@localhost ~]# grep  tarena  /etc/group   #查看组信息
tarena:x:1607:
组名字:密码占位符:GID:组成员列表  

[root@localhost ~]# useradd  kaka
[root@localhost ~]# useradd  nb
[root@localhost ~]# useradd  jack
[root@localhost ~]# useradd  kenji

gpasswd命令（添加附加组）
格式：gpasswd [选项]... 组名
•常用命令选项
-a：添加组成员，每次只能加一个
-d： 删除组成员，每次只能删一个
-M：定义(重置)组成员用户列表，可设置多个用户

]# gpasswd  -a   kaka   tarena    #添加用户kaka到tarena组
]# grep   tarena   /etc/group     #查看组信息
]# id   kaka
]# gpasswd   -a   nb   tarena    #添加用户nb到tarena组
]# grep    tarena   /etc/group
]# gpasswd  -M  'jack,kenji'   tarena    #定义组成员列表
]# grep   tarena   /etc/group
]# gpasswd   -a    nb   tarena   #添加用户nb到tarena组
]# grep  tarena   /etc/group
]# gpasswd   -d   nb  tarena    #将nb用户从tarena组中删除
]# grep   tarena    /etc/group
]# gpasswd   -M  ''      tarena    #删除组中所有成员
]# grep  tarena   /etc/group  

组管理员

-A：定义组管理员列表（组管理员可以属于此组也可以不属于此组）
[root@localhost ~]# su  -  nb
[nb@localhost ~]$ gpasswd  -a  kaka  tarena
gpasswd：没有权限。
[nb@localhost ~]$ exit
[root@localhost ~]# gpasswd  -A  nb  tarena  #设置组管理员
[root@localhost ~]# su  -  nb
[nb@localhost ~]$ gpasswd  -a  kaka  tarena
正在将用户“kaka”加入到“tarena”组中
[nb@localhost ~]$ exit
[root@localhost ~]#

/etc/gshadow：组的管理信息配置文件
[root@localhost ~]# grep   tarena  /etc/gshadow
tarena:!:nb:
组名:密码加密字符串:组的管理员列表:组成员列表

]# gpasswd   -A   'nb,kenji'  tarena  #设置多个组管理员
]# grep  tarena  /etc/gshadow

]# gpasswd   -A   ''   tarena   #删除所有的组管理员
]# grep  tarena   /etc/gshadow

总结：用户与组重要的配置文件
/etc/passwd:用户基本信息配置文件
/etc/shadow:用户密码信息配置文件
/etc/group:组基本信息配置文件
/etc/gshadow:组管理信息配置文件

总结：Linux系统执行useradd命令，会完成那些操作？
1.会在/etc/passwd增加一行信息
2.会在/etc/shadow增加一行信息
3.会在/home新增用户家目录
4.会在/var/spool/mail增加用户邮件文件
5.会在/etc/group增加一行组信息
6.会在/etc/gshadow增加一行组的管理信息

总结：Linux系统执行userdel -r命令，会完成那些操作？
1.会在/etc/passwd删除一行信息
2.会在/etc/shadow删除一行信息
3.会在/home删除用户家目录
4.会在/var/spool/mail删除用户邮件文件
5.会在/etc/group删除一行组信息
6.会在/etc/gshadow删除一行组的管理信息

删除组账号：删除组的时候，不可以删除基本组
[root@localhost ~]# groupdel   tarena
[root@localhost ~]# groupdel   tmooc
[root@localhost ~]# grep   tmooc  /etc/group
[root@localhost ~]# grep  tarena  /etc/group

任务书写格式：
   时间                    任务内容
分  时   日   月   周
5   8    ***
30   20***
*    *    *    *    *  
*/8*    ***  
*/6**    **  

30   */2*    **  

0   23    **5
0   23**    1-5
0   23    **    1,4,7

0   23    1   *    5

[root@nb ~]# date
[root@nb ~]# date   >>   /opt/time.txt  
[root@nb ~]# cat   /opt/time.txt  
[root@nb ~]# which  date
[root@nb ~]# crontab   -e    #编写计划任务
*/2*  **  *  /usr/bin/date  >>   /opt/time.txt
[root@nb ~]# crontab   -l     #查看计划任务内容
[root@nb ~]# cat   /opt/time.txt
[root@nb ~]# ls   /var/spool/cron   #任务文件存放的路径
[root@nb ~]# cat  /var/spool/cron/root   #记录root用户计划任务

获取命令的帮助信息
   方式一： --help
   方式二： man
[root@nb ~]# man  passwd
   上  下 键进行滚动
   按 q 键进行退出

[root@nb ~]# man 5 passwd

]# mkdir  -p  /cbd/iso
]# mount  /dev/cdrom   /cbd/iso
]# ls  /cbd/iso
]# rm  -rf  /etc/yum.repos.d/*
]# vim   /etc/yum.repos.d/iso.repo
[app]
baseurl=file:///cbd/iso/AppStream
gpgcheck=0
[base]
baseurl=file:///cbd/iso/BaseOS
gpgcheck=0
]# yum  -y  install   lftp    #安装软件测试

基本权限与归属
读取：允许查看内容-read r
写入：允许修改内容-write w
可执行：允许运行和切换-excute x

对于文本文件：
r读取权限：cat、less、grep、head、tail
w写入权限：vim、> 、 >>
x可执行权限：Shell与Python

对于目录：
r读取权限：ls命令查看目录内容
w写入权限：能够创建、删除、修改等目录的内容
x 执行权限：能够cd切换到此目录下（进入此目录）

归属关系
所有者(属主)：拥有此文件/目录的用户-user   u
所属组(属组)：拥有此文件/目录的组-group   g
其他用户：除所有者、所属组以外的用户-other   o

例如：zhangsan（所有者） zhangsan(所属组) 1.txt

执行 ls -l或者ls -ld 命令查看
以-开头：文本文件
以d开头：目录
以l开头：快捷方式
[root@localhost ~]# ls  -ld    /etc/
[root@localhost ~]# ls  -l      /etc/passwd
[root@localhost ~]# ls  -ld    /root
[root@localhost ~]# ls  -ld    /tmp       #有附加权限
[root@localhost ~]# ls  -l      /etc/shadow
[root@localhost ~]# useradd   zhangsan
[root@localhost ~]# ls   -ld    /home/zhangsan

Linux中判断用户具备的权限：

1. 查看用户，对于该数据所处的身份
2. 查看相应身份的权限位

chmod修改权限的命令

[root@localhost ~]# mkdir   /nsd10
[root@localhost ~]# ls   -ld   /nsd10
[root@localhost ~]# chmod   u-w    /nsd10    #所有者去掉w权限
[root@localhost ~]# ls -ld    /nsd10
[root@localhost ~]# chmod   u+w  /nsd10     #所有者加上w权限
[root@localhost ~]# ls  -ld   /nsd10
[root@localhost ~]# chmod   g+w   /nsd10     #所属组加上w权限
[root@localhost ~]# ls   -ld    /nsd10
[root@localhost ~]# chmod    g=r    /nsd10    #所属组重新定义权限
[root@localhost ~]# ls    -ld    /nsd10
[root@localhost ~]# chmod    a=rwx    /nsd10   #a表示所有人
[root@localhost ~]# ls   -ld     /nsd10
[root@localhost ~]# chmod  u=---,g=rx,o=rwx     /nsd10
[root@localhost ~]# ls   -ld   /nsd10

-R：递归修改权限
[root@localhost ~]# mkdir   -p   /opt/aa/bb/cc
[root@localhost ~]# chmod  -R   o=---   /opt/aa
[root@localhost ~]# ls   -ld     /opt/aa
[root@localhost ~]# ls   -ld     /opt/aa/bb
[root@localhost ~]# ls   -ld     /opt/aa/bb/cc

1）以root身份新建/dir目录，在此目录下新建readme.txt文件
[root@localhost ~]# mkdir  /dir
[root@localhost ~]# echo  123456   >  /dir/readme.txt
[root@localhost ~]# cat    /dir/readme.txt
2）使用户zhangsan能够修改readme.txt文件内容
[root@localhost ~]# chmod  o+w   /dir/readme.txt
3）使用户zhangsan不可以修改readme.txt文件内容
[root@localhost ~]# chmod  o-w   /dir/readme.txt

4）使用户zhangsan能够在此目录下创建/删除子目录
[root@localhost ~]# chmod  o+w   /dir/
5）调整此目录的权限，使任何用户都不能进入，然后测试用户zhangsan是否还能查看readme.txt内容（测试结果是不能，对父目录没有权限）
[root@localhost ~]# chmod  a-x   /dir/
6）为此目录及其下所有文档设置权限 rwxr-x---
[root@localhost ~]# chmod -R  u=rwx,g=rx,o=---   /dir

r----->4
w----->2
x----->1

rwx  = 421   7
rx  =  41   5
rx  =  41   5

[root@localhost ~]# mkdir   /nsd14
[root@localhost ~]# ls  -ld   /nsd14
[root@localhost ~]# chmod   700    /nsd14
[root@localhost ~]# ls   -ld   /nsd14
[root@localhost ~]# chmod   007   /nsd14
[root@localhost ~]# ls   -ld   /nsd14
[root@localhost ~]# chmod    750    /nsd14
[root@localhost ~]# ls   -ld   /nsd14
[root@localhost ~]# chmod    755    /nsd14
[root@localhost ~]# ls   -ld   /nsd14

chown修改归属关系
[root@localhost ~]# mkdir  /nsd15
[root@localhost ~]# ls -ld   /nsd15
[root@localhost ~]# groupadd   tmooc   #创建组tmooc
[root@localhost ~]# useradd  lisi     #创建用户lisi
[root@localhost ~]# chown   lisi:tmooc  /nsd15   #修改所有者与所属组
[root@localhost ~]# ls  -ld  /nsd15
[root@localhost ~]# chown   zhangsan   /nsd15   #仅修改所有者
[root@localhost ~]# ls   -ld   /nsd15
[root@localhost ~]# chown   :root  /nsd15     #仅修改所属组
[root@localhost ~]# ls   -ld    /nsd15

Linux中判断用户具备的权限：
1.查看用户，对于该数据所处的身份，顺序所有者> 所属组>其他人，原则是匹配即停止

2.查看相应身份的权限位

例如：

1.192.168.1.1可以进入

2.所有客户端不可以进入

例如：                 丁老师   牛老师
1.所有人不能进入
2.牛老师可以进入

1）利用root的身份新建/tarena目录，并进一步完成下列操作
[root@localhost ~]# mkdir  /tarena
2）将/tarena属主设为gelin01，属组设为tmooc组
[root@localhost ~]# useradd    gelin01
[root@localhost ~]# groupadd   tmooc
[root@localhost ~]# chown   gelin01:tmooc    /tarena
3）使用户gelin01对此目录具有rwx权限，除去所有者与所属组之外的用户对此目录无任何权限
[root@localhost ~]# chmod  o=---  /tarena
4）使用户gelin02能进入、查看此目录内容
[root@localhost ~]# useradd  gelin02
[root@localhost ~]# gpasswd  -a  gelin02  tmooc  #将用户加入到组
5）将gelin01加入tmooc组，将/tarena目录的权限设为450，测试gelin01用户能否进入此目录(匹配及停止原则，不能进入)
[root@localhost ~]# gpasswd  -a  gelin01  tmooc
[root@localhost ~]# chmod  450  /tarena

ACL策略：为特殊的人或者特殊的组，单独设置权限

Linux中判断用户具备的权限：
1.首先查看该用户或者组是否有ACL策略
2.查看用户，对于该数据所处的身份，顺序所有者>所属组>其他人，原则是匹配立即停止
3.查看相应身份的权限位

[root@localhost ~]# mkdir    /nsd19
[root@localhost ~]# chmod    770   /nsd19
[root@localhost ~]# ls   -ld   /nsd19
[root@localhost ~]# useradd  dc
[root@localhost ~]# su  -   dc
[dc@localhost ~]$ cd     /nsd19
-bash: cd: /nsd19: 权限不够
[dc@localhost ~]$ exit
[root@localhost ~]# setfacl   -m   u:dc:rx   /nsd19   #单独赋予dc用户权限
[root@localhost ~]# getfacl   /nsd19         #查看ACL策略
[root@localhost ~]# su  -   dc
[dc@localhost ~]$ cd    /nsd19
[dc@localhost ~]$ pwd
[dc@localhost ~]$ exit

setfacl [选项] u:用户名:权限 文件...

setfacl [选项] g:组名:权限 文件...

•常用命令选项
-m：修改ACL策略
-x：清除指定的ACL策略
-b：清除所有已设置的ACL策略
-R：递归设置ACL策略

[root@localhost ~]# mkdir     /nsd22
[root@localhost ~]# setfacl  -m  u:dc:rx    /nsd22
[root@localhost ~]# setfacl  -m  u:zhangsan:rwx    /nsd22
[root@localhost ~]# setfacl  -m  u:lisi:rx     /nsd22
[root@localhost ~]# setfacl  -m  u:gelin01:rwx    /nsd22
[root@localhost ~]# getfacl    /nsd22
[root@localhost ~]# setfacl   -x  u:zhangsan  /nsd22  #删除指定用户ACL
[root@localhost ~]# getfacl   /nsd22
[root@localhost ~]# setfacl   -x  u:dc   /nsd22     #删除指定用户ACL
[root@localhost ~]# getfacl   /nsd22
[root@localhost ~]# setfacl   -b   /nsd22    #清除目录所有ACL策略
[root@localhost ~]# getfacl    /nsd22

-R：递归设置ACL策略
[root@localhost ~]# setfacl  -Rm    u:dc:rwx    /opt/aa
[root@localhost ~]# getfacl   /opt/aa
[root@localhost ~]# getfacl   /opt/aa/bb
[root@localhost ~]# getfacl   /opt/aa/bb/cc

ACL策略-黑名单的使用（单独拒绝某些用户）
[root@localhost ~]# mkdir  /home/public
[root@localhost ~]# chmod  777  /home/public
[root@localhost ~]# setfacl  -m   u:lisi:---    /home/public
[root@localhost ~]# getfacl   /home/public

附加权限
•粘滞位，Sticky Bit 权限
–占用其他人（Other）的 x 位
–显示为 t 或 T，取决于其他人是否有 x 权限
–适用于目录，用来限制用户滥用写入权
–在设置了t权限的目录下，即使用户有写入权限，也不能删除或改名其他用户文档
[root@localhost ~]# mkdir    /nsd26
[root@localhost ~]# chmod  777    /nsd26
[root@localhost ~]# ls   -ld    /nsd26
[root@localhost ~]# chmod   o+t    /nsd26
[root@localhost ~]# ls   -ld    /nsd26

•Set GID权限（SGID权限）
–占用属组（Group）的 x 位
–显示为 s 或 S，取决于属组是否有 x 权限
–对目录有效
–在一个具有SGID权限的目录下，新建的文档会自动继承父目录的属组身份

[root@localhost ~]# mkdir   /nsd18
[root@localhost ~]# chown   :tmooc   /nsd18   #修改所属组
[root@localhost ~]# ls  -ld   /nsd18
[root@localhost ~]# chmod  g+s  /nsd18     #赋予SGID特殊权限
[root@localhost ~]# ls -ld    /nsd18
[root@localhost ~]# mkdir    /nsd18/abc01
[root@localhost ~]# ls   -ld   /nsd18/abc01
[root@localhost ~]# mkdir   /nsd18/abc02
[root@localhost ~]# ls   -ld  /nsd18/abc02
[root@localhost ~]# touch    /nsd18/1.txt
[root@localhost ~]# ls  -ld  /nsd18/1.txt

附加权限Set UID(SUID)权限（了解）
占用属主（User）的 x 位
显示为 s 或 S，取决于属主是否有 x 权限
仅对可执行的程序有意义
当其他用户执行带SUID标记的程序时，具有此程序属主的身份和相应权限
[root@localhost ~]# which mkdir
[root@localhost ~]# cp /usr/bin/mkdir  /usr/bin/hahadir
[root@localhost ~]# ls   -l    /usr/bin/hahadir
[root@localhost ~]# /usr/bin/hahadir    /opt/abc02
[root@localhost ~]# ls    /opt/
[root@localhost ~]# chmod   u+s   /usr/bin/hahadir
[root@localhost ~]# ls  -l   /usr/bin/hahadir
[root@localhost ~]# su  -  zhangsan
[zhangsan@localhost ~]$ /usr/bin/mkdir    zs01
[zhangsan@localhost ~]$ ls    -l
[zhangsan@localhost ~]$ /usr/bin/hahadir      zs02
[zhangsan@localhost ~]$ ls    -l

r    4
w   2
x   1

附加权限：了解
利用数字4表示suid      chmod  u+s
利用数字2表示sgid       chmod  g+s
利用数字1表示t           chmod  o+t

文件/目录的默认权限
• 新建文件/目录的默认权限
– 一般文件默认均不给 x 执行权限
– 其他取决于 umask(权限掩码) 设置
– 新建目录默认权限为755
– 新建文件默认权限为644
实现natasha用户新建数据，目录权限为700文件为600
[root@nb ~]# useradd  natasha
[root@nb ~]# vim   /home/natasha/.bashrc  #修改家目录配置文件
umask   077         #新增配置，指定权限掩码值

[root@nb ~]# su  -  natasha
[natasha@nb ~]$ umask
0077
[natasha@nb ~]$ mkdir    abc
[natasha@nb ~]$ ls   -ld   abc
drwx------. 2 natasha natasha 6 2月  23 17:27 abc
[natasha@nb ~]$ exit

[root@nb ~]# mkdir -m  777  /nsd34   #-m无视umask值创建数据指定数据的权限

[root@nb ~]# ls   -ld   /nsd34

[root@nb ~]# mkdir -m  757  /nsd35
[root@nb ~]# ls   -ld   /nsd35

手动建立用户家目录
/etc/skel是新建用户时，会以此目录作为模板建立用户家目录
]# useradd    kenji
]#  rm  -rf   /home/kenji
]# cp  -r    /etc/skel     /home/kenji
]# chown   -R   kenji:kenji   /home/kenji
]# chmod   700   /home/kenji
]# ls   -ld    /home/kenji
]# ls   -lA    /home/kenji
]# su  -  kenji
[kenji@localhost ~]$ pwd

常见故障：递归设置权限错误

[root@nb ~]#  mkdir  /nsd38
[root@nb ~]#  mkdir  /nsd38/haha
[root@nb ~]#  mkdir /nsd38/xixi
[root@nb ~]#  touch  /nsd38/1.txt
[root@nb ~]#  touch   /nsd38/2.txt
[root@nb ~]#  chmod   -R  000   /nsd38
[root@nb ~]#  ls  -ld   /nsd38
[root@nb ~]#  ls   -l   /nsd38
[root@nb ~]#  find   /nsd38   -type   d  -exec  chmod  755  {}   \;
[root@nb ~]#  ls   -l   /nsd38
[root@nb ~]#  find   /nsd38   -type  f  -exec  chmod  644   {}    \;
[root@nb ~]#  ls   -l   /nsd38

计算机容量单位：
一般用B，KB，MB，GB，TB，PB，EB，ZB，YB，BB来表示，它们之间的关系是：
1KB (Kilobyte 千字节)=1024B,
1MB (Megabyte 兆字节 简称“兆”)=1024KB，
1GB (Gigabyte 吉字节 又称“千兆”)=1024MB,
1TB (Terabyte 万亿字节 太字节)=1024GB,
1PB (Petabyte 千万亿字节 拍字节)=1024TB,
1EB (Exabyte 百亿亿字节 艾字节)=1024PB,
1ZB (Zettabyte 十万亿亿字节 泽字节)= 1024 EB,
1YB (Yottabyte 一亿亿亿字节 尧字节)= 1024 ZB,
1BB (Brontobyte 一千亿亿亿字节)= 1024 YB.

新硬盘空间使用：
  识别硬盘----》划分分区----》格式化----》挂载使用

一、识别硬盘
  lsblk
二、分区规划
分区模式：MBR、GPT
•MBR(msdos)分区模式
–分区类型：主分区、扩展分区(占用所有剩余空间)、逻辑分区
–最多只能有4个主分区
–扩展分区可以没有，至多有一个
–1~4个主分区，或者 3个主分区+1个扩展分区（n个逻辑分区）
–最大支持容量为 2.2TB 的磁盘
–扩展分区不能格式化，空间不能直接存储数据
–可以用于存储数据的分区：主分区与逻辑分区

fdisk分区工具
[root@localhost ~]# fdisk    /dev/vdb
n 创建新的分区----->分区类型 回车----->分区编号 回车---->第一个扇区 回车----->上个扇区 +2G
p 查看分区表
n 创建新的分区----->分区类型 回车----->分区编号 回车---->第一个扇区 回车----->上个扇区 +1G
w 保存并退出
[root@localhost ~]# lsblk
[root@localhost ~]# ls    /dev/vdb[1-2]

三、格式化：赋予空间文件系统的过程
文件系统：数据在空间中存储的规则

Windows：  NTFS     FAT

Linux：   ext4      xfs     FAT    NTFS（安装软件）

]#  mkfs.ext4   /dev/vdb1    #格式化文件系统ext4
]#  mkfs.xfs   /dev/vdb2     #格式化文件系统xfs

]#  blkid     /dev/vdb1    #查看文件系统类型
]#  blkid     /dev/vdb2     #查看文件系统类型

四、临时挂载使用
]#  mkdir   /mypart1
]#  mount   /dev/vdb1    /mypart1
]#  df   -h    /mypart1  #显示正在挂载设备的使用情况显示

]#  mkdir    /mypart2
]#  mount    /dev/vdb2    /mypart2
]#  df    -h     /mypart1    /mypart2
    #显示正在挂载的设备信息，使用情况的显示

总结：
 1.识别硬盘    lsblk
 2.分区规划    MBR    fdisk
 3.格式化     ext4    xfs    mkfs.ext4   mkfs.xfs   blkid
 4.挂载       mount     df  -h

永久挂载/etc/fstab(开机自动挂载配置文件)
设备       挂载点    文件系统类型     参数    备份标记   检测顺序

[root@localhost ~]# blkid  /dev/vdb1   #查看文件系统类型
[root@localhost ~]# blkid  /dev/vdb2   #查看文件系统类型
[root@localhost ~]# vim    /etc/fstab    #vmware虚拟机
/dev/sdb1   /mypart1   ext4    defaults   0   0
/dev/sdb2   /mypart2    xfs    defaults   0    0

[root@localhost ~]# vim    /etc/fstab    #KVM虚拟机
/dev/vdb1   /mypart1   ext4    defaults   0   0
/dev/vdb2   /mypart2    xfs    defaults   0   0
[root@localhost ~]# umount   /mypart1       #卸载
[root@localhost ~]# umount   /mypart2       #卸载
[root@localhost ~]# df  -h  |   grep  mypart  #没有输出
[root@localhost ~]# mount   -a
检测/etc/fstab开机自动挂载配置文件,格式是否正确
检测/etc/fstab中,书写完成,但当前没有挂载的设备,进行挂载
[root@localhost ~]# df  -h  |    grep  mypart  #有输出

[root@localhost ~]# fdisk   /dev/vdb  
p 查看分区表
n 创建主分区--->回车--->回车--->回车--->上个扇区 +2G
p 查看分区表
n 创建主分区--->p回车 --->起始回车--->结束回车   将所有剩余空间给最后一个分区
p 查看分区表
w 保存并退出
[root@localhost ~]# lsblk

[root@localhost ~]# fdisk   /dev/vdc
p 查看分区表
n 创建主分区--->回车--->回车--->回车--->结束 +2G
n 创建主分区--->回车--->回车--->回车--->结束 +2G
n 创建主分区--->回车--->回车--->回车--->结束 +2G
p 查看分区表
n 创建扩展分区 --->回车--->起始回车--->结束回车   将所有剩余空间给扩展分区
p 查看分区表
n 创建 逻辑分区----->起始回车------>结束 +2G
n 创建 逻辑分区----->起始回车------>结束 +2G
n 创建 逻辑分区----->起始回车------>结束 回车
p 查看分区表
w 保存并退出
[root@localhost ~]# lsblk

[root@nb ~]# mkfs.xfs  /dev/sdc5
[root@nb ~]# blkid  /dev/sdc5
[root@nb ~]# vim   /etc/fstab
 /dev/sdc5   /mypart5   xfs   defaults  0 0
[root@nb ~]# mkdir   /mypart5
[root@nb ~]# mount  -a
[root@nb ~]# df  -h  /mypart5
文件系统        容量  已用  可用 已用% 挂载点
/dev/sdc5       2.0G   47M  2.0G    3% /mypart5

/dev/sdc5: 第三块SCSI接口的硬盘，第五个分区
/dev/sdc5: 第三块SCSI接口的硬盘，第一个逻辑分区

•GPT，GUID Partition Table
–全局唯一标识分区表
–突破固定大小64字节的分区表限制
–可支持4个以上的主分区，最大支持18EB容量
** 1 EB = 1024 PB = 1024 x 1024 TB

[root@nb ~]# fdisk   /dev/vdd
命令(输入 m 获取帮助)：g        #指定分区模式为GPT
已创建新的 GPT 磁盘标签(GUID: 348005B1-3C57-FE4B-A4FF-3822A8ACD6AA)。
命令(输入 m 获取帮助)：n
分区号 (1-128, 默认  1):    回车
第一个扇区 (2048-41943006, 默认 2048): 回车
上个扇区，+sectors 或 +size{K,M,G,T,P} (2048-41943006, 默认 41943006): +2G

命令(输入 m 获取帮助)：n
分区号 (2-128, 默认  2):    回车
第一个扇区 (2048-41943006, 默认 2048): 回车
上个扇区，+sectors 或 +size{K,M,G,T,P} (2048-41943006, 默认 41943006): +2G
命令(输入 m 获取帮助)： w
[root@nb ~]# lsblk

[root@nb ~]# mkfs.xfs  /dev/sdd1
[root@nb ~]# blkid  /dev/sdd1
[root@nb ~]# vim   /etc/fstab
 /dev/sdd1   /abc01/dcc   xfs   defaults  0 0

[root@nb ~]# mkdir  -p  /abc01/dcc
[root@nb ~]# mount  -a
[root@nb ~]# df  -h  /abc01/dcc

交换空间（虚拟内存）使用
  作用：缓解物理内存的压力     /dev/sdd2  交换分区

  CPU----》内存-----》硬盘    分区

]#  ls    /dev/vdd2
]#  mkswap   /dev/vdd2    #格式化交换文件系统
]#  blkid     /dev/vdd2      #查看文件系统类型
]#  swapon                  #查看交换空间组成的成员信息
]#  swapon   /dev/vdd2     #启用交换分区
]#  swapon                 #查看交换空间组成的成员信息
]#  free  -h              #查看交换空间的大小
]#  swapoff    /dev/vdd2        #停用交换分区
]#  swapon                #查看交换空间组成的成员信息
]#  free   -h                 #查看交换空间的大小

开机自动启用交换分区
[root@localhost ~]# vim    /etc/fstab   #增加一行信息
/dev/vdd2   swap    swap     defaults  0   0

[root@localhost ~]# swapon  #查看交换空间组成的成员信息

[root@localhost ~]# swapon  -a   #专门检测交换分区的书写

[root@localhost ~]# swapon  #查看交换空间组成的成员信息

parted(了解)分区的工具

补充命令partprobe刷新分区表（缘分）

真机为Linux系统：真机空间不够

KVM虚拟机化：一切皆文件，真机会创建一个大文件，充当虚拟机的硬盘

需要管理员手动删除对应的硬盘文件

环境准备：添加一块新的80G硬盘
[root@localhost ~]# poweroff
[root@localhost ~]# lsblk
80G硬盘进行（MBR分区模式）规划分区
划分3个10G的主分区;一个扩展分区，2个20G的逻辑分区
[root@localhost ~]# fdisk   /dev/sdb

[root@localhost ~]# lsblk
逻辑卷
作用：1.整合分散的空间 2.空间支持扩大
逻辑卷制作过程：将众多的物理卷（PV）组建成卷组（VG），再从卷组中划分出逻辑卷（LV）

建立卷组（VG）
格式：vgcreate 卷组名 设备路径…….
Successfully:成功        example：例子
[root@localhost ~]# man   vgcreate     #参考帮助信息 按q退出

[root@localhost ~]# vgcreate  systemvg   /dev/vdb[1-2]
[root@localhost ~]# pvs      #查看系统所有物理卷信息
[root@localhost ~]# vgs     #查看系统卷组信息  

建立逻辑卷（LV）
格式: lvcreate -L 大小G -n 逻辑卷名字 卷组名
[root@localhost ~]# lvcreate   -L  16G   -n  vo    systemvg
[root@localhost ~]# vgs    #查看卷组信息
[root@localhost ~]# lvs     #查看逻辑卷信息

使用逻辑卷
]# ls   /dev/systemvg/vo
]# ls -l    /dev/systemvg/vo

]# mkfs.xfs    /dev/systemvg/vo    #格式化xfs文件系统
]# blkid   /dev/systemvg/vo   #查看文件系统类型
]# vim  /etc/fstab
/dev/systemvg/vo   /mylv    xfs   defaults  0   0
]# mkdir    /mylv
]# mount   -a       #检测fstab文件内容书写是否正确
]# df    -h    /mylv    #查看查看正在挂载使用的设备

扩展逻辑卷
卷组有足够的剩余空间

1.扩展逻辑卷的空间
]# df   -h   |   grep   vo
]# vgs
]# lvextend    -L   18G    /dev/systemvg/vo
]# vgs
]# lvs
2.扩展逻辑卷的文件系统（刷新文件系统）
xfs_growfs：刷新xfs文件系统
resize2fs：刷新ext4文件系统
]# xfs_growfs  /dev/systemvg/vo
]# df   -h   |   grep   vo
]# lvs

卷组没有足够的剩余空间
1.扩展卷组的空间
]# vgextend    systemvg     /dev/vdb{3,5,6}
]# vgs
2.扩展逻辑卷的空间
]# vgs
]# lvextend    -L    25G     /dev/systemvg/vo
]# vgs
]# df   -h   |     grep   vo
3.扩展逻辑卷的文件系统（刷新文件系统）
]# xfs_growfs   /dev/systemvg/vo
]# df   -h    |    grep    vo

逻辑卷支持缩减
xfs文件系统：不支持缩减
ext4文件系统：支持缩减

卷组划分空间的单位PE    4M
请划分一个逻辑卷lvredhat大小为250M
[root@nb ~]# vgchange -s  1M  systemvg
  Volume group "systemvg" successfully changed
[root@nb ~]# lvcreate -L 250M  -n lvredhat systemvg
  Logical volume "lvredhat" created.
[root@nb ~]# lvs | grep redhat

逻辑卷的删除
删除逻辑卷的前提：不能删除正在挂载使用的逻辑卷
[root@localhost ~]# lvremove  /dev/systemvg/vo
  Logical volume systemvg/vo contains a filesystem in use.
[root@localhost ~]# umount   /mylv/
[root@localhost ~]# lvremove  /dev/systemvg/vo
Do you really want to remove active logical volume systemvg/vo? [y/n]: y
  Logical volume "vo" successfully removed
[root@localhost ~]# lvs      #查看当前系统的所逻辑卷
[root@localhost ~]# vim /etc/fstab  #仅删除vo开机自动挂载

[root@nb ~]# lvremove -y  /dev/systemvg/*
[root@nb ~]# lvs
[root@nb ~]# vgs

删除卷组的前提：基于此卷组创建的所有逻辑卷，要全部删除
[root@svr1 ~]# lvs
[root@svr1 ~]# vgremove  systemvg    #删除卷组
[root@svr1 ~]# vgs        #查看当前系统的所有卷组信息
[root@svr1 ~]# pvremove   /dev/vdb{1,2,3,5,6}
[root@svr1 ~]# pvs      #查看当前系统的所有物理卷信息

进程管理
  程序：静态没有执行的代码  硬盘空间

什么是进程:动态执行的代码    内存与CPU

   进程名   PID     父进程与子进程    树型结构

systemd：所有进程的父进程（上帝进程）
pstree查看进程(Processes Tree)
•常用命令选项
-p：列出对应进程的PID编号
-a：显示完整的命令行
[root@localhost ~]# pstree      #显示正在运行的所有进程
[root@localhost ~]# pstree  -p lisi   #显示lisi用户开启的进程
bash(9609)───vim(9656)
[root@localhost ~]# pstree  -a  lisi
bash
  └─vim haha.txt
[root@localhost ~]# pstree  -ap  lisi

ps — Processes Snapshot
–格式：ps [选项]...
•常用命令选项
aux：显示当前终端所有进程（a）、当前用户在所有终端下的进程（x）、以用户格式输出（u）
-elf：显示系统内所有进程（-e）、以长格式输出（-l）信息、包括最完整的进程信息（-f）

• ps aux 操作
– 列出正在运行的所有进程，显示进程信息非常详细
用户 进程ID  %CPU  %内存  虚拟内存  固定内存 终端  状态  起始时间 CPU时间  程序指令

• ps -elf 操作
–列出正在运行的所有进程，显示进程父进程信息
–PPID为父进程的PID
[root@localhost ~]# ps  aux   |   wc   -l   #正在运行的进程有多少个
[root@localhost ~]# ps   -elf   |   wc   -l
[root@localhost ~]# ps  aux
[root@localhost ~]# ps   -elf

僵尸进程：
僵尸进程是当子进程比父进程先结束，而父进程没有回收子进程，此时子进程会成为僵尸进程

1.通过ps命令找到僵尸进程(状态为Z)  ps  aux
2.杀死僵尸进程：找到僵尸进程的父进程进行杀死    ps  -elf

top 动态的查看工具
–格式：top [-d 刷新秒数] [-U 用户名]
[root@localhost ~]# top   -d   1
按大写P进行CPU排序
按大写M进行内存排序

pgrep — Process Grep
–用途：pgrep [选项]... 查询条件
•常用命令选项
-l：输出进程名，而不仅仅是 PID
-u：检索指定用户的进程
-x：精确匹配完整的进程名

]# pgrep    -l    sys  #显示进程名包含sys的进程
]# pgrep   -u   lisi     #显示lisi用户开启的进程
]# pstree   -p   lisi     #显示lisi用户开启的进程

]# top    -d   1    #显示进行信息，每隔1秒刷新
按大写P进行CPU排序
按大写M进行内存排序
按q进行退出

]# pgrep  -x   crond   #精确匹配完整的进程名
]# pgrep  -lx   crond

进程前后台调度
[root@localhost ~]# sleep 2000
^Z                 #按Ctrl+z  暂停放入后台
[1]+  已停止               sleep 2000
[root@localhost ~]# jobs    #查看后台进程信息
[1]+  已停止               sleep 2000
[root@localhost ~]# bg 1     #让后台编号为1 的进程继续运行
[1]+ sleep 2000 &
[root@localhost ~]# jobs
[1]+  运行中               sleep 2000 &
[root@localhost ~]# fg 1     #让后台编号为1 的进程恢复到前台
sleep 2000
^C               #按Ctrl+c   结束
[root@localhost ~]# sleep  3000  &   #正在运行放入后台
[1] 35470
[root@localhost ~]# jobs
[1]+  运行中               sleep 3000 &
[root@localhost ~]#  

真机Linux：
]$ ls  /linux-soft/s1
]$ sudo  tar -xf  /linux-soft/s1/tools.tar.gz   -C  /
]$ sudo  ls  /tools

]$ sudo rpm  -ivh   /tools/other/oneko*
]$ oneko  #运行程序
^Z                 #按Ctrl+z  暂停放入后台
]$ jobs
]$ bg  1   #让后台编号为1 的进程继续运行
]$ jobs

干掉进程的不同方法
–Ctrl+c 组合键，中断当前命令程序
–kill [-9] PID... 、kill [-9] %后台任务编号
–killall [-9] 进程名...
–pkill [-9] 查找条件  #包含就算

[root@localhost ~]# sleep 3000 &
[1] 35490
[root@localhost ~]# sleep 3000 &
[2] 35491
[root@localhost ~]# jobs
[1]-  运行中               sleep 3000 &
[2]+  运行中               sleep 3000 &
[root@localhost ~]# killall -9 sleep
[1]-  已杀死               sleep 3000
[2]+  已杀死               sleep 3000
[root@localhost ~]#

sudo提权：让普通用户可以具备root身份执行某些操作
[root@nb ~]# visudo     #此方式可以检查语法错误
bob            ALL=(root)      NOPASSWD:/usr/bin/mkdir,/usr/bin/cat
普通用户   所有的主机=(变成的身份)     可以执行的命令程序
....此处省略一万字.....
[root@nb ~]# useradd    bob
[root@nb ~]# echo   123  |    passwd   --stdin   bob
[root@nb ~]# su  -   bob
[bob@nb ~]$ sudo  -l       #查看提权的命令
............
[sudo] bob 的密码：   #输入bob用户的密码
[bob@nb ~]$ cat    /etc/gshadow
cat: /etc/gshadow: 权限不够
[bob@nb ~]$ sudo   cat   /etc/gshadow
[bob@nb ~]$ exit

无需密码验证
[root@nb ~]# visudo     #此方式可以检查语法错误
bob            ALL=(root)      NOPASSWD:/usr/bin/mkdir,/usr/bin/cat
普通用户   所有的主机=(变成的身份)     可以执行的命令程序
....此处省略一万字.....
[root@nb ~]# su  -   bob

[bob@nb ~]$ sudo  -l       #查看提权的命令
[bob@nb ~]$ sudo   cat   /etc/gshadow
[bob@nb ~]$ exit

提权组
[root@nb ~]# visudo     #此方式可以检查语法错误
%wudang          ALL=(root)      NOPASSWD:/usr/bin/cat
普通用户   所有的主机=(变成的身份)     可以执行的命令程序
....此处省略一万字.....
[root@nb ~]# groupadd  wudang
[root@nb ~]# useradd  -G  wudang   jack
[root@nb ~]# su  -   jack
[jack@nb ~]$ sudo   cat   /etc/gshadow
[jack@nb ~]$ exit

]# mkdir  -p  /dcc/tc
]# mount  /dev/cdrom   /dcc/tc
]# ls  /dcc/tc
]# rm  -rf  /etc/yum.repos.d/*
]# vim   /etc/yum.repos.d/iso.repo
[app]
baseurl=file:///dcc/tc/AppStream
gpgcheck=0
[base]
baseurl=file:///dcc/tc/BaseOS
gpgcheck=0
]# yum  -y  install   lftp    #安装软件测试

构建Yum仓库
[root@nb ~]# mkdir   /mydvd
[root@nb ~]# mount  /dev/cdrom   /mydvd
mount: /mydvd: WARNING: device write-protected, mounted read-only.
[root@nb ~]# ls  /mydvd
AppStream  EFI     isolinux  media.repo
BaseOS     images  LICENSE   TRANS.TBL
[root@nb ~]# rm -rf /etc/yum.repos.d/*
[root@nb ~]# vim  /etc/yum.repos.d/mydvd.repo
[app]
baseurl=file:///mydvd/AppStream
gpgcheck=0
[base]
baseurl=file:///mydvd/BaseOS
gpgcheck=0
[root@nb ~]# yum -y install httpd

]# blkid  /dev/cdrom   #查看 光驱设备文件系统类型
]# vim   /etc/fstab   #添加一行配置
/dev/cdrom   /mydvd   iso9660   defaults   0  0

]# umount   /mydvd  
]# ls   /mydvd
  
]# mount  -a     #进行检测
]# ls   /mydvd

[root@localhost ~]# df  -h  /boot  #查看设备挂载情况
[root@localhost ~]# blkid  /dev/vda1

[root@localhost ~]# vim    /etc/fstab    #vmware虚拟机
/dev/sda1    /boot        xfs     defaults        0 0

[root@localhost ~]# vim   /etc/fstab    #KVM虚拟机
/dev/vda1   /boot       xfs     defaults        0 0

[root@localhost ~]# reboot    #重启系统

[root@nb ~]# hostnamectl  set-hostname  nsd2312.tedu.cn
[root@nb ~]# hostname
nsd2312.tedu.cn

网卡IP地址设置
修改网卡命名规则
]# ifconfig   |    head    -2
ens33: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        ether 00:0c:29:8a:72:4f  txqueuelen 1000  (Ethernet)
]# vim   /etc/default/grub      #内核引导文件
……..此处省略一万字
GRUB_CMDLINE_LINUX="……quiet   net.ifnames=0  biosdevname=0"
……此处省略一万字
]# grub2-mkconfig  -o  /boot/grub2/grub.cfg  #重新生成网卡命名的规则
]# reboot      #重启系统
]# ifconfig   |   head   -2
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500

IP设置方式：nmcli    nmtui    修改网卡配置文件

 nmcli方式：  原则：必须为网卡再起一个名字
               网卡本名是什么，起的外号还叫什么

          eth0    -------》 eth0
          eth1    -------》 eth1

]# nmcli  connection  show   #查看nmcli网络的命名

]# nmcli connection delete  ens33    #删除
成功删除连接 "ens33" (ab537c88-4f9b-4036-8dc3-a461aabd834b)。
]# nmcli  connection  show

nmcli命令的网卡命名，添加新的网络命名
[root@server ~]# nmcli connection  add  type  ethernet      ifname  eth0    con-name   eth0

解析： nmcli connection 添加   类型   以太网设备
网卡设备名为eth0    nmcli命令的命名为eth0

[root@server ~]# nmcli   connection   show

]# nmcli connection  add  type  ethernet      ifname  eth0         con-name   eth0

]# nmcli connection modify eth0
ipv4.method manual
ipv4.addresses  192.168.100.1/24
ipv4.gateway 192.168.100.200 autoconnect yes

    ]# nmcli connection up  eth0   #激活配置
]# ifconfig  |  head  -2

]# nmcli connection delete  ens33    #删除

]# nmcli connection modify eth0
ipv4.method manual
ipv4.addresses  192.168.200.1/24
ipv4.gateway 192.168.200.200 autoconnect yes

    ]# nmcli connection up  eth0   #激活配置
]# ifconfig  |  head  -2

]# nmcli connection modify eth0 ipv4.addresses  192.168.200.10/24
    ]# nmcli connection up  eth0   #激活配置

]# ifconfig  |  head  -2

]# nmcli connection   show
]# nmcli connection  add  type  ethernet      ifname  eth1         con-name   eth1

]# nmcli connection   show
]# nmcli connection modify eth1
ipv4.method manual
ipv4.addresses  192.168.10.20/24
autoconnect yes

    ]# nmcli connection up  eth1   #激活配置
]# ifconfig  eth1  |  head  -2

nmtui(娱乐)

修改网卡配置文件

利用nmcli修改IP地址、子网掩码
[root@server ~]# nmcli connection modify  eth0
ipv4.method    manual
ipv4.addresses   192.168.88.240/24
autoconnect    yes

[root@server ~]# nmcli connection up eth0     #激活
[root@server ~]# ifconfig   |   head   -2

克隆虚拟机

虚拟机B：
]# hostnamectl  set-hostname   pc2.tedu.cn
]# hostname
新开一个终端进行查看主机名
[root@pc2 ~]# nmcli  connection  modify  eth0 ipv4.method  manual  ipv4.addresses  192.168.88.2/24 autoconnect   yes
[root@pc2 ~]# nmcli connection up eth0
[root@pc2 ~]# ifconfig   |   head   -2

虚拟机C：  主机名要求:pc3.tedu.cn   IP地址为:192.168.88.3/24

通信测试之后，拍摄快照

Linux远程管理Linux
SSH协议（远程管理协议），Secure Shell

1.支持远程管理的软件
[root@nsd2312 ~]# rpm -qa  |  grep openssh
openssh-askpass-8.0p1-13.el8.x86_64
openssh-8.0p1-13.el8.x86_64
openssh-clients-8.0p1-13.el8.x86_64
openssh-server-8.0p1-13.el8.x86_64

进行远程管理
虚拟机A(模板机器)
[root@server /]#  ssh    root@192.168.88.2
………necting (yes/no)? yes
root@192.168.88.2's password:        #输入密码
[root@pc2 ~]# touch   /root/hahaxixi.txt
[root@pc2 ~]# exit
登出
Connection to 192.168.88.2 closed.

[root@server /]# cat   /root/.ssh/known_hosts  #记录曾经远程管理的机器

数据传递工具 scp=ssh+cp
scp [-r] 用户名@服务器:路径     本地路径
scp [-r] 本地路径    用户名@服务器:路径
虚拟机A：
]# scp    /etc/passwd       root@192.168.88.2:/root
]# scp  -r    /home       root@192.168.88.2:/root
]# scp    root@192.168.88.2:/etc/shadow        /mnt

虚拟机B：
]# ls    /root

无密码远程管理
虚拟机A：
1.生成公钥(锁)与私钥(钥匙)进行验证
[root@server ~]# ssh-keygen      #一路回车
…….save the key (/root/.ssh/id_rsa):   #回车 设置默认保存位置
……..assphrase):     #回车 设置密码为空
…….. again:     #回车 设置密码为空
[root@server ~]# ls   /root/.ssh/
id_rsa(私钥)    id_rsa.pub(公钥)     known_hosts
2.虚拟机A将公钥(锁)传递给虚拟机B
[root@server ~]# ssh-copy-id     root@192.168.88.2
[root@server ~]# ssh     root@192.168.88.2     #测试无密码
[root@pc2 ~]# exit
登出
Connection to 192.168.88.2 closed.
[root@server ~]#
虚拟机B
[root@pc2 ~]# ls    /root/.ssh/
authorized_keys(别的机器传递过来的公钥)    known_hosts
[root@pc2 ~]#

真机上定义永久别名
[student@localhost ~]$  vim   /home/student/.bashrc
alias   goa='ssh     root@192.168.88.240'
alias   gob='ssh     root@192.168.88.2'
alias   goc='ssh     root@192.168.88.3'
开启新的终端进行验证

真机windows进行远程管理

ip命令（Linux最基础的命令）
1.查看IP地址
[root@server ~]# ip  address   show
[root@server ~]# ip   a    s  |  less
2.临时添加IP地址
]# ip address add 192.168.100.1/24 dev  eth0
]# ip   a   a   192.168.200.1/24   dev  eth0
]# ip  a  s
3.删除临时IP地址
]# ip  address  del  192.168.100.1/24   dev    eth0
]# ip   a   s

-c：指定ping包个数
[root@nsd2312 ~]# ping  -c 2 192.168.88.2
[root@nsd2312 ~]# ping  -c 4 192.168.88.2

[root@server /]# users
[root@server /]# who
 pts：图形命令行终端

[root@server /]# last          #登录成功的用户
[root@server /]# lastb        #登录失败的用户

虚拟机A
[root@server /]# getenforce  #查看当前运行模式
Enforcing
[root@server /]# setenforce 0  #修改当前运行模式
[root@server /]# getenforce
Permissive
[root@server /]# vim    /etc/selinux/config  
SELINUX=permissive      #需改配置
虚拟机B：同上
虚拟机C：同上

破解root的密码
必须是服务器的管理者，涉及服务器重新启动系统
思路：进入救援模式，进行密码重新设置

1)重启系统
2)在此界面按e键
在linux开头的该行，将此行的ro修改为rw 然后空格输入 rd.break
按 ctrl x 启动，会看到switch_root:/#

3）切换到硬盘操作系统环境

# chroot    /sysroot   #切换环境，切换到硬盘操作系统的环境

4)重新设置root的密码
sh-4.2# echo   1    |    passwd   --stdin    root
5)如果SELinux是强制模式，才需要SELinux失忆，其他模式不需要让SELinux进行失忆
sh-4.2# touch   /.autorelabel    #让SELinux失忆
或者可以修改SELinux运行模式，修改成宽松模式即可
sh-4.2# vim  /etc/selinux/config #查看SELinux开机的运行模式
6)强制重启系统完成修复
sh-4.2# reboot   -f     #-f强制重启系统 才能

密码防护（了解）
1.设置救援模式密码
[root@A ~]# grub2-setpassword
Enter password:     #输入密码，密码不显示
Confirm password:   #重新输入密码，密码不显示

[root@A ~]# cat /boot/grub2/user.cfg #存放grub密码的文件

Web服务器
  Web服务：提供精美的页面内容的服务
  安装软件：httpd、Nginx、tomcat
  http协议：超文本传输协议

daemon(守护神)
英 [ˈdiːmən] 美 [ˈdiːmən]
n.(古希腊神话中的)半神半人精灵
  默认存放网页文件的路径：/var/www/html
  网页文件的名字:index.html

虚拟机A：
[root@nsd2312 ~]# rpm  -q  httpd
[root@nsd2312 ~]# vim  /var/www/html/index.html
haha xixi 阳光明媚！

[root@nsd2312 ~]# /usr/sbin/httpd
[root@nsd2312 ~]# pgrep  -l httpd
[root@nsd2312 ~]# curl   192.168.88.240

FTP服务：共享目录数据
实现软件：vsftpd
默认共享数据主目录:/var/ftp

虚拟机A
[root@nsd2312 /]# yum -y install vsftpd
[root@nsd2312 /]# vim  /etc/vsftpd/vsftpd.conf
anonymous_enable=YES  #修改配置，开启无需密码验证功能

[root@nsd2312 /]# rpm -ql  vsftpd |  grep  bin
[root@nsd2312 /]# /usr/sbin/vsftpd
[root@nsd2312 /]# pgrep -l vsftpd

[root@nsd2312 /]# touch /var/ftp/dcc.txt
[root@nsd2312 /]# ls /var/ftp/
dcc.txt  pub
[root@nsd2312 /]# curl  ftp://192.168.88.240

防火墙服务(了解)
  作用：隔离，严格过滤入站，放行出站

firewalld防火墙---》iptables

public：仅允许访问本机的ssh、dhcp、ping服务
trusted：允许任何访问
block：拒绝任何来访请求，明确拒绝客户端
drop：丢弃任何来访的数据包，不给任何回应

•防火墙判定原则：
1.查看客户端请求中来源IP地址，查看自己所有区域中规则，那个区域中有该源IP地址规则，则进入该区域

2.进入默认区域（默认情况下为public）

防火墙默认区域的修改
虚拟机A
]# firewall-cmd    --get-default-zone   #查看默认区域
虚拟机B
]# curl      192.168.88.240    #失败
]# curl      ftp://192.168.88.240      #失败
]# ping    -c2    192.168.88.240        #成功

虚拟机A：修改默认区域
]# firewall-cmd   --set-default-zone=trusted
虚拟机B
]# curl      192.168.88.240    #成功
]# curl      ftp://192.168.88.240    #成功

虚拟机A：添加允许的协议
]# firewall-cmd  --set-default-zone=public     #修改默认区域
]# firewall-cmd  --zone=public  --add-service=http    #添加允许的协议
]# firewall-cmd   --zone=public   --list-all
虚拟机B
]# curl   192.168.88.240    #成功
]# curl   ftp://192.168.88.240     #失败

虚拟机A：添加允许的协议
]# firewall-cmd    --zone=public  --add-service=ftp   #添加允许的协议
]# firewall-cmd   --zone=public  --list-all
虚拟机B
]# curl   192.168.88.240    #成功
]# curl   ftp://192.168.88.240    #成功

防火墙public区域添加规则（永久）
-永久（--permanent  破门能它）
]# firewall-cmd   --reload    #加载防火墙永久策略
]# firewall-cmd   --zone=public    --list-all

]# firewall-cmd    --permanent --zone=public   --add-service=http   #永久添加http协议

]# firewall-cmd   --permanent  --zone=public    --add-service=ftp    #永久添加ftp协议

]# firewall-cmd   --reload    #加载防火墙永久策略
]# firewall-cmd   --zone=public   --list-all

三台机器卸载防火墙软件
]# yum -y remove firewalld

服务管理（运行程序的管理）

手动方式：
/usr/sbin/httpd     启动服务
    killall   httpd       停止服务
systemd方式：
  用户--systemctl--》systemd--服务启动配置文件--》httpd程序

systemctl  restart    服务名    #重起服务
systemctl   start     服务名      #开启服务
systemctl   stop     服务名      #停止服务
systemctl   status    服务名      #查看服务当前的状态
systemctl  enable   服务名     #设置服务开机自启动
systemctl   disable   服务名      #设置服务禁止开机自启动
systemctl   is-enabled  服务名    #查看服务是否开机自启

]# yum -y install httpd
]# killall   httpd       #杀死手动启动的httpd
]# systemctl  restart  httpd    #重启httpd服务
]# systemctl  status  httpd     #查看服务httpd状态
]# systemctl  enable  httpd    #设置httpd开机自启动
Created symlink from /etc/systemd/system/multi-user.target.wants/httpd.service to /usr/lib/systemd/system/httpd.service.
]# systemctl  is-enabled httpd #查看httpd是否是开机自启动
]# systemctl disable  httpd    #关闭httpd开机自启动
Removed symlink /etc/systemd/system/multi-user.target.wants/httpd.service.
]# systemctl  is-enabled httpd #查看httpd是否是开机自启动

5与6系列:运行级别 300服务
0：关机 0个服务 相当于poweroff
1：单用户模式（基本功能的实现，破解Linux密码） 50个服务
2：多用户字符界面（不支持网络） 80个服务
3：多用户字符界面（支持网络）服务器默认运行级别 100个服务
4：未定义 0个服务
5：图形界面  300个服务
6：重启 0个服务 相当于reboot
切换运行级别：init 数字
[root@nsd2312 /]# init  3
[root@nsd2312 /]# init  5

7与8、9系列：运行模式（运行级别）
字符模式：multi-user.target
图形模式：graphical.target
当前直接切换到字符模式
]# systemctl isolate multi-user.target #相当于原来的init  3
当前直接切换到图形模式
]# systemctl  isolate  graphical.target #相当于原来的init  5

查看每次开机默认进入模式
]# systemctl    get-default

设置永久策略，每次开机自动进入字符模式
]# systemctl   set-default   multi-user.target
]# reboot

环境准备
所有虚拟机设置SELinux运行模式
[root@server ~]# getenforce
Enforcing
[root@server ~]# setenforce 0  #当前设置
[root@server ~]# getenforce
Permissive
[root@server ~]# vim   /etc/selinux/config
SELINUX=permissive
所有虚拟机设置防火墙（停止防火墙服务）
[root@server ~]# yum  -y  remove  firewalld
[root@server ~]# rpm   -q  firewalld

虚拟机A：模板机器
]# yum  -y  install  httpd
]# echo  NSD Web Server > /var/www/html/index.html
]# cat  /var/www/html/index.html

]# systemctl   restart   httpd
]# curl  192.168.88.240

  Apache软件基金会 组织----》httpd 软件

修改服务的功能：/etc/httpd/conf/httpd.conf
DocumentRoot: 指定网页文件存放路径（默认/var/www/html）
虚拟机A
]# mkdir   /var/www/myweb
]# echo wo shi myweb > /var/www/myweb/index.html
]# vim    /etc/httpd/conf/httpd.conf
…….此处省略一万字
DocumentRoot     "/var/www/myweb"   #修改原有配置
…….此处省略一万字
]# systemctl  restart  httpd    #重启服务
]# curl   192.168.88.240
wo shi myweb

httpd软件自己的访问控制规则：基于网页文件存放目录
默认继承父目录的访问控制规则,除非针对此目录有单独设置

   /var/www/      #允许所有客户端可以访问
   /                 #拒绝所有客户端访问
   /var            #允许所有客户端可以访问

    /var/www/abc/index.html    #允许所有客户端可以访问
/var/index.html   #允许所有客户端可以访问

<Directory   "/var/www">
    Require all granted     #允许所有客户端访问
</Directory>

<Directory   />
    Require all denied    #拒绝所有客户端访问
</Directory>
总结：默认情况下网页文件，必须在/var/www目录下，才能允许访问

虚拟机A：
]# mkdir    /webroot
]# echo  wo   shi   webroot    >   /webroot/index.html
]# vim    /etc/httpd/conf/httpd.conf
…….此处省略一万字
DocumentRoot    "/webroot"  #修改原有配置
<Directory     "/webroot"> #针对于/webroot路径
    Require  all  granted   #允许所有人访问
</Directory>
…….此处省略一万字
]# systemctl    restart   httpd     #重启服务
]# curl   192.168.88.240
 wo shi webroot

访问出现测试页面：
1 没有网页文件
2 网页文件名称不是index.html
3 httpd的访问控制规则拒绝
4 SELinux的没有关闭

访问流程：客户端 curl  192.168.88.240---》默认http协议进行访问---》服务端 ----》内存 http协议的请求----》httpd进程----》配置文件 /etc/httpd/conf/httpd.conf ----》DocumentRoot /webroot ---》 /webroot---》index.html

客户端  curl  192.168.88.240
服务端  DocumentRoot /webroot ---》 /webroot

网络路径：浏览器输入的路径  192.168.88.240

实际路径: /webroot

curl  192.168.88.240  =  DocumentRoot  /webroot
      192.168.88.240  =  /webroot

DocumentRoot  /webroot  
    服务端 实际路径: /webroot/abc/index.html

客户端 网络路径:  curl   192.168.88.240/abc/

DocumentRoot  /webroot  
客户端 网络路径:  curl   192.168.88.240/webroot/test
服务端 实际路径: /webroot/webroot/test

DocumentRoot: 指定网页文件存放路径（默认/var/www/html）
                 指定网页文件根目录（起始点）

[root@nsd2312 /]# mkdir /webroot/abc
[root@nsd2312 /]# echo wo shi ABC > /webroot/abc/index.html
[root@nsd2312 /]# curl  192.168.88.240/abc/

网页文件名字:默认index.html
DirectoryIndex   index.html

主配置文件：/etc/httpd/conf/httpd.conf
调用配置文件：/etc/httpd/conf.d/*.conf

[root@nsd2312 /]# vim /etc/httpd/conf.d/haha.conf
DocumentRoot  /var/www/cbd

[root@nsd2312 /]# mkdir /var/www/cbd
[root@nsd2312 /]# echo wo shi CBD > /var/www/cbd/index.html
[root@nsd2312 /]# cat /var/www/cbd/index.html
[root@nsd2312 /]# systemctl  restart  httpd
[root@nsd2312 /]# curl   192.168.88.240

Listen: 指定监听端口

端口：数字，标识协议与进程
http协议默认端口  80
建议自定义端口时大于1024，端口的极限65535
[root@nsd2312 /]# vim  /etc/httpd/conf.d/haha.conf
DocumentRoot  /var/www/cbd
Listen 8000
Listen 9000
[root@nsd2312 /]# systemctl  restart  httpd
[root@nsd2312 /]# curl   192.168.88.240:80
[root@nsd2312 /]# curl   192.168.88.240:8000
[root@nsd2312 /]# curl   192.168.88.240:9000
]# mkdir  /var/www/cbd/test
]# echo wo shi Test > /var/www/cbd/test/index.html
]# curl  192.168.88.240:8000/test/

虚拟Web主机
由同一台服务器,提供多个不同的Web站点
•区分方式(构建方式)
–基于域名的虚拟主机
–基于端口的虚拟主机
–基于IP地址的虚拟主机

–基于域名的虚拟主机
•为每个虚拟站点添加配置
<VirtualHost   IP地址:端口>
ServerName  此站点域名，比如www.qq.com
DocumentRoot  此站点的网页根目录
</VirtualHost>

虚拟机A：
[root@server ~]# vim   /etc/httpd/conf.d/xixi.conf
<VirtualHost     *:80>   #在所有IP地址，使用80端口提供本页面
ServerName    <www.qq.com>     #网站的域名
DocumentRoot   /var/www/qq    #网页文件路径
</VirtualHost>
<VirtualHost*:80>
ServerName   <www.lol.com>
DocumentRoot   /var/www/lol
</VirtualHost>
]# mkdir   /var/www/qq    /var/www/lol
]# echo wo shi QQ > /var/www/qq/index.html
]# echo wo shi LOL > /var/www/lol/index.html
]# systemctl  restart   httpd

/etc/hosts：直接提供域名解析，只为本机提供解析
[root@server ~]# vim     /etc/hosts  
…….此处省略一万字
192.168.88.240   <www.qq.com>    <www.lol.com>
[root@server ~]# curl   <www.qq.com>
[root@server ~]# curl   <www.lol.com>

一旦使用虚拟Web主机功能，所有的网站都必须使用虚拟Web方式进行呈现

端口的优先级最高

基于端口的虚拟Web主机
[root@server ~]# vim  /etc/httpd/conf.d/xixi.conf
<VirtualHost   *:80>
   ServerName  <www.qq.com>
   DocumentRoot   /var/www/qq
</VirtualHost>
Listen  8080
<VirtualHost*:8080>
   ServerName   <www.qq.com>
   DocumentRoot    /var/www/lol
</VirtualHost>
[root@server ~]# systemctl restart httpd
[root@server ~]# curl  <www.qq.com:8080>
[root@server ~]# curl  <www.qq.com>

虚拟机A：服务端
[root@nsd2312 /]# mkdir   /abc
[root@nsd2312 /]# echo  haha  > /abc/h.txt
[root@nsd2312 /]# echo  xixi > /abc/x.txt
[root@nsd2312 /]# ls   /abc
[root@nsd2312 /]# rpm -q  nfs-utils
[root@nsd2312 /]# vim   /etc/exports   #NFS共享配置文件
/abc           *(ro)
文件夹路径      客户机地址(权限)
]# systemctl   restart   nfs-server

虚拟机B：客户端
[root@pc2 ~]# rpm  -q  nfs-utils
nfs-utils-2.3.3-51.el8.x86_64
[root@pc2 ~]# showmount  -e  192.168.88.240
Export list for 192.168.88.240:
/abc   *
[root@pc2 ~]# mkdir   /mnt/mynfs
[root@pc2 ~]# mount  192.168.88.240:/abc    /mnt/mynfs
[root@pc2 ~]# ls    /mnt/mynfs
[root@pc2 ~]# df   -h   /mnt/mynfs

/etc/fstab开机自动挂载NFS共享
虚拟机B：
_netdev：声明网络设备，系统在具备网络参数后，再进行挂载本设备
[root@pc2 ~]# vim    /etc/fstab
……此处省略一万字
192.168.88.240:/abc  /mnt/mynfs    nfs_netdev   0   0
[root@pc2 ~]# umount   /mnt/mynfs
[root@pc2 ~]# ls   /mnt/mynfs
[root@pc2 ~]# mount   -a
[root@pc2 ~]# ls   /mnt/mynfs

触发挂载（了解内容）
•由 autofs 服务提供的“按需访问”机制
–只要访问挂载点就会触发响应，自动挂载指定设备
–闲置一段时间后，会自动卸载
虚拟机B：
[root@pc2 ~]# yum  -y  install  autofs
[root@pc2 ~]# systemctl restart autofs
[root@pc2 ~]# ls  /misc
[root@pc2 ~]# ls  /misc/cd  

•主配置文件 /etc/auto.master
–监控点目录 挂载配置文件的路径

•挂载配置文件，比如 /etc/auto.misc
–触发点子目录 -挂载参数 :设备名

案例：虚拟机B访问/myauto/nsd,光驱设备挂载/myauto/nsd
[root@pc2 ~]# yum -y  install   autofs
[root@pc2 ~]# vim   /etc/auto.master
……此处省略一万字
/myauto      /opt/xixi.txt
……此处省略一万字
[root@pc2 ~]# vim  /opt/xixi.txt
nsd    -fstype=iso9660     :/dev/cdrom
test    -fstype=nfs     192.168.88.240:/abc
[root@pc2 ~]# systemctl  restart   autofs
[root@pc2 ~]# ls   /myauto
[root@pc2 ~]# ls   /myauto/nsd
[root@pc2 ~]# ls   /myauto/test
http协议默认端口为80
ssh协议默认端口为22

所有虚拟机设置SELinux运行模式
[root@server ~]# getenforce
Enforcing
[root@server ~]# setenforce 0  #当前设置
[root@server ~]# getenforce
Permissive
[root@server ~]# vim   /etc/selinux/config
SELINUX=permissive
所有虚拟机设置防火墙（停止防火墙服务）
[root@server ~]# yum  -y  remove  firewalld
[root@server ~]# rpm   -q  firewalld

本地Yum仓库：软件仓库由本机直接提供
  执行流程：运行yum---》仓库配置文件----》软件仓库位置
  构建软件仓库：1.众多的软件包  2.仓库数据文件(仓库清单)

自定义Yum仓库
  将自己下载一些软件包，构建成软件仓库

真机上：数据传递，tools.tar.gz传递虚拟机A
]$ scp  /linux-soft/s1/tools.tar.gz   root@192.168.88.240:/root

虚拟机A
]# ls  /root
]# tar -tf   /root/tools.tar.gz   #查看tar包内容
]# tar  -xf   /root/tools.tar.gz  -C   /    #解包
]# ls  /tools/
  构建软件仓库：1.众多的软件包  2.仓库数据文件(仓库清单)
]# yum -y install createrepo_c
]# createrepo   /tools/other/   #生成仓库数据文件
]# ls  /tools/other/
执行流程：运行yum---》仓库配置文件----》软件仓库位置
]# vim  /etc/yum.repos.d/mydvd.repo
…..此处省略一万字
[myrpm]
baseurl=file:///tools/other
gpgcheck=0
]# yum repoinfo  
]# yum  -y  install  sl
]# yum  -y  install  cmatrix

执行流程：运行yum---》仓库配置文件----》软件仓库位置

软件仓库的更新：
 1.仓库数据文件更新  createrepo   --update
 2.yum缓存的更新  yum  makecache

]# mv /tools/other/sl-5.02-1.el7.x86_64.rpm   /root
]# ls /tools/other/

]# createrepo  --update  /tools/other/
]# yum  makecache

]# yum  repoinfo

]# mv /root/sl-5.02-1.el7.x86_64.rpm   /tools/other
]# ls /tools/other/

]# createrepo  --update  /tools/other/
]# yum  makecache

]# yum  repoinfo

网络Yum仓库:构建网络服务，利用网络服务提供软件仓库内容
虚拟机A：构建FTP服务
]# yum  -y install vsftpd
]# vim  /etc/vsftpd/vsftpd.conf
anonymous_enable=YES     #开启无需验证功能
]# systemctl restart vsftpd   #重启服务
]# systemctl enable vsftpd   #设置服务开机自启动
]# cp  -r   /tools/other/   /var/ftp/rpms
]# ls  /var/ftp/rpms/
]# curl  ftp://192.168.88.240/rpms/

虚拟机B：
[root@pc2 ~]# vim /etc/yum.repos.d/mydvd.repo
…..此处省略一万字
[myrpm]
baseurl=ftp://192.168.88.240/rpms
gpgcheck=0
[root@pc2 ~]# yum  repoinfo
[root@pc2 ~]# yum -y  install  sl

提供光盘内容
虚拟机A：构建FTP服务
]# vim  /etc/fstab
/dev/cdrom      /var/ftp/dvd   iso9660  defaults     0 0
]# mkdir  /var/ftp/dvd
]# mount  -a  
]# ls  /var/ftp/dvd
虚拟机B:
]# vim  /etc/yum.repos.d/mydvd.repo
[app]
baseurl=ftp://192.168.88.240/dvd/AppStream
gpgcheck=0
[base]
baseurl=ftp://192.168.88.240/dvd/BaseOS
gpgcheck=0
[myrpm]
baseurl=ftp://192.168.88.240/rpms
gpgcheck=0

虚拟机B:
[root@pc2 ~]# scp  /etc/yum.repos.d/mydvd.repo  root@192.168.88.240:/etc/yum.repos.d/

root@192.168.88.240's password:  

虚拟机A:
[root@nsd2312 ~]# cat  /etc/yum.repos.d/mydvd.repo  

[root@nsd2312 ~]# yum repoinfo

虚拟机A:拍摄第三张快照
]# systemctl  is-enabled  vsftpd   #查看是否开机自启动
]# yum  repoinfo

网络Yum仓库更新：
虚拟机A：
]# mv  /var/ftp/rpms/sl-5.02-1.el7.x86_64.rpm    /root/
]# ls  /root/
]# createrepo --update  /var/ftp/rpms/   #仓库数据文件更新
]# yum  makecache   #缓存更新
]# yum  repoinfo
虚拟机B：
]# yum  makecache   #缓存更新
]# yum  repoinfo
虚拟机C：
]# yum  makecache   #缓存更新
]# yum  repoinfo

所有的域名都要以点作为结尾      <www.qq.com>.

根域名                   .                根域名服务器

一级域名:    .cn    .us    .hk    .tw    .jp   .com   .net   …….

二级域名:   qq.com    haha.com   xixi.com   hehe.com  …….

三级域名:   nb.haha.com    cbd.haha.com   test.haha.com  ……..

    注册域名：haha.com
    站点名：www     mail     vip   
    完全合格的域名（FQDN）: 站点名.注册域名    www.haha.com

Full Qualified Domain Name

    注册域名：qq.com
    站点名：www     lol   dnf    mail  
    完全合格的域名（FQDN）: 站点名.注册域名  

BIND服务器端程序
主要执行程序：/usr/sbin/named
系统服务：named
默认端口：DNS协议的默认端口 53
运行时的虚拟根环境：/var/named/chroot/
主配置文件：/etc/named.conf    #负责解析的域名   tedu.cn
                                <www.tedu.cn>
地址库文件：/var/named/      #完全合格的域名与IP地址对应关系
                                 <www.tedu.cn> ---》1.1.1.1
虚拟机A：
[root@nsd2312 ~]# yum  -y  install  bind   bind-chroot
  bind  : 主程序
  bind-chroot : 牢笼政策，安全机制

[root@nsd2312 ~]# cp -p   /etc/named.conf  /opt
[root@nsd2312 ~]# ls  /opt/
[root@server ~]# vim   /etc/named.conf
options  {
        directory     "/var/named";   #定义地址库文件存放路径
};
zone "tedu.cn"  IN {       #定义负责的解析tedu.cn域名
        type  master;        #权威主DNS服务器
        file   "tedu.cn.zone";     #地址库文件名称
};

]# cd  /var/named/
]# ls
]# cp  -p  named.localhost  tedu.cn.zone
]# ls
[root@server ~]# vim     /var/named/tedu.cn.zone
……此处省略一万字
NS   nsd2312      #声明DNS服务器为server
nsd2312    A    192.168.88.240    #nsd2312解析结果为192.168.88.240
www        A    1.1.1.1
ftp          A    2.2.2.2
[root@server ~]# systemctl   restart    named

虚拟机B：测试DNS服务器
1.指定DNS服务器地址
]# echo nameserver  192.168.88.240  >  /etc/resolv.conf
]# cat  /etc/resolv.conf

2.命令测试域名解析
]# nslookup    <www.tedu.cn>  
]# host    ftp.tedu.cn
]# dig     ftp.tedu.cn

特殊的解析记录

一、泛域名解析:
虚拟机A:
[root@nsd2312 /]# vim   /var/named/tedu.cn.zone
……此处省略一万字
           NS   nsd2312
nsd2312   A    192.168.88.240
www      A     1.1.1.1
ftp        A     2.2.2.2

-          A     6.6.6.6

tedu.cn.   A     7.7.7.7
[root@nsd2312 /]# systemctl  restart  named
虚拟机B：
]# nslookup   <www.tedu.cn>
]# nslookup   wwwuwhefwhef.tedu.cn
]# nslookup   tedu.cn

二、有规律的泛域名解析
pc1.tedu.cn  --  192.168.100.1
pc2.tedu.cn  --  192.168.100.2
pc3.tedu.cn  --  192.168.100.3
pc4.tedu.cn  --  192.168.100.4
……
pc50.tedu.cn  --  192.168.100.50

内置函数：$GENERATE  制造连续的数字
虚拟机A:
[root@nsd2312 /]# vim   /var/named/tedu.cn.zone
……此处省略一万字
           NS    nsd2312
nsd2312   A    192.168.88.240
www      A     1.1.1.1
ftp        A     2.2.2.2

-          A     6.6.6.6

tedu.cn.   A     7.7.7.7
$GENERATE  1-50  pc$    A   192.168.100.$
[root@nsd2312 /]# systemctl  restart  named
虚拟机B：
]# nslookup   pc36.tedu.cn

解析记录的别名
虚拟机A:
[root@nsd2312 /]# vim   /var/named/tedu.cn.zone
……此处省略一万字
           NS    nsd2312
nsd2312   A     192.168.88.240
www      A     1.1.1.1
ftp        A     2.2.2.2

-          A     6.6.6.6

tedu.cn.   A     7.7.7.7
$GENERATE  1-50  pc$    A   192.168.100.$
vip        CNAME   ftp
[root@nsd2312 /]# systemctl  restart  named
虚拟机B：
]# nslookup   vip.tedu.cn

DNS资源解析记录：
   NS  ：DNS服务器声明记录
   A   ： 地址解析记录
   CNAME  ：解析记录的别名

/etc/hosts文件与/etc/resolv.conf文件
1./etc/hosts文件域名解析最高优先级
2./etc/resolv.conf文件指定DNS服务器地址

递归查询（递归解析）与迭代查询（迭代解析）
递归查询：客户端发送请求给首选DNS服务器，首选DNS服务器与其他的DNS服务器交流，最终将解析结果带回来过程

迭代查询: 客户端发送请求给首选DNS服务器，首选DNS服务器告知下一个DNS服务器地址

DNS服务器搭建要求:
实现DNS服务器，在192.168.88.240上构建
负责域名为sina.com，实现站点名www的解析
实现www.sina.com解析结果为192.188.16.17

所有虚拟机设置SELinux运行模式
[root@server ~]# getenforce
Enforcing
[root@server ~]# setenforce 0  #当前设置
[root@server ~]# getenforce
Permissive
[root@server ~]# vim   /etc/selinux/config
SELINUX=permissive
所有虚拟机设置防火墙（停止防火墙服务）
[root@server ~]# yum  -y  remove  firewalld
[root@server ~]# rpm   -q  firewalld

源码编译安装

 RPM软件包：rpm   yum
 源码包---编译gcc  make---》可以执行的程序(二进制)----》运行安装
   自定义性：指定安装位置   指定软件安装功能

准备源码包：
 真机：
]$ scp  /linux-soft/s1/tools.tar.gz  root@192.168.88.240:/root

一、安装开发工具
虚拟机A：
]# yum -y install gcc make
]# rpm  -q  gcc
]# rpm  -q  make

二、tar解包
]# tar  -xf  /root/tools.tar.gz  -C  /usr/local
]# ls   /usr/local/tools

]# tar -xf /usr/local/tools/inotify-tools-3.13.tar.gz -C /usr/local/  
]# ls    /usr/local/
]# cd     /usr/local/inotify-tools-3.13/
]# ls

三、指定软件的功能以及安装位置(生成做菜的大纲)
Makefile(制作程序的大纲)
作用1：检测当前系统是否安装gcc
作用2：指定安装位置与功能
作用3：生成Makefile文件（制作程序的大纲，做菜的菜谱）

]# cd   /usr/local/inotify-tools-3.13/
]# ./configure  --help   #查看帮助信息,大概浏览一下
]# ./configure  --prefix=/opt/myrpm #指定安装位置，此步骤不产生相应目录

四、编译
[root@nsd2312 inotify-tools-3.13]# make
五、安装
[root@nsd2312 inotify-tools-3.13]# make  install
[root@nsd2312 inotify-tools-3.13]# ls  /opt/myrpm

步骤1：安装开发工具gcc与make
步骤2：tar解包，释放源代码至指定目录
步骤3：./configure 配置，指定安装目录/功能模块等选项
步骤4：make 编译，生成可执行的二进制程序文件
步骤5：make install 安装，将编译好的文件复制到安装目录

]# mkdir   /mydir    /todir
]# echo haha >  /mydir/h.txt
]# rsync  -avX  --delete   /mydir/      /todir   #同步目录的内容
]# ls   /mydir/
]# ls   /todir/

]# touch   /todir/a.txt
]# ls  /todir/
]# rsync  -avX  --delete  /mydir/      /todir  #删除目标多出的数据
]# ls   /todir/
]# ls   /mydir/

远程同步（rsync+ssh）
下行：rsync [...]  user@host:远程目录     本地目录
上行：rsync [...]  本地目录    user@host:远程目录

虚拟机A：
[root@server ~]# rsync  -avX  --delete  /mydir/    root@192.168.88.2:/cbd
……..connecting (yes/no)? yes
root@192.168.88.2's password:         #输入密码

虚拟机B：
[root@server ~]# ls   /cbd

实时同步数据     /mydir ----->  /cbd
实现ssh无密码验证(公钥与私钥)
虚拟机A
1.虚拟机A生成公钥与私钥
[root@server ~]# ssh-keygen         #一路回车
[root@server ~]# ls    /root/.ssh/
id_rsa(私钥)   id_rsa.pub(公钥)    known_hosts(记录曾经远程管理过的机器)
2．虚拟机A将公钥传递给虚拟机B
[root@server ~]# ssh-copy-id     root@192.168.88.2
[root@server ~]# rsync  -avX --delete   /mydir/    root@192.168.88.2:/cbd

监控目录内容变化工具
• 基本用法
inotifywait [选项] 目标文件夹
• 常用命令选项
-m，持续监控（捕获一个事件后不退出）
-r，递归监控、包括子目录及文件
-q，减少屏幕输出信息
-e，指定监视的 modify、move、create、delete、attrib 等事件类别

/opt/myrpm/bin/inotifywait  -rq  /mydir
rsync  -avX --delete   /mydir/    root@192.168.88.2:/cbd

shell脚本（了解）
 脚本：一个可以执行的文件，实现某种功能
   中文：创建用户zhangsan    shell: useradd   zhangsan

[root@server /]# vim    /root/hello.sh  
echo  hello  world
hostname
id  root
ifconfig   |   head  -2

]# chmod   +x   /root/hello.sh  #所有人赋予执行权限
]# /root/hello.sh   #绝对路径执行脚本

/opt/myrpm/bin/inotifywait  -rq  /mydir
rsync  -avX --delete   /mydir/    root@192.168.88.2:/cbd

解决重复性：循环
 for ：处理有固定次数事情
 while ：处理不固定次数事情

格式：
[root@server /]# vim   /etc/rsync.sh
while   /opt/myrpm/bin/inotifywait  -rqq   /mydir/
do
rsync -aX  --delete   /mydir/   root@192.168.88.2:/cbd
done
[root@server /]# chmod  +x  /etc/rsync.sh  #赋予执行权限
[root@server /]# /etc/rsync.sh   & #放入后台运行脚本程序

[root@server /]# jobs  -l    #-l选项  显示进程的pid
[1]    + 17707 运行中               /etc/rsync.sh &

数据库服务(数据库系统)
  什么是数据库：存放数据的仓库
在数据库系统中，有很多的数据库，在每一个库中有很多的表格
database:数据库

部署数据库服务(数据库系统)
]# yum  -y  install  mariadb-server
]# systemctl  restart  mariadb

1. Linux系统的管理指令不能使用
2. 所有的数据库系统指令都必须以 ; 结尾
3. 数据库系统的指令大部分不支持tab补全

[root@server /]# mysql          #进入数据库系统
> create  database  nsd01;     #创建nsd01数据库
> show  databases;                #查看所有数据库
> drop   database   nsd01;    #删除数据库nsd01
> show  databases;                #查看所有数据库
> create  database  test;     #创建test数据库
> show  databases;                #查看所有数据库
> exit;
Bye
[root@server ~]#

[root@server /]# mysql     #进入数据库系统
> use    mysql;              #切换到mysql数据库
> show   tables;          #查看当前库中所有表格
> show   databases;    #查看所有数据库
> use  test;             #切换到test数据库
> exit;

uses.sql备份文件恢复数据
真机：
]$ scp  /linux-soft/s1/users.sql   root@192.168.88.240:/root

虚拟机A：
]# ls   /root/users.sql
]# mysql   test   <   /root/users.sql   #恢复数据到test数据库
]# mysql                 #进入数据库系统
MariaDB [(none)]> use   test;        #切换到数据库test
MariaDB [test]> show   tables;      #查看当前库有哪些表格

表记录     表字段
姓名 性别 编号
dc 女 1
tc 女 2

 四大操作：增insert   删delete   改update   查select

select查询：
 格式:  select  表字段,……  from  表明;
[root@server /]# mysql
> use    test;
> select   *from   base;      #查看base所有表字段内容
> select*   from   location;   #查看location所有表字段内容

> select   name,password   from   base;
> use  mysql;
> select   *   from    test.base;
> use  test;
> select   id,name    from     base;

[root@server /]# mysql  
> use    test;    #切换到test库
查询密码为456的记录
> select  *from    base  where   password='456';
查看id编号为4的记录
> select*   from   base  where   id='4';
查询id编号为4并且密码为123的记录
> select  *from  base  where  id='4'    and   password='123';
查询id编号为4或者密码为123的记录
> select*  from  base   where  id='4'  or   password='123';

增(insert)
格式：insert 表名 values (‘值’,‘值’,‘值’);
MariaDB [test]> insert   base  values('10','dc','789');
MariaDB [test]> insert   base  values('11','tcc','369');
MariaDB [test]> select   *   from base ;

改（update）
格式：
update 表名 set 表字段=‘新值’ where 表字段=’值’；
> select   *from  base ;
> update   base   set   password='8888'   where   id='1';
> select*  from   base ;

删（delete）
> select   *from   base ;
> delete   from   base   where     id='3' ;
> select*   from   base ;

数据库系统管理员:对于数据库系统有最高权限，名字为root，能够登陆数据系统的用户信息，由mysql库中user表进行储存

Linux系统管理员: 对于Linux系统有最高权限，名字为root，能够登陆Linux系统的用户信息，/etc/passwd进行储存

[root@server /]# mysqladmin -u   root   password   '456'
[root@server /]# mysql  -u   root    -p    #交互式进行登录
Enter password:

[root@server /]# mysql   -u  root   -p456 #非交互式进行登录

已知旧密码修改新密码
[root@server ~]# mysqladmin  -u   root  -p456   password   '123'
[root@server ~]# mysql  -u  root    -p123

虚拟机B防火墙
[root@pc2 ~]# rpm  -q  firewalld
未安装软件包 firewalld
[root@pc2 ~]#

虚拟机B  SELinux
[root@pc2 ~]# vim  /etc/selinux/config
SELINUX=disabled
[root@pc2 ~]# reboot
[root@pc2 ~]# getenforce
Disabled

虚拟机B：
[root@pc2 ~]# yum -y install  podman

或者：
   模块(软件组)：container-tools
[root@pc2 ~]#  yum -y module install   container-tools

真机上:
]$ scp  /linux-soft/s1/img.tar.xz  root@192.168.88.2:/root

虚拟机B：
[root@pc2 ~]# ls   /root
公共  文档  anaconda-ks.cfg       nsd06
模板  下载  img.tar.xz
[root@pc2 ~]#

虚拟机B：导入镜像
[root@pc2 ~]# podman  load  -i  /root/img.tar.xz

[root@pc2 ~]# podman  images    #查看系统有哪些镜像

镜像删除练习01
]# podman  images           #查看当前有哪些镜像
]# podman   rmi   6        #按照镜像的ID值，删除镜像
]# podman  images           #查看当前有哪些镜像

]# podman load  -i   /root/img.tar.xz            #导入镜像
]# podman  images           #查看当前有哪些镜像

• 镜像的名称标识
方式二：镜像名称（姓氏） + 标签（名字） = 唯一
–每一个镜像都有标签，如果没写就是默认标签 latest
–我们在调用镜像的时候，如果没有指定标签也是 latest

镜像删除练习02
]# podman   images       #查看当前系统可以使用的镜像
]# podman   rmi    localhost/rockylinux:8.6    #删除镜像
]# podman   images
]# podman load  -i   /root/img.tar.xz            #导入镜像
]# podman   images

podman  run    三合一   产生容器、启动容器、进入容器
•podman run 命令的选项
–选项 -i，交互式方式
–选项 -t，终端
–选项 -d，后台运行
–选项 --name 容器名字

容器初步练习
]# podman  run  --name abc01 -it  localhost/rockylinux:8.6   /bin/bash

[root@2b0b7c62ab42 /]# cat   /etc/redhat-release
[root@2b0b7c62ab42 /]# useradd dc
[root@2b0b7c62ab42 /]# id  dc
[root@2b0b7c62ab42 /]# exit            #退出容器
[root@pc2 ~]# podman  ps   -a     #查看当前系统容器
[root@pc2 ~]# podman  rm   abc01   #删除容器
[root@pc2 ~]# podman  ps   -a     #查看当前系统容器

]# podman  rm  -f   abc01    #强制删除容器abc01
]# podman  run  --name abc01 -it  localhost/rockylinux:8.6   /bin/bash
[root@2b0b7c62ab42 /]# cat   /etc/redhat-release
[root@2b0b7c62ab42 /]# useradd tcc
[root@2b0b7c62ab42 /]# id  tcc
[root@2b0b7c62ab42 /]# exit            #退出容器
[root@pc2 ~]# podman  ps   -a     #查看当前系统容器
[root@pc2 ~]# podman  start   abc01     #启动容器
[root@pc2 ~]# podman  exec  -it  abc01  /bin/bash   #进入容器
[root@2b0b7c62ab42 /]# id  tcc
[root@2b0b7c62ab42 /]# exit            #退出容器
[root@pc2 ~]# podman  rm  -f   abc01    #强制删除容器abc01

容器放入后台练习
]# podman run --name  abc02  -itd  localhost/rockylinux:8.6
]# podman  ps  -a         #查看当前系统有哪些容器
]# podman  exec   -it  abc02    /bin/bash    #进入abc02容器
[root@962aa837e17b /]# useradd  tc
[root@962aa837e17b /]# id tc
[root@962aa837e17b /]# exit
]# podman  ps  -a      #查看当前系统有哪些容器
]# podman  exec   -it    abc02   /bin/bash #进入abc02容器
[root@962aa837e17b /]# id tc
[root@962aa837e17b /]# exit
]# podman  ps  -a              #查看当前系统有哪些容器
]# podman  rm  -f  abc02     #强制删除容器abc02

容器构建Yum仓库
网络Yum仓库
1.构建容器的服务器，自动可以与容器进行通信
]# podman run --name  abc02  -itd  localhost/rockylinux:8.6

]# podman  inspect  abc02  |  grep   -i  ipadd   #查看容器详细信息

]# ifconfig  |  head  -2   #查看虚拟机B 容器网卡的IP地址

2.虚拟机B构建FTP服务
]# yum   -y  install   vsftpd
]# vim  /etc/vsftpd/vsftpd.conf
anonymous_enable=YES
]# systemctl  restart  vsftpd
]# mkdir  /var/ftp/dvd
]# mount  /dev/cdrom  /var/ftp/dvd
mount: /var/ftp/dvd: WARNING: device write-protected, mounted read-only.
]# ls  /var/ftp/dvd
]# curl  ftp://10.88.0.1/dvd/

3.建立新的容器
]# podman run  --name  haha  -itd  localhost/rockylinux:8.6
]# podman exec -it  haha  /bin/bash
[root@d1c5fa7f874c /]# rm  -rf   /etc/yum.repos.d/*
[root@d1c5fa7f874c /]# vi   /etc/yum.repos.d/dvd.repo
[app]
baseurl=ftp://10.88.0.1/dvd/AppStream
gpgcheck=0
[base]
baseurl=ftp://10.88.0.1/dvd/BaseOS
gpgcheck=0
[root@d1c5fa7f874c /]# yum  -y  install  vim   net-tools
[root@d1c5fa7f874c /]# ifconfig  |  head  -2
[root@d1c5fa7f874c /]# yum  -y  install  bash-completion
[root@d1c5fa7f874c /]# exit
exit
[root@pc2 ~]# podman  restart  haha
[root@pc2 ~]# podman  exec  -it  haha   /bin/bash
[root@d1c5fa7f874c /]# yum -y ins(Tab)    #测试Tab键的补全

bash-completion：提供Tab键扩展补全功能
net-tools:提供ifconfig命令

自定义镜像：将配置完好的容器，封装成新的镜像
虚拟机B
[root@pc2 ~]# podman  stop  haha    #停止容器
[root@pc2 ~]# podman  commit    haha    myos:1.0
[root@pc2 ~]# podman  images

]# podman run  --name test  -it  localhost/myos:1.0  /bin/bash
[root@38eb9523c02f /]# ifconfig  |  head -2
[root@38eb9523c02f /]# yum  repoinfo
[root@38eb9523c02f /]# exit
]# podman  rm  -f  test    #强制删除容器
]# podman  rm  -f  haha
]# podman  ps  -a       #查看当前系统有哪些容器

自定义镜像：方式一
总结：
1.基础镜像，产生容器haha
2.进入容器haha，进行配置
3.关闭容器haha，将容器haha封装成新的镜像

自定义镜像：方式二(了解)

容器发布服务（微服务）
虚拟机B：
[root@pc2 ~]# yum  -y remove httpd
[root@pc2 ~]# rpm  -q  httpd

]# podman ps -a
]# podman run  --name  myweb -itd localhost/httpd:latest
]# podman exec -it myweb /bin/bash
[root@b94dd3b00475 html]# rpm  -q  httpd
[root@b94dd3b00475 html]# pwd
[root@b94dd3b00475 html]# cat  index.html
[root@b94dd3b00475 html]# exit

[root@pc2 ~]# podman inspect myweb |  grep  -i  ipadd
[root@pc2 ~]# curl  myweb容器IP地址   #访问测试

端口绑定：
[root@pc2 ~]# podman rm -f myweb

[root@pc2 ~]# podman run --name myweb  -p 80:80        -itd localhost/httpd:latest

[root@pc2 ~]# curl   192.168.88.2

目录绑定
[root@pc2 ~]# podman  rm  -f  myweb
[root@pc2 ~]# mkdir  /webroot
[root@pc2 ~]# echo wo shi webroot > /webroot/index.html
[root@pc2 ~]# ls  /webroot

[root@pc2 ~]# podman run --name myweb -p 80:80         -v  /webroot:/var/www/html -itd localhost/httpd:latest

[root@pc2 ~]# curl   192.168.88.2

容器之光练习（了解）

 利用systemd方式管理容器
 用户--systemctl-->systemd--服务启动配置文件-->容器
]# cd   /usr/lib/systemd/system
]# podman   ps   -a
]# podman  generate   systemd   --name   myweb   --files
]# vim   container-myweb.service  #大致浏览一遍
]# systemctl   daemon-reload     #重新加载服务配置文件
]# systemctl   daemon-reload
]# podman   stop    myweb     #手动停止
]# podman   ps    -a
]# systemctl  start   container-myweb  #测试systemd方式
]# podman   ps  -a
]# systemctl   enable   container-myweb     #设置开机自启

邮件功能
<XXXXXXX@qq.com>
<XXXXXXX@sina.com>
<XXXXXXX@163.com>

[root@pc2 /]# useradd  yg
[root@pc2 /]# useradd  xln

[root@pc2 /]# yum -y install postfix         #提供邮件功能软件
[root@pc2 /]# systemctl restart postfix

mail 发信操作: mail -s '邮件标题' -r 发件人 收件人
[root@server /]# yum  -y   install  mailx #提供mail命令软件
[root@server /]# mail   -s  'test01'   -r   yg    xln
hahaxixiehehelele
.                #一行只有一个点表示提交
EOT
mail 收信操作: mail [-u 用户名]
[root@server /]# mail   -u    xln
>N  1  <yg@server.tedu.cn>    Fri Sep 18 17:24  18/510
&  1            #输入邮件编号
&  exit       #退出
非交互式发邮件：
[root@server ~]# echo 123456  |  mail  -s  'test02'   -r   yg  xln
[root@server ~]# mail  -u  xln  

虚拟机C：
[root@pc3 ~]# rpm -q firewalld
未安装软件包 firewalld
[root@pc3 ~]# getenforce
Permissive

静态网站：利用html语言进行书写，浏览器可以直接识别，显示相同功能。不会使用数据库服务

动态网站：利用开发语言(PHP、Python…..)进行书写，需要相应翻译软件将功能进行呈现。会使用数据库服务

构成组件
Linux、Apache、MariaDB/MySQL、PHP/Perl/Python

LAMP的优势
成本低廉、易用、安全和稳定
可定制、易于开发

虚拟机C：
一、部署Web服务
[root@pc3 ~]# yum -y install  httpd
[root@pc3 ~]# echo  NSD Web Server > /var/www/html/index.html
[root@pc3 ~]# systemctl restart httpd
[root@pc3 ~]# curl  192.168.88.3

二、部署动态页面
[root@pc3 ~]# vim   /var/www/html/test.php
<?php
phpinfo();
?>
三、部署PHP
[root@pc3 ~]# yum -y install  php  php-xml  php-json
[root@pc3 ~]# ls  /etc/httpd/conf.d  #查看产生的调用配置文件
php.conf

[root@pc3 ~]# systemctl  restart  httpd

真机测试：firefox    192.168.88.3/test.php

四、部署数据库服务
[root@pc3 ~]# yum  -y install  mariadb-server
[root@pc3 ~]# systemctl restart mariadb

数据库用户授权：让一个普通用户可以有权力登录数据库
[root@pc3 ~]# mysql
MariaDB [(none)]> create  database  nsd;   #创建数据库
MariaDB [(none)]> show  databases;    #显示所有数据库
MariaDB [(none)]> grant all on  nsd.*  to  lisi@localhost  identified  by  '123';
MariaDB [(none)]> exit
[root@pc3 ~]# mysql  -u lisi  -p123    #测试登录
MariaDB [(none)]> show  databases;   #是否能看到nsd数据库
MariaDB [(none)]> exit

五、部署PHP代码
真机上：
scp  /linux-soft/s1/Discuz_X3.5_SC_UTF8.zip  root@192.168.88.3:/root

[root@pc3 ~]# yum -y install  php-mysqlnd
[root@pc3 ~]# rpm  -q  php-mysqlnd

总结： httpd   php   php-xml   php-json  mariadb-server php-mysqlnd

[root@pc3 ~]# mkdir  /nsd10
[root@pc3 ~]# unzip /root/Discuz_X3.5_SC_UTF8.zip -d /nsd10

[root@pc3 ~]# ls  /nsd10

[root@pc3 /]# cp  -r  /nsd10/upload   /var/www/html/lt
[root@pc3 /]# ls /var/www/html/

[root@pc3 /]# chown -R  apache   /var/www/html/lt/

真机测试：firefox    192.168.88.3/lt

##############################################

NTP时间服务器
作用：提供标准时间
•Network Time Protocol（网络时间协议）
•它用来同步网络中各个计算机的时间的协议
•210.72.145.39 (国家授时中心服务器IP地址)
•Stratum（分层设计）
•Stratum层的总数限制在15以内（包括15）

    虚拟机A:构建时间服务器
[root@nsd2312 ~]# rpm -q  firewalld
未安装软件包 firewalld
[root@nsd2312 ~]# getenforce
Permissive
[root@nsd2312 ~]# rpm -q chrony
[root@nsd2312 ~]# vim   /etc/chrony.conf
末行模式 :set  nu
3  #pool 2.pool.ntp.org iburst
   23  allow  all
   26  local stratum 10
[root@nsd2312 ~]# systemctl restart chronyd

虚拟机B：客户端
[root@pc2 ~]# rpm -q  firewalld
未安装软件包 firewalld
[root@pc2 ~]# getenforce
Permissive
[root@pc2 ~]# rpm -q  chrony
[root@pc2 ~]# vim  /etc/chrony.conf
server  192.168.88.240  iburst    #修改配置，指定时间服务器地址

[root@pc2 ~]# systemctl restart chronyd

虚拟机B：验证
[root@pc2 ~]# date
[root@pc2 ~]# date  -s  '2000-1-1'
[root@pc2 ~]# date
[root@pc2 ~]# systemctl  restart  chronyd
[root@pc2 ~]# date
[root@pc2 ~]# date
[root@pc2 ~]# date

查看系统版本
$ lsb_release  -a

构建软件仓库
1.图形将光盘镜像文件放入虚拟机的光驱设备
2.进行挂载
niu@ben:/$ sudo  mount /dev/cdrom   /mnt
[sudo] niu 的密码：
mount: /mnt: WARNING: source write-protected, mounted read-only.
niu@ben:/$ ls /mnt
boot          casper  EFI      md5sum.txt  preseed
boot.catalog  dists   install  pool        ubuntu
niu@ben:/$

4.仓库配置文件 /etc/apt/sources.list

niu@ben:/$ sudo cp /etc/apt/sources.list   /opt
niu@ben:/$ ls /opt

niu@ben:/$ sudo   vi   /etc/apt/sources.list
deb    file:///mnt      jammy     main

niu@ben:/$ sudo  apt-get  update   #更新仓库配置文件

5、仓库的使用
niu@ben:/$ sudo apt   list |  grep make

niu@ben:/$ sudo apt-get   install   make
niu@ben:/$ sudo apt   list |  grep make

niu@ben:/$ sudo apt-get  remove   make
niu@ben:/$ sudo apt   list |  grep make

niu@ben:/$ sudo apt   list |  grep make

niu@ben:/$ sudo apt-get   install   make
niu@ben:/$ sudo dpkg  -L  make   #查看安装清单
niu@ben:/$ sudo dpkg  -l  make    #查看是否安装

niu@ben:/$ sudo apt-get  remove   make
niu@ben:/$ sudo dpkg  -l  make

VDO（虚拟数据优化器）
•Virtual Data Optimizer（虚拟数据优化器）

 作用： 1.重删数据   2.虚拟大小
