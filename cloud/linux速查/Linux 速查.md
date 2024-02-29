# Linux 速查

[toc]

## 命令

- man
- help
- info

- bc
- sleep

- `pwd` —— Print Working Directory
- `cd` —— Change Directory
- `ls` —— List
  @import "ls.csv"
- which
- cat
  - `-n`
- less
- more
- lscpu
- lsblk
- free
  - `-h`
- whoami
- hostname
- hostnamectl
  - `set-hostname`
- ifconfig
- ping
  - `-c` count
  - `-i` interval
  - `-W` timeout
  - `-6`
- `mkdir` —— Make Directory
  - `-p` `--parents`
  - `-m` `--mode=模式`
- touch
- `cp` —— Copy
  - `-R` `-r` `--recursive`
  - `-p` `--preserve[=属性列表`
- `rm` —— Remove
  - `-r` `-R` `--recursive`
  - `-f` `--force`
- `mv` —— Move
- head
  - `-c` `--bytes=[-]NUM`
  - `-n` `--lines=[-]NUM`
- tail
  - `-c` `--bytes=[+]NUM`
  - `-n` `--lines=[+]NUM`
- grep
  - `-v` `--invert-match`
  - `-i` `--ignore-case`
  - `-c` `--count`
  - `-q` `--quiet` `--silent`
  - `-n` `--line-number`
  - `--color[=WHEN]`
  - `-F` `--fixed-strings`
    - 等同于 `fgrep`
  - `-E` `--extended-regexp`
    - 等同于 `egrep`
  - `-P` `--perl-regexp`
    - 等同于 `pgrep`
