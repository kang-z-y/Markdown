# 云计算系统管理 04

- [归档及压缩](#归档及压缩)
- [重定向与管道操作](#重定向与管道操作)
- [find 精确查找](#find-精确查找)
- [vim 高级使用](#vim-高级使用)

## 归档及压缩

- [tarball 备份包](#tarball-备份包)
  - 归档和压缩
  - tar 工具的常用选项
- [备份与恢复操作](#备份与恢复操作)
  - 制作 tar 备份包
  - 查看 tar 备份包内容
  - 从 tar 备份包恢复文档

### tarball 备份包

#### 归档和压缩

- 归档的含义
  - 将许多零散的文件整理为一个文件
  - 文件总的大小基本不变
- 压缩的含义
  - 按某种算法减小文件所占用空间的大小
  - 恢复时按对应的逆向算法解压

- Linux 中常见的压缩格式
  @import "src/csv/admin-4-1.csv"

### tar 工具的常用选项

- `-c` `--create` 创建归档
- `-x` `--extract` `--get` 释放归档
- `-t` `--list` 显示归档中的文件清单
- `-f` `--file=ARCHIVE`指定归档文件名称。**由于该选项有参数，多个选项一起写时，该选项应放在最后，然后加上归档名的参数**
- `-C` `--directory=DIR`，指定路径

---

- 压缩格式选项
  @import "src/csv/admin-4-2.csv"

### 备份与恢复操作

#### 制作 tar 备份包

- 使用 `tar -c ...` 命令
  - `tar -zcf 备份文件.tar.gz 被备份的文档 ...`
  - `tar -jcf 备份文件.tar.bz2 被备份的文档 ...`
  - `tar -Jcf 备份文件.tar.xz 被备份的文档 ...`

  ```bash
  tar -jcf /root/home.tar.bz2 /home
  ls -lh /root/home.tar.bz2
  ```

---

- tar包名字后缀 `.tar.gz` 简写 `.tgz`
- 打包时不要路径需要加 `-C`，以及路径与文件间需要加空格
  - 例如：`tar -zcf /root/haha.tar.gz -C /etc/ passwd hosts`
  - **其实是跑到相应路径下使用相对路径方式进行打包**
- 选项中不添加压缩选项，表示只做归档而不进行压缩
- 也可以只做压缩而不归档
  - 不归档只能压缩单个文件，并且会直接把源文件压缩（该方法基本绝迹）

#### 查看 tar 备份包

- 使用 `tar -t ... 命令`
  - `tar -tf 备份文件.tar.gz`

  ```sh
  tar -tf /root/home.tar.bz2
  ```

#### 从 tar 备份包恢复文档

- 使用 `tar -x ... 命令`
  - `tar -xf 备份文件.tar.gz [-C 目标文件夹]`

  ```sh
  rm -rf /home
  tar -xf /root/home.tar.bz2 -C /
  ls -ld /home/

  tar -xf /root/home.tar.bz2 -C /tmp/
  ls -ld /tmp/home/
  ```

## 重定向与管道操作

- [重定向](#重定向)
  - 重定向输出
- [管道操作](#管道操作)
  - 管道传递

### 重定向

- 重定向输出
  - 将屏幕显示信息保存到文件
    （将前面命令的输出，作为文件内容，写入到后面的文件中）
    - 覆盖重定向：`cmd > file`
    - 追加重定向：`cmd >> file`

    ```sh
    hostname > /opt/hn.txt
    cat /opt/hn.txt

    hostname >> /opt/hn.txt
    cat /opt/hn.txt
    ```

  <div align=center> <img alt="重定向输出" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/重定向输出.png width=80%/> </div>

### 管道操作

- 管道传递
  - 使用 `|` 管道操作
    - 将前一跳命令的标准输出交给后一条命令处理
    - `cmd1 | cmd2 [| cmd3] ...`

    ```sh
    ls --help | less
    ifconfig | head -2
    head -12 /etc/passwd | tail -5
    ```

- 不支持管道的命令
  - 没有参数也能执行的命令
  - 需要两个参数才能执行的命令

## find 精确查找

- [find 基本使用](#find-基本使用)
  - 常用条件
- [find 高级使用](#find-高级使用)
  - 处理查找的内容

### find 基本使用

- 常用条件
  - 根据预设的条件递归查找对应的文件
    - `find [目录] [条件1]`
    - 常用条件表示：
      - `-type 类型（f、d、l）`
      - `-name "文档名称"`
      - `-size +|-文件大小（k、M、G）`
      - `-user 用户名`
      - `-mtime 修改时间`

### find 高级使用

- 处理查找的内容
  - 操作方法：
    - `find [范围] [条件] -exec 处理命令 {} ... \;`[^1]

    ```sh
    find /boot -size _10M

    find /boot -size +10M -exec ls -lh {} \;
    ```

[^1]:`{}`：替代每一个查找结果
`\;`：处理操作结束

### 扩展

格式：`find [路径] [匹配条件] [动作]`

#### 路径

- 是要查找的**目录路径**，可以是一个**目录或文件名**，也可以是**多个路径**，多个路径之间用**空格分隔**，如果**未指定**路径，则默认为**当前目录**。

#### expression

- 是可选参数，用于指定查找的条件，可以是文件名、文件类型、文件大小等等。

- **匹配条件**中可使用的选项有二三十个之多，以下列出最常用的部份：

  - `-name pattern`：按文件名查找，支持使用通配符 * 和 ?。
  - `-type type`：按文件类型查找，可以是 f（普通文件）、d（目录）、l（符号链接）等。
  - `-size [+-]size[cwbkMG]`：按文件大小查找，支持使用 + 或 - 表示大于或小于指定大小，单位可以是 c（字节）、w（字数）、b（块数）、k（KB）、M（MB）或 G（GB）。
  - `-mtime days`：按修改时间查找，支持使用 + 或 - 表示在指定天数前或后，days 是一个整数表示天数。
  - `-user username`：按文件所有者查找。
  - `-group groupname`：按文件所属组查找。

- **可以有多个匹配条件，默认关系为与，两个条件之间加上`-o`表示或**

#### 动作

- 可选的，用于对匹配到的文件执行操作，比如删除、复制等。
- 例：`find /path/to/search -name "pattern" -exec rm {} \;`
  - 这个例子中，`-exec` 选项允许你执行一个命令，`{}` 将会被匹配到的文件名替代，`\;` 表示命令结束。

#### 其他

- find 命令中用于时间的参数如下：
  - `-amin n`：查找在 n 分钟内被访问过的文件。
  - `-atime n`：查找在 n*24 小时内被访问过的文件。
  - `-cmin n`：查找在 n 分钟内状态发生变化的文件（例如权限）。
  - `-ctime n`：查找在 n*24 小时内状态发生变化的文件（例如权限）。
  - `-mmin n`：查找在 n 分钟内被修改过的文件。
  - `-mtime n`：查找在 n*24 小时内被修改过的文件。
- 在这些参数中，n 可以是一个正数、负数或零。
  - 正数表示在指定的时间内修改或访问过的文件
  - 负数表示在指定的时间之前修改或访问过的文件
  - 零表示在当前时间点上修改或访问过的文件

---

- `/proc` 该目录表示内存的数据，不占用磁盘空间，使用find查找到该目录时报错是正常的

#### wc

格式：`wc [-clw][--help][--version][文件...]`

- `-c`或`--bytes` 只显示Bytes数。
- `-m`或`--chars` 显示字符数
- `-l`或`--lines` 显示行数。
- `-L`或`--max-line-length` 显示单行最宽的长度
- `-w`或`--words` 只显示字数。
- `--help` 在线帮助。
- `--version` 显示版本信息。

## vim 编辑技巧

- [命令模式操作](#命令模式操作)
  - 光标跳转
  - 复制/粘贴/删除
  - 查找/撤销/保存
- [末行模式操作](#末行模式操作)
  - 保存/退出/文件操作
  - 字符串替换
  - 开关参数的控制
- [文件内容对比](#文件内容对比)
  - vimdiff 命令

### 命令模式操作

- **光标跳转**
  @import "src/html/admin-4-1.html"
- **复制/粘贴/删除**
  @import "src/html/admin-4-2.html"
- **查找/撤销/保存**
  @import "src/html/admin-4-3.html"

### 末行模式操作

- 保存/退出/文件操作
  @import "src/html/admin-4-4.html"
- 字符串替换
  @import "src/html/admin-4-5.html"
- 开关参数的控制
  @import "src/html/admin-4-6.html"

### 文件内容对比

- vimdiff 命令
  - 操作方法：`vimdiff file1 file2`
  - ==命令模式下 <kbd>Ctrl</kbd>+<kbd>w</kbd> 同时按下，然后左右移动光标切换窗口==
  - ==末行模式 waq 保存并退出==
