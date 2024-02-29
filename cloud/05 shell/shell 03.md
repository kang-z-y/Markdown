# Shell 脚本编程 03

- [中断控制](#中断控制)
- [case 语句](#case-语句)
- [函数](#函数)
- [字符串处理](#字符串处理)

## 中断控制

- [中断及退出](#中断及退出)
  - 中断/退出及相关指令
  - 脚本中断示例
  - 脚本退出示例

### 中断及退出

#### 中断/退出及相关指令

- 中断、继续、退出

| 类型       | 含义                                                             |
| ---------- | ---------------------------------------------------------------- |
| `break`    | 跳出当前所在的循环体，执行循环体后的语句块                       |
| `continue` | 跳过循环体内余下的语句，重新判断条件以决定是否需要执行下一次循环 |
| `exit`     | 退出脚本                                                         |

#### 脚本中断示例

- 从键盘循环取整数（0 结束）并求和，输出最终结果

  ```bash
  #!/bin/bash
  while read -p "请输入待累加的整数（0 结束）：" num
  do
      [ -z $num ] && continue
      [ $num -eq 0 ] && break
      let sum+=num
  done
  echo "总和是：${sum}"
  ```

- 跳过 1~20 以内非 6 的倍数，输出其他数的平方值
  
  ```bash
  #!/bin/bash
  for i in {1..20}
  do
      [ $[i%6] -ne 0 ] && continue
      echo "${i} 的平方值是：$[i*i]"
  done
  ```

#### 脚本退出示例

- 利用位置参数获取 2 个整数，计算出这两个整数的和
  如果参数不够 2 个，则提示正确用法并退出脚本

  ```bash
  #!/bin/bash
  [ -z $1 -o -z $2 ] && echo "格式：$0 num1 num2" && exit 10; # 退出脚本，返回值为 10
  echo $[$1+$2]
  ```

## case 语句

- [case 分支结构](#case-分支结构)
  - 语法结构及特点
  - case 分支的执行流程
  - 脚本应用示例
  - 编写部署软件脚本

### case 分支结构

#### 语法结构及特点

- 检查变量的实际取值
  - 如果与预设的值相匹配，则执行对应的操作
  
  ```bash
  case 变量值 in
  模式1|模式2)
      命令序列1;;
  模式3)
      命令序列2;;
  ...
  *)
      默认命令序列
  esac
  ```

#### case 分支的执行流程

<div align=center> <img alt="" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/case流程示意图.png width=100%/> </div>

#### 脚本应用示例

- 判断用户输入

  ```bash
  #!/bin/bash
  case $1 in
  abc)
      echo "xyz";;
  xyz)
      echo "abc";;
  *)
      echo "请输入'abc' 或 'xyz'"
  esac
  ```

#### 编写部署软件脚本

- 一键安装 *Nginx*
  - 一键源码安装 *Nginx* 软件
  - 脚本自动安装相关软件的依赖包（*gcc、make、openssl-devel、pcre-devel*）
  - 脚本自动判断 yum 是否可用

  ```bash
  1 #!/bin/bash
  2 [ `yum repoinfo | grep "^Repo-pkgs.* : [1-9,\,]*$" | wc -l` -eq 0 ] && echo "yum 不可用"     && exit 10;
  3 yum -y install gcc make openssl-devel pcre-devel
  4 tar -xf nginx-1.22.1.tar.gz
  5 cd nginx-1.22.1
  6 ./configure
  7 make
  8 make install
  ```

- 确认结果
  - 路径：*/usr/local/nginx*，其中 sbin 目录下放着主程序 nginx

  ```bash
  /usr/local/nginx/sbin/nginx # 启动服务
  /usr/local/nginx/sbin/nginx -s stop # 关闭服务
  ```

- 编写 Nginx 启动脚本
  - 脚本支持 start、stop、restart、status
  - 脚本支持报错提示
  - 脚本具有判断是否已经开启或关闭的功能
  
  ```bash
  #!/bin/bash
  cecho(){
      echo -e "\033[$1m$2\033[0m"
  }
  
  case $1 in
  start|on)
      /usr/local/nginx/sbin/nginx;;
  stop|off)
      /usr/local/nginx/sbin/nginx -s stop;;
  restart)
      /usr/local/nginx/sbin/nginx -s stop&>/dev/null
      /usr/local/nginx/sbin/nginx;;
  status)
      lsof -i :80 | grep -q nginx
      [ $? -eq 0 ] && cecho 32 "nginx 正在运行" || cecho 31 "nginx 未运行";;
  *)
      echo "用法:     $0 [start|on|stop|off|restart|status]"
  esac
  ```

#### 扩展

- `ss`
  - `-n` 以数字格式显示端口号
  - `-t` 显示 TCP 连接的端口
  - `-u` 显示 UDP 连接端口号
  - `-l` 显示服务正在监听的端口信息
  - `-p` 显示监听端口的服务名称是什么

---

- 在 Linux 系统中，可以使用 ANSI 转义序列来在终端中输出有颜色的文字。

  ```bash
  echo -e "\033[31m 这是红色文字 \033[0m"
  echo -e "\033[32m 这是绿色文字 \033[0m"
  echo -e "\033[34m 这是蓝色文字 \033[0m"

  # 3X 为字体颜色，4X 为背景颜色。
  ```

## 函数

- [Shell 函数](#shell-函数)
  - 关于函数的认识
  - 函数的定义与调用
  - 函数应用示例

### Shell 函数

#### 关于函数的认识

- 含义
  - 在 Shell 环境中，将一些需要重复使用的操作，定义为公共的语句块，即可称为函数
- 优点
  - 使脚本代码更简洁，增强易读性
  - 提高 Shell 脚本的执行效率
- 应用
  - 适用于比较复杂的启动/终止控制操作
  - 方便在需要时多次调用

#### 函数的定义与调用

```bash
function 函数名 {
    命令序列
    ...
}
# 或者
函数名() {
    命令序列
    ...
}
```

- 调用已定义的函数
  - 格式：`函数名`
  - 先定义了才能调用，就好比脚本的“内部指令”
- 函数传值
  - 格式：`函数名 值1 值2 ...`
  - 传递的值作为函数的“位置参数”

#### 函数应用示例

- 创建一个对 2 个整数求和的加法器
  
  ```bash
  function adder {
      echo $[$1+$2]
  }

  type adder
  ```

- 新建函数 mkcd，用来创建一个目录，并切换到此目录

  ```bash
  mkcd() {
      mkdir $1
      cd $1
  }
  ```

## 字符串处理

- [字符串截取](#字符串截取)
- [字符串替换](#字符串替换)
- [按条件掐头去尾](#按条件掐头去尾)
- [变量初始值处理](#变量初始值处理)

### 字符串截取

- 使用 `${}` 表达式
  - 格式：`${var:起始位置:长度}`[^1]

[^1]:编号从 0 开始，可省略

- 示例
  - 截取变量 NM 的前 6 个字符
  
  ```bash
  NM="Hello World!"
  echo ${NM::7}
  ```

#### 扩展 `$RANDOM`

- 在 Linux 和其他 Unix-like 操作系统中，`$RANDOM` 是一个特殊的变量，它会在 shell 中生成一个随机数。这个随机数是一个介于 ==0 到 32767== 之间的整数。
- 示例

  ```bash
  a=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
  n=$[RANDOM%62]
  echo ${a:n:1}
  ```

### 字符串替换

- 只替换第 1 个匹配结果
  - 格式：`${var/old/new}`
- 替换全部匹配结果
  - 格式：`${var//old/new}`
- 示例
  - 将变量 NM 中的 l 替换为 ##
  
  ```bash
  NM="Hello World!"
  echo ${NM//l/##}
  ```

### 按条件掐头去尾

- 掐头
  - 从左向右，最短匹配删除
    - 格式：`${变量名#*关键词}`[^2]
  - 从左向右，最长匹配删除
    - 格式：`${变量名##*关键词}`
  
[^2]:`*` 为通配符

  ```bash
  mdir="/var/spool/mail/root"
  echo ${mdir#*/}     # 删除到最近匹配

  echo ${mdir##*/}    # 删除到最远匹配
  ```

- 去尾
  - 从右向左，最短匹配删除
    - 格式：`${变量名%关键词*}`
  - 从右向左，最长匹配删除
    - 格式：`${变量名%%关键词*}`

  ```bash
  mdir="var/spool/mail/root"
  echo ${mdir%o*}     # 删除到最近匹配
  echo ${mdir%%o*}    # 删除到最远匹配
  ```

- 示例
  - 实现批量改名，将扩展名 `.doc` 改为 `.txt`
  
  ```bash
  #!/bin/bash
  for file in *.doc
  do
      mv $file ${file%.doc}.txt
  done
  ```

### 变量初始值处理

- 取值，`${war:-word}`
  - 若变量 var 已经存在且非 Null，则返回 `$var`
  - 否则返回字串 `word`，变量 var 值不变

- 示例
  - 提示输入一个正整数 x，求从 1~x 的和
    若用户未输入值，则赋初值 x=1，避免执行出错

  ```bash
  #!/bin/bash
  read -p "请输入一个正整数：" x
  n=${x:-1}
  for((i=1;i<=n;i++))
  do
      sum+=i
  done
  echo $sum
  ```