- vim
  - 参考：[Vim快捷键&命令收集](https://www.bilibili.com/read/cv25051367/)
  - `+/word`
  - `+:命令`
- echo
  - `-e`
- poweroff
- reboot

- mount
  - `-a` `--all`
  - `-r` `--read-only` `-o ro`
  - `-w` `--rw` `--read-write`
- umount
  - `-a` `--all`
  - `-A` `--all-targets`

### `lsof` —— List Open Files

- 参考：[我不是网管 - 通过18个实例掌握 lsof 命令](https://zhuanlan.zhihu.com/p/601169646)
- 列出特定文件系统打开的文件 `lsof /proc`
  - */proc* 只在 Linux 操作系统的生命周期内存在，这个目录包含了许多重要的进程相关信息。
- 选项
  - `-i` *select IPv[46] files*
    `lsof -i 4`
    `lsof -i TCP:80`
    `lsof -i UDP:1-1048`
    `lsof -i TCP`
  - `-a` *AND selections (OR)*
  - `-p` *exclude(^)|select PIDs*
    `lsof -i 4 -a -p {process_pid}`
  - `-o` *o 0t offset digits (8)*
  - `-u` *exclude(^)|select login|UID set s*
    `lsof -u root | more`
    `lsof -u ^root`
  - `-l` *list UID numbers*
    `lsof -l -u apache | more`
  - `-U` *select Unix socket*
    `lsof -i -U`
- 内容解释：
  1. **COMMAND**：这是进程的名称，也就是哪个程序或命令正在运行。
  2. **PID**：这是进程的标识符，每个正在运行的进程都有一个唯一的 PID。
  3. **PPID**：这是父进程的标识符。它表示启动该进程的父进程。请注意，要查看PPID，需要指定`-R` 参数。
  4. **USER**：这是运行该进程的用户。
  5. **FD**：这是文件描述符。文件描述符是一个整数，用于标识进程打开的文件。每个打开的文件都有一个与之关联的文件描述符，应用程序通过文件描述符来识别和操作文件。
      @import "lsof-FD.csv"
  6. **TYPE**：这表示文件的类型。
      @import "lsof-TYPE.csv"
  7. **DEVICE**：这表示文件所在的设备或磁盘
  8. **SIZE**：这表示文件的大小。
  9. **NODE**：这是文件的索引节点，它唯一地标识了文件系统中的文件或目录。
  10. **NAME**：这是打开文件的确切名称或路径。

---

- fuser

- alias
- unalias

- tar
  - `-z` gzip .gz、`-j` bzip2 .bz2、`J` xz .xz
  - `-c` `--create`
  - `-f` `--file=ARCHIVE`
  - `-x` `--extract` `--get`
  - `-C` `--directory=DIR`
  - `-t` `--list`

  - `-P` `--absolute-names`
  - `--exclude=PATTERN`
  - `-v` `--verbose`
- find
  - `-size N[bcwkMG]`
    - N 为数字，包括 `+n`、`-n`、`n`
  - `-type [bcdpflsD]`
  - `-name 匹配模式`
    - 支持通配符（==\* ? []==）
  - `-perm [-/]MODE`
  - `-user NAME`
  - `-group 名称`
  - `-mtime N`
    - N 为数字，包括 `+n`、`-n`、`n`
- wc
  - `-c` `--bytes`
  - `-m` `--chars`
  - `-l` `--lines`
  - `-L` `--Max-line-length`
  - `-w` `--words`

- su
  - `-`
- sudo
- visudo

- mail
  - 需要安装 mailx、postfix
  - `mail -s 主题 接收者的电子邮件地址` 写入内容，<kbd>Ctrl</kbd>+<kbd>d</kbd>结束输入并发送
  - `-A 文件` 通过文件发送邮件
  - `mail` 查看邮件，输入数字打开对应邮件，`q` 退出

- curl
  - `-k` `--insecure`

```bash
seq 200
strings /dev/urandom | tr -cd '_a-zA-Z0-9' | head -c 10
column -t user.txt
```

### 通配符

通配符可以用于各种参数，包括但不限于：

1. 命令行参数：在Linux命令行中，通配符常用于**文件名**匹配，如使用 `*` 来匹配任意文件名的文件。
2. 脚本参数：在脚本编程中，通配符可以用于匹配**字符串**、**数字**等参数。
3. 正则表达式：在正则表达式中，通配符是常用的**模式匹配**符号，如 `.` 表示匹配任意字符，`*` 表示匹配前面的字符 0 次或多次。
4. 配置文件参数：在配置文件中，通配符可以用于表示**任意值或参数**，如使用`*` 来表示任意 IP 地址。
5. 函数参数：在某些编程语言中，函数参数可以使用通配符来表示**不确定的参数类型或数量**。

---

- `*`：可以代表文件名中的任意字符或字符串，但不能与句点打头的文件名匹配。
- `?`：可以代表文件名中的任意一个字符。
- `[]`：用于构成字符组，表示可以匹配字符组中的任意一个字符。
- `[-]`：表示匹配一个范围内的任意字符。
- `{}`：用于表示多个条件的选择。
- `{..}`：用于表示多个条件的选择。
- `^`：在字符组内使用时表示反向选择，即排除指定字符之外的所有字符。
- `\`：用于转义通配符，使其作为普通字符使用。

### 正则表达式

- 基本正则列表
  <div align=center> <img alt="基本正则列表" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/基本正则表.png width=100%/> </div>
- 扩展正则列表
  <div align=center> <img alt="扩展正则列表" title="扩正则列表" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/扩展正则表.png width=100%/> </div>

## 快捷键

### 常用

- <kbd>Tab</kbd>
  : 自动补全
    : 可补齐命令字、选项、参数、文件路径、软件名、服务名
- <kbd>Ctrl</kbd> + <kbd>c</kbd>
  : 结束正在运行的命令
- <kbd>Esc</kbd> + <kbd>.</kbd> 或 <kbd>Alt</kbd> + <kbd>.</kbd>
  : 粘贴上一个命令的参数
- <kbd>Ctrl</kbd> + <kbd>l</kbd>
  : 清空整个屏幕

### 光标移动

| 快捷方式                       | 功能       |
| ------------------------------ | ---------- |
| <kbd>Ctrl</kbd> + <kbd>a</kbd> | 移到行首   |
| <kbd>Ctrl</kbd> + <kbd>e</kbd> | 移到行尾   |
| <kbd>Ctrl</kbd> + <kbd>f</kbd> | 前移一位   |
| <kbd>Ctrl</kbd> + <kbd>b</kbd> | 后移一位   |
| <kbd>Alt</kbd> + <kbd>f</kbd>  | 前移一单词 |
| <kbd>Alt</kbd> + <kbd>b</kbd>  | 后移一单词 |

### 命令历史

| 快捷方式                       | 功能         |
| ------------------------------ | ------------ |
| <kbd>Ctrl</kbd> + <kbd>p</kbd> | 上一条       |
| <kbd>Ctrl</kbd> + <kbd>n</kbd> | 下一条       |
| <kbd>Ctrl</kbd> + <kbd>r</kbd> | 反向搜索     |
| <kbd>Ctrl</kbd> + <kbd>s</kbd> | 正向搜索     |
| <kbd>Ctrl</kbd> + <kbd>g</kbd> | 退出搜索状态 |

### 命令清空

| 快捷方式                       | 功能         |
| ------------------------------ | ------------ |
| <kbd>Ctrl</kbd> + <kbd>u</kbd> | 删到开头     |
| <kbd>Ctrl</kbd> + <kbd>k</kbd> | 删到末尾     |
| <kbd>Ctrl</kbd> + <kbd>w</kbd> | 向前删一个词 |

### 命令补全

| 快捷方式                       | 功能         |
| ------------------------------ | ------------ |
| <kbd>Tab</kbd>                 | 自动补全     |
| <kbd>Ctrl</kbd> + <kbd>l</kbd> | 清屏         |
| <kbd>Ctrl</kbd> + <kbd>c</kbd> | 中断命令执行 |
| <kbd>Ctrl</kbd> + <kbd>d</kbd> | 关闭终端     |

### 文本编辑

| 快捷方式                              | 功能               |
| ------------------------------------- | ------------------ |
| <kbd>Ctrl</kbd> + <kbd>t</kbd>        | 交换光标前后字符   |
| <kbd>Ctrl</kbd> + <kbd>y</kbd>        | 粘贴上一次删除文本 |
| <kbd>Alt</kbd> + <kbd>d</kbd>         | 向后删一个词       |
| <kbd>Alt</kbd> + <kbd>backspace</kbd> | 向前删一个词       |

### 其他

| 快捷方式                                      | 功能                               |
| --------------------------------------------- | ---------------------------------- |
| <kbd>Ctrl</kbd> + <kbd>h</kbd>                | 删一个字符，相当于退格键           |
| <kbd>Ctrl</kbd> + <kbd>z</kbd>                | 将当前正在执行的命令放入后台并停止 |
| <kbd>Ctrl</kbd> + <kbd>x</kbd> + <kbd>u</kbd> | 撤销最近的编辑操作                 |

## 文件/目录

### */boot*

- `/boot/grub2/`

### */dev*

**设备存放目录**（键盘、鼠标、光驱、硬盘……）

- `/dev/cdrom` --> `/dev/sr0` 光驱设备
- `/dev/null`
- `/dev/sda` 磁盘设备

### */etc*

- `/etc/bashrc`
- `/etc/default/grub` # 内核引导文件
- `/etc/fstab`
- `/etc/group`
- `/etc/httpd/conf/httpd.conf` # httpd 主配置文件
- `/etc/login.defs`
- `/etc/passwd`
- `/etc/pki/rpm-gpg/RPM-GPG-KEY-*`
  - `/etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release`
- `/etc/profile` # 环境变量
- `/etc/resolv.conf` # 查看DNS服务器地址
- `/etc/shadow`
- `/etc/shells`
- `/etc/ssh/sshd_config` # 远程管理配置文件
- `/etc/sysconfig/network-scripts/` # 存放生成的网卡配置文件，如 `ifcfg-eth0`
- `/etc/vimrc`
- `/etc/yum.conf`
- `/etc/yum.repos.d/`
- `/etc/*-release` # 查看系统版本
  - `/etc/redhat-release`

### */proc*

- `/proc/meminfo` #内存详细信息

### */usr*

- `usr/games`

### */var*

- `/var/mail/` #用户邮件目录
- `/var/spool/mail/`

### HOME 家目录

- `.bashrc`
- `.bash_profile` #用户环境变量
- `.vimrc`
  - 参考：[.vimrc文件配置](https://blog.csdn.net/qq_43244515/article/details/124779889)、[.vimrc配置文件](https://zhuanlan.zhihu.com/p/487729667?utm_id=0)

  ```vim
  colorscheme desert "设置配色
  syntax on "语法高亮
  filetype on "文件类型识别
  au BufRead,BufNewFile *.sv set filetype=systemverilog
  au BufRead,BufNewFile *.v  set filetype=verilog
  "au是autocmd的缩写，BufRead和BufNewFile是触发自动命令的事件。BufNewFile是创建一个新文件，BufRead是将文件读入一个新缓冲区时触发。如：au BufRead,BufNewFile *.sv set filetype=systemverilog的意思是，当检测到文件类型是.sv结尾的文件时，将符合systemverilog语法的地方将高亮显示。

  set number "设置行号
  set autoindent "自动缩进

  set ts=2 "缩进
  set expandtab "空格替代 tab 缩进

  set shiftwidth=4
  autocmd FileType make set noexpandtab

  set hlsearch "搜索高亮
  set cursorline "光标所在行高亮
  set cursorcolumn "光标所在列高亮

  set guifont=Monospace\ 16 "设置 vim 自体大小

  inoremap ( ()<Esc>i "符号匹配
  inoremap { {}<Esc>i
  inoremap [ []<Esc>i
  inoremap " ""<Esc>i

  source ~/.vim/user/alias.vim "调用别名文件
  ```

## 软件

- `bash-completion` 支持<kbd>Tab</kbd>键的软件包
- `net-tools` 网络相关软件包
- `gcc` `make` 编译工具
- `pcre-devel` 正则表达式依赖包
- `openssl-devel` SSL加密依赖包

## 端口

### TCP

| 端口 | 协议  | 说明                             |
| ---- | ----- | -------------------------------- |
| 21   | FTP   | 文件传输协议，用于上传下载       |
| 22   | SSH   | 用于远程登录，管理网络设备       |
| 25   | SMTP  | 简单邮件传输协议，用于发送邮件   |
| 53   | DNS   | 域名系统                         |
| 80   | HTTP  | 超文本传输协议                   |
| 443  | HTTPS | 超文本传输协议，附带安全加密功能 |

### UDP

| 端口 | 协议 | 说明             |
| ---- | ---- | ---------------- |
| 69   | TFTP | 简单文件传输协议 |
| 53   | DNS  | 域名系统         |
| 123  | NTP  | 网络时间协议     |
