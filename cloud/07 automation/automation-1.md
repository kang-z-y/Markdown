# 自动化运维

- [Ansible 基础](#ansible-基础)
- [掌握 Ansible ad-hoc 命令](#ansible-ad-hoc)
- [Ansible 模块应用](#ansible-模块应用)

## Ansible 基础

- [Ansible 简介](#ansible-简介)
  - 什么是 Ansible
  - Ansible 产品特色
- [环境部署](#环境部署)
  - 主机列表
  - 配置 yum 源
  - 配置 SSH 密钥
  - 部署软件
  - 修改主配置文件
  - 主机清单文件

### Ansible 简介

#### 什么是 Ansible

- Ansible 首次发布于 *2012* 年，作者 *Michael DeHaan*
  - *Michael DeHaan* 也是 Cobbler 的作者
  - 于 *2015* 年被 RedHat 收购
- Ansible 是一款自动化运维工具，基于 Python 开发
  - 批量系统配置
  - 批量程序部署
  - 批量运行命令等功能

---

- 传统运维

  <div align=center> <img alt="传统运维" title="传统运维" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/传统运维.png width=80%/> </div>

- 自动化运维

  <div align=center> <img alt="自动化运维" title="自动化运维" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/自动化运维.png width=80%/> </div>

- Ansible

  <div align=center> <img alt="Ansible" title="什么是 Ansible" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/Ansible.png width=80%/> </div>

#### Ansible 产品特色

- <font color=red>基于 SSH 架构</font>
- 社区活跃
- 支持异构 IT 架构
- <font color=red>模块丰富</font>
- 支持自定义模块
- 部署简单，容易上手

### 环境部署

#### 主机列表

@import "src/csv/automation-1-1.csv"

#### 配置 yum 源

- 在 192.168.88.240 上配置 yum 源
  - ansible 软件包拷贝至 192.168.88.240 的 */var/ftp/rpms* 目录，更新 yum 服务器仓库源

  ```sh
  createrepo /var/ftp/rpms
  ```

  - 在原有 yum 配置文件下方增加以下内容

    ```repo
    [rpms]
    name = rpms
    baseurl = ftp://192.168.88.240/rpms
    enable = 1
    gpgcheck = 0
    ```

- 注意：该 yum 源为 ftp 服务地址
  - 需要安装 vsftpd 包、更改 vsftpd 配置、并启动服务

#### 配置 SSH 密钥

- pubserver 控制节点
  - 修改 */etc/hosts*

    ```hosts
    ...
    192.168.88.240    pubserver
    192.168.88.11    web1
    192.168.88.12    web2
    192.168.88.13    db1
    ```

  - 配置 SSH 密钥

    ```sh
    ssh-keygon -f /root/.ssh.id_rsa -N ''
    for i in web{1..2} db1
    do
        ssh-copy-id $i
    done
    ```

#### 部署软件

- pubserver 控制节点（提前配置 YUM 源，或者将软件拷贝到目录）

  ```sh
  yum -y install ansible
  ```

- 被控制节点
  - Ansible 默认通过 SSH 协议管理机器
  - 被管理主机要开启 SSH 服务，并允许控制主机登陆
  - 被管理主机需要安装有 Python

#### 修改主配置文件

- 主配置文件 <font color=red>ansible.cfg</font>
  - 参考 */etc/ansible/ansible.cfg*
- ansible 配置文件查找顺序
  - 首先检测 **ANSIBLE_CONFIG** 变量定义的配置文件
  - 其次检查当前目录下的 *./ansible.cfg* 文件
  - 再次检查当前用户家目录下 *~/ansible.cfg* 文件
  - 最后检查 */etc/ansible/ansible.cfg* 文件

- 创建主配置文件

  ```sh
  mkdir ansible
  cd ansible

  echo -e "[defaults]
  host_key_checking=false
  inventory=inventory" > ansible.cfg

  # host_key_checking=false
  # 不检查主机密钥，=号两边空格可有可无

  # inventory = inventory
  # 定义主机清单文件为当前目录的 inventory
  ```

#### 主机清单文件

- 将被管理端主机写入一个主机列表文件（主机清单）
  - 参考 */etc/ansible/hosts*（必须和主配置文件名一致）

  ```sh
  echo "[webservers]
  web[1:2]
  [dbs]
  db1
  
  [cluster:children]
  webservers
  dbs" > inventory

  # web[1:2]
  # web1 和 web2 的简化写法，表示从 1 到 2

  # cluster 是组名，自定义的；:children 是固定写法，表示下面的组名是 cluster 的子组
  ```

## Ansible ad-hoc

- [基本命令](#基本命令)
  - 命令行语法格式
  - 快速入门
- [常用模块](#常用模块)
  - shell 模块
  - script 模块
  - file 模块
  - copy 模块
  - fetch 模块
  - lineinfile|replace 模块
  - user 模块
  - group 模块

### 基本命令

#### 命令行语法格式

- Ansible ad-hoc 是一种通过命令行批量管理的方式
  - 格式：`ansible 主机集合 -m 模块名 -a "参数"`
  - 其他参数：`-k` 使用密码远程

  ```sh
  cd ~/ansible

  # 查看所有主机列表
  ansible all --list-hosts

  # 调用 ping 模块
  ansible web1,db1 -m ping
  ansible all -m ping
  ```

#### 快速入门

- 模块就是脚本（多数为 Python 脚本）
  - 多数脚本都支持参数
  - 默认模块为 **command**

  ```sh
  ansible web1 -m command -a "uptime"
  ansible web1 -m command -a "uname -r"
  ansible web1 -m command -a "ip a s"
  ansible web1 -m -a "ip a s"
  ansible web1 -m -a "date"
  ```

- 获取帮助
  - Ansible 总共有哪些模块？
  - 每个模块支持哪些选项？

  ```sh
  ansible-doc -l            # 列出所有模块
  ansible-doc -l | grep yum # 过滤模块
  ansible-doc -l | wc -l    # 统计模块
  ansible-doc yum           # 查看模块帮助
  ```

### 常用模块

#### shell 模块

- command 和 shell 模块的区别
  - command 不支持 bash 的特性，如**管道和重定向**等功能
  - 所有需要调用 shell 的功能都无法使用

  ```sh
  ansible web1 -m command -a "ps | wc -l" # 报错
  ansible web1 -m command -a "ls &"       # 报错
  ```

- shell 模块会启动 shell 执行命令
  - 不可以使用 shell 模块执行交互命令，如 `vim`、`top` 等

  ```sh
  ansible web1 -m shell -a "ps aux | wc -l"   # 进程数量
  ansible web1 -m shell -a "who"    # 登陆信息
  ansible web1 -m shell -a "touch /tmp/txt.txt"
  ```

#### script 模块

- 如果复杂的命令怎么办？
  - script 允许在本地写脚本，拷贝到被管理端并执行脚本
  - 可以不是 shell 脚本（如 python、perl 脚本等），可以没有 `-x`

  `vim test.sh`

    ```sh
    #!/bin/bash

    for user in user{1..5}
    do
        useradd $user
        echo '123456' | passwd --stdin $user
    done
    ```
  
  ```sh
  ansible webservers -m script -a "test.sh"
  ```

#### file 模块

- file 模块可以创建文件、目录、链接；修改权限与属性等
  - **<font color=red>幂等性</font>**：任意次执行所产生的影响均与一次执行的影响相同

#### copy 模块
#### fetch 模块
#### lineinfile|replace 模块
#### user 模块
#### group 模块

## Ansible 模块应用
