# Shell 脚本编程 02

- [条件测试](#条件测试)
- [If 选择结构](#if-选择结构)
- [循环结构](#循环结构)

## 条件测试

- [测试操作概述](#测试操作概述)
  - Shell 脚本的智能化
  - `test` 测试操作
- [常见的测试操作](#常见的测试操作)
  - 整数值比较
  - 字符串比较
  - 文件状态测试
- [组合多个条件](#组合多个条件)
  - 逻辑分隔操作
  - 条件组合应用

### 测试操作概述

#### Shell 脚本的智能化

- 使 Shell 脚本获得识别能力
- 为命令的执行提供最直接的识别依据
  - 文件或目录的读/写等状态
  - 数值的大小
  - 字符串是否匹配
  - 多条件组合

#### `test` 测试操作

- 语法格式
  - `test 表达式`
  - [ 表达式 ]
  - `help test` 查阅帮助
- 使用命令 `echo $?` 查看判断结果

### 常见的测试操作

#### 判断表达式

  | 格式                     | 说明  |
  | ------------------------ | ----- |
  | `[ 表达式 ]`             | true  |
  | `[ !表达式 ]`            | false |
  | `[ 表达式1 -a 表达式2 ]` | and   |
  | `[ 表达式1 -o 表达式2 ]` | or    |

#### 字符串比较

- `[ 操作符 字符串 ]`
- `test 操作符 字符串`
  
  | 格式 | 说明           |
  | ---- | -------------- |
  | `-n` | 非空（`! -z`） |
  | `-z` | 为空           |

- `[ 字符串1 操作符 字符串2 ]`
- `test 字符串1 操作符 字符串2`

  | 格式 | 说明 |
  | ---- | ---- |
  | `==` | 相等 |
  | `!=` | 不等 |

#### 整数值比较

- `[ 整数值1 操作符 整数值2 ]`
- `test 整数值1 操作符 整数值2`
  
    | 选项  | 说明                  |
    | ----- | --------------------- |
    | `-eq` | EQual                 |
    | `-ne` | Not Equal             |
    | `-ge` | Greater than or Equal |
    | `-gt` | Greater Than          |
    | `-le` | Less than or Equal    |
    | `-lt` | Less Than             |

#### 文件状态测试

- `[ 操作符 文件或目录 ]`
- `test 操作符 文件或目录`

  | 格式       | 说明                  |
  | ---------- | --------------------- |
  | `-a`、`-e` | Exist                 |
  | `-d`       | Directory             |
  | `-f`       | File                  |
  | `-r`       | Read（对 root 无效）  |
  | `-w`       | Write（对 root 无效） |
  | `-x`       | eXcute                |
  | `-s`       | 内容不为空            |
  | `-h`、`-L` | 符号链接              |
  | `-O`       | 所有                  |
  | `-G`       | 组所有                |

- `[ 文件或目录 操作符 文件或目录 ]`
- `test 文件或目录 操作符 文件或目录`

  | 格式  | 说明     |
  | ----- | -------- |
  | `-nt` | New Than |
  | `-ot` | Old Than |
  | `-ef` | 硬链接   |

### 组合多个条件

#### 逻辑分隔操作

- 主要用法：
  - `命令1 操作符 命令2 ...`
  - `[ 条件1 ] 操作符 [ 条件2 ]`

  | 操作符 | 含义                                     |
  | ------ | ---------------------------------------- |
  | `&&`   | 给定条件必须都成立，整个测试结果才为真   |
  | `\|\|` | 只要其中一个条件成立，则整个测试结果为真 |

#### 条件组合应用

- 当前用户为 root，且位于 */root* 目录下
  
  ```bash
  [ $USER == "root" ] && [ $PWD == "/root" ]
  [ $? -eq 0 ] && echo YES
  ```

- 当 */opt/testdir* 目录不存在时，创建该目录
  
  ```bash
  [ -d "/opt/testdir" ] || mkdir -p /opt/testdir
  ls -ld /opt/testdir/
  ```

## If 选择结构

- [单分支结构](#单分支结构)
- [双分支结构](#双分支结构)
- [多分支结构](#多分支结构)

### 单分支结构

- 语法及格式
  - 当“条件成立”时执行命令序列
  - 否则，不执行任何操作
  
  ```bash
  if [ 条件 ];then
      # 命令序列
  fi
  ```

- 流程示意图
  
  ```mermaid
  graph LR
    AA(...)
    A{"if 条件测试"}
    B(命令序列)
    C("fi 结束判断")
    CC(...)
    AA-.->A
    A--true-->B
    B-->C
    A--false-->C
    C-.->CC
  ```

- 示例
  - 判断挂载点目录，若不存在则创建
  
  ```bash
  #!/bin/bash
  MOUNT_DIR="/media/cdrom"
  if[!-d $MOUNT_DIR]
  then
      mkdir -p $MOUNT_DIR
  fi
  ```

### 双分支结构

- 语法及格式
  - 当“条件成立”时执行命令序列1
  - 否则，执行命令序列2
  
  ```bash
  if [ 条件 ];then
      # 命令序列1
  else
      # 命令序列2
  fi
  ```

- 流程示意图
  
  ```mermaid
  graph LR
    AA(...)
    A{"if 条件测试"}
    B(命令序列1)
    C(命令序列2)
    D("fi 结束判断")
    DD(...)
    AA-.->A
    A--true-->B
    B-->D
    A--false-->C
    C-->D
    D-.->DD
  ```

- 示例
  - 检测并判断指定的主机是否可 ping 通
  - 目标主机的地址以位置参数提供
  
  ```bash
  #!/bin/bash
  read -p "请输入要测试的ip：" ip
  ping -c 3 -i 0.2 -W 1 $ip &>/dev/null
  if [ $? -eq 0 ];then
      echo 通了！
  else
      echo 不通！
  fi
  ```

### 多分支结构

- 语法及格式
  - 相当于 if 语句嵌套
  - 针对多个条件分别执行不同的操作
  
  ```bash
  if [ 条件 ];then
      # 命令序列1
  elif [ 条件 ];then
      # 命令序列2
  
  ...

  else
      # 命令序列n
  fi
  ```

- 流程示意图
  
  ```mermaid
  graph LR
      AA(...)
      A1{"if 条件测试1"}
      B1(命令序列1)
      A2{"if 条件测试2"}
      B2(命令序列2)
      A3("else")
      B3(命令序列n)
      C("fi 结束判断")
      CC(...)
      AA-.->A1
      A1--true-->B1-->C
      A1--false-->A2
      A2--true-->B2-->C
      N--true-->NN(命令序列n-1)-->C
      A2-.false..->N(...)-->A3
      A3-->B3-->C
      C-.->CC
  ```

- 示例
  - 输入一个分数，判断成绩分档
  - 85~100 优秀、70~84 良好、低于 70 不及格
  
  ```bash
  #!/bin/bash
  if [ -n $1 ];then
      sc=$1
  else
      read -p "请输入分数(0-100):" sc
  fi
  
  if [ $sc -gt 100 -o $sc -lt 0 ];then
      echo 格式错误!
  elif [ $sc -ge 85 ];then
      echo 优秀
  elif [ $sc -ge 70 ];then
      echo 良好
  else
      echo 不及格
  fi
  ```

## 循环结构

- [for 循环](#for-循环)
- [while 循环](#while-循环)

### for 循环

- 遍历/列表式循环
  - 根据变量的不同取值，重复执行命令序列

  ```bash
  for 变量 in 列表
  do
      # 命令序列
  done
  ```

- 流程示意图
  
  ```mermaid
  graph LR
      AA(...)
      A[for 变量=取值1]
      B(do 命令序列)
      C{{取值1\n取值2\n...\n取值n}}
      D(done 结束循环)
      DD(...)
      AA-.->A
      A-->B
      B-->C
      C-->A
      B-->D
      D-.->DD
  ```

- 示例
  - 批量添加用户帐号（名称无规律）

  ```bash
  #!/bin/bash
  ULIST=$(cat /root/users.txt)
  for UNAME in $ULIST
  do
      useradd $UNAME
      echo "123" | passwd --stdin $UNAME
  done
  ```

- **C 语言风格的 for 循环**
  - 通过变量控制，条件成立时循环
  - 步长可控制
  
  ```bash
  for ((初值;条件;步长控制))
  do
      # 命令序列
  done
  ```

#### 生成列表方式

1. `1 2 3 4` `a b c`
2. `{1,2,4,5}` `{1..100}` 只能是常量
3. `seq 100` 1 到 100

### while 循环

- 条件式循环
  - 反复测试条件，只要成立就执行命令序列

  ```bash
  while 条件
  do
      # 命令序列
  done
  ```

- l流程示意图

  ```mermaid
  graph LR
  AA(...)
  A{while 条件测试}
  B(do 命令序列)
  C(done 结束循环)
  CC(...)
  AA-.->A
  --条件成立-->B-->A
  --条件不成立-->C-.->CC
  ```

- 示例
  - 批量添加用户（名称有规律）

  ```bash
  #!/bin/bash
  PREFIX="tuser";i=1
  while [ $i -le 5 ]
  do
      useradd ${PREFIX}$i
      echo 123 | passwd --stdin ${PREFIX}$i &>/dev/null
      let i++
  done
  ```

- 需要长时间运行的循环，循环体中加上 `sheep 时间` 可以减轻 CPU 压力
