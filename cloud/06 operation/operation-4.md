# Linux 高级运维 04

- [Session 与 Cookie](#session-与-cookie)
- [部署 Redis](#redis)
- [Session 共享](#session)
- [Nginx 实现跨域](#跨域访问)

## Session 与 Cookie

- [基本概念](#基本概念-1)
  - Session & cookies
  - 案例拓扑
- [本地 Session](#本地-session)
  - 部署 Nginx 调度器
  - 部署后端 LNMP 主机
  - 部署测试页面
  - 客户端访问
  - 验证 Session

### 基本概念 1

- ***Session***
  - 存储在服务器端，保存用户名、登陆状态等信息
- ***Cookies***
  - 由服务器下发给客户端，保存在客户端的一个文件里。保存的内容主要包括：SessionID
- 案例拓扑
  <div align=center> <img alt="Session与Cookies案例拓扑" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/Session与Cookies案例拓扑.png width=100%/> </div>

### 本地 Session

#### 部署 Nginx 调度器

- 安装 Nginx 软件
  
  ```sh
  tar -zxvf nginx-1.22.1.tar.gz
  cd nginx-1.22.1
  ./configure
  make && make install
  ```

- 安装 redis 软件
  
  ```sh
  yum -y install redis
  ```

- 修改配置文件（*/usr/local/nginx/conf/nginx.conf*）
  
  ```conf
  upstream webs {
      server 192.168.99.100:80;
      server 192.168.99.200:80;
  }
  server {
    ...
    location / {
        proxy_pass http://webs;
    }
    ...
  }
  ```

- 启动服务
  `/usr/local/nginx/sbin/nginx`

#### 部署后端 LNMP 主机

1. 安装 Nginx
2. 安装 MariaDB（*mariadb mariadb-server mariadb-devel*）
3. 安装 PHP（*php php-mysqlnd php-fpm*）
4. 启动服务（*nginx php-fpm mariadb*）
5. 注意：以上安装 LNMP 和启动服务需要在后端两台主机都操作
6. 在后端两台 LNMP 主机都操作

   ```sh
   cd lnmp-soft/php_scripts/session/
   tar -xf php-session-demo.tar.gz
   cp * /usr/local/nginx/html
   ```

#### 部署测试页面

- 注意：
  - 以上安装 LNMP 和启动服务需要在后端两台主机都操作
- 在后端两台 LNMP 主机都操作
  
  ```sh
  cd lnmp-soft/php_scripts/session/
  tar -xf php-session-demo.tar.gz
  cd php-session-demo/
  cp * /usr/local/nginx/html
  ```

#### 客户端访问

- 浏览器直接访问后端的 LNMP 逐句 192.168.99.100
- 浏览器直接访问后端的 LNMP 逐句 192.168.99.200
- 浏览器访问调度器，刷新页面后需要登陆两次

#### 验证 Session

- 登陆后端两台 LNMP 主机分别查看
  
  ```sh
  ls /var/lib/php/session
  ```

## redis

- [redis 概述](#redis-概述)
  - 数据存储对比
  - redis 简介
- [部署软件](#部署软件)
  - 安装与配置
  - 测试 redis
- [PHP + redis](#php--redis)
  - PHP + redis 介绍
  - 安装 PHP 的 redis 扩展

### redis 概述

#### 数据存储对比

- 性能
  - $CPU缓存>内存>磁盘>数据库$
- 价格
  - $CPU缓存>内存>磁盘>数据库$

#### redis 简介

- Redis（*Remote Dictionary Server*）远程字典服务
  - **Key-Value** 数据库
  - 数据可以存储在内存中以保证高性能

### 部署软件

#### 安装与配置

```sh
yum -y install redis
vim /etc/redis.conf
```

- *redis.conf* 配置

  ```conf
  #bind 127.0.0.1 # 开放使用
  protected-mode no # 关闭保护
  ```

```sh
systemctl restart redis
```

#### 测试 redis

- 进入 redis 界面
  `redis-cli`

- redis 部分指令
  
  ```sql
  set abc 456 # 创建/修改变量 abc，值为 "456"
  get abc     # 查看变量 abc 的值
  keys *      # 查看当前库中所有 key
  del abc     # 删除变量 abc
  flushall    # 删除所有数据
  quit        # 退出
  ```

### PHP + redis

#### PHP + redis 介绍

- 部署 LNMP
  - 使用 php 页面，测试对 redis 的读写操作
  - 具体操作参考第二章节 Nginx + FastCGI
- PHP 无法直接操作 redis
  - 需要安装 redis 扩展

#### 安装 PHP 的 redis 扩展

```sh
yum install phpredis-5.1.0-1.x86_64.rpm
rpm -ql phppredis-5.1.0-1.x86_64.rpm

systemctl restart php-fpm
```

## Session

- [实现 Session 共享](#实现-session-共享)
  - 修改 PHP 配置文件
  - 重启服务
  - 测试 Session 共享

### 实现 Session 共享

- 修改 PHP 配置文件
  */etc/php-fpm.d/www.conf*

  ```conf
  # 修改前
  php_value[session.save_handler] = files
  php_value[session.save_pass] = /var/lib/php/session

  # 修改后
  php_value[session.save_handler] = redis
  php_value[session.save_pass] = "tcp://192.168.99.5:6379"
  ```

- 重启服务
  `systemctl restart php-fpm`
- 测试 Session 共享
  - 浏览器访问调度器，刷新页面后，登录账户会被记录在 redis 服务器
  - 刷新页面，调度器==切换服务器后==，账户信息还在
  - 两台后端服务器使用的是同一个账户

## 跨域访问

- 基本概念
  - 同源策略
- Nginx 实现跨域
  - 配置
  - 测试

### 基本概念 2

#### 同源策略

- 它定义了浏览器访问网站时，需要**域名**、**协议**、**端口**相同
- 是重要的安全策略，防止了恶意数据的传递

### Nginx 实现跨域

#### 配置

- 创建两个虚拟主机，分别是 80 端口和 8080 端口
  
  ```conf
  html {
      server {
          listen 8080;
          charset utf8;
          location / {
              root html
              index index.html;
          }
      }
      ...
      server {
          ...
      }
  }
  ```

- 80 端口的虚拟主机准备首页，点击测试按钮可以调用 8080 端口

- *80.html*
  
  ```html
  <html>
  <head>
      <meta charset="UTF-8">
      <title>API-test</title>
      <script>
          var xhr = new XMLHttpRequest();
          xhr.open('GET', 'http://192.168.99.5:8080/api.html',true);
          xhr.send();
          function change(){
              if(xhr.readyState==4 && xhr.status==200){
                  alert(xhr.responseText);
              }
          }
      </script>
  </head>
  <body>
    <input  id="button" type="button" value="测试" onclick="change();">
  </body>
  ```

- *api.html*
  
  ```html
  8080 虚拟主机测试页面
  ```

#### 测试

- 未使用跨域配置前，通过 80 端口的虚拟主机调用 8080 端口虚拟主机资源会失败，添加**头字段** <font color=red>Access-Control-Allow-Origin</font> 之后解决问题

  ```conf
  html {
      server {
          listen 8080;
          charset utf8;
          location / {
              header 'Access-Control-Allow-Origin' '*'; # 服务器响应数据中添加允许跨域访问，* 表示任意地址
              # 为了安全可以写具体请求地址
              #header 'Access-Control-Allow-Origin' 'http://192.168.99.5';
              root html
              index index.html;
          }
      }
      ...
      server {
          ...
      }
  }
  ```
