# Linux 高级运维 01

- [Nginx 安装部署](#nginx-安装部署)
- [用户认证](#用户认证)
- [Web 虚拟主机](#nginx-虚拟主机)
- [HTTPS 加密网址](#https-加密网站)

## Nginx 安装部署

- [Nginx 安装](#nginx-安装)
  - Web 服务器对比
  - Nginx 简介
  - Nginx 进程管理

### Nginx 安装

#### Web 服务器对比

- Unix 和 Linux 平台下
  - *Apache、Nginx、Tengine、Lighttpd*
  - *Tomcat、IBM WebSphere、Jboss*
- Windows 平台下
  - 微软公司的 IIS（*Internet Information Server*）

#### Nginx 简介

- Nginx（*engine x*）
  - 是俄罗斯人编写的十分轻量级的 HTTP 服务器
  - 是一个高性能的 HTTP 和反向代理服务器，同时也是一个 IMAP/POP3/SMTP 代理服务器
  - 官方网站：<http://nginx.org>
- Nginx 软件安装

  ```bash
  yum -y install gcc pcre-devel openssl-devel make
  useradd nginx -s /sbin/nologin
  tar -zxvf nginx-1.22.1.tar.gz
  cd nginx-1.22.1

  ./configure \
  --prefix=/usr/local/nginx \   # 指定安装目录
  --user=nginx \                # 指定账户名称
  --group=nginx \               # 指定组名称
  --with-http_ssl_module        # 支持加密功能（开启 SSL 加密功能）

  make && make install

  useradd nginx -s /sbin/nologin
  cd /usr/local/nginx/
  ```

- Nginx 配置文件及目录
  - */usr/local/nginx/*  安装目录
  - *conf/nginx.conf*    主配置文件
  - *html*               网页目录
  - *logs*               日志文件
  - *sbin/nginx*         启动脚本

#### Nginx 进程管理

- 启动 Nginx 服务
  - `/usr/local/nginx/sbin/nginx`
- 常用选项
  - `-V` 查看编译参数
  - `-c` 指定配置文件，启动服务
- 查看服务相关进程及端口信息

  ```bash
  ps aux | grep nginx

  netstat -utnalp | grep nginx
  ```

  <div align=center> <img alt="Nginx01" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/Nginx01.gif width=100%/> </div>

  | 命令                                   | 说明             |
  | -------------------------------------- | ---------------- |
  | `usr/local/nginx/sbin/nginx`           | 启动服务         |
  | `usr/local/nginx/sbin/nginx -s stop`   | 关闭服务         |
  | `usr/local/nginx/sbin/nginx -s reload` | 重新加载配置文件 |
  | `usr/local/nginx/sbin/nginx -V`        | 查看软件信息     |

- `ss`
  - 查看系统中启动的端口信息
  - 选项：
    `-a` 显示所有端口的信息
    `-n` 以数字格式显示端口号
    `-t` 显示 TCP 连接的端口号
    `-u` 显示 UDP 连接的端口号
    `-l` 显示服务正在监听的端口信息（如 httpd 启动后，会一直监听 80 端口）
    `-p` 显示监听端口的服务名称是什么

  ```bash
  ss -anptu | grep nginx
  ```

## Nginx 服务器

- [Nginx 配置解析](#nginx-配置解析)
  - 配置文件结构
  - 配置容器
  - 用户认证

### Nginx 配置解析

#### 配置文件结构

```bash
全局配置
http{
    ......
    server{
        ......
        location/{
            ......
        }
    }
}
```

#### 配置容器

```bash
http {
    ......
    server {                    //定义虚拟主机
        listen 80;
        server_name localhost;
        location / {            //发布目录
            root html;
            index index.html index.htm;
        }
    }
}
```

#### 用户认证

- 配置

  ```bash
  location / {
      root html;
      index index.html;

      auth_basic "auth-domain";
      auth_basic_user_file "/usr/local/nginx/pass";
  }
  ```

- 命令
  
  ```bash
  yum -y install httpd-tools
  htpasswd -c /usr/local/nginx/pass admin # 创建认证用户，不加 -c 表示再添加（已有用户）一个用户
  ```

## Nginx 虚拟主机

- [三种模式虚拟主机](#三种模式虚拟主机)
  - 基于域名的虚拟主机
  - 基于端口的虚拟主机
  - 基于 IP 的虚拟主机

### 三种模式虚拟主机

#### 基于域名的虚拟主机

```bash
server {
    listen 80;
    server_name www.a.com;
    ...
}
server {
    listen 80;
    server_name www.b.com;
    ...
}
```

#### 基于端口的虚拟主机

```bash
server {
    listen 8080;
    server_name www.a.com;
    ...
}
server {
    listen 8000;
    server_name www.a.com;
    ...
}
```

#### 基于 IP 的虚拟主机

```bash
server {
    listen 192.168.99.5:80;
    server_name www.a.com;
    ...
}
server {
    listen 192.168.88.5:80;
    server_name www.a.com;
    ...
}
```

## HTTPS 加密网站

- [密钥](#密钥)
  - 对称密钥
  - 非对称密钥
  - Hash 值
- [SSL 虚拟主机](#ssl-虚拟主机)
  - 生成密钥
  - SSL 加密网站

### 密钥

#### 对称密钥

- AES
- DES
- 应用案例：RAR、ZIP 压缩加密（单机加密）

#### 非对称密钥

- RSA
- DSA
- 应用案例：网络加密（https、ssh）

#### Hash 值

- MD5
- SHA256
- SHA512
- 应用案例：数据完整性校验

### SSL 虚拟主机

#### 生成密钥

- SSL 加密网站的核心技术是非对称生成密钥
  - 公钥、私钥、证书
  
  ```bash
  cd /usr/local/nginx/conf/

  openssl genrsa > cert.key 2048 # 生成私钥

  openssl req -new -x509 -key cert.key > cert.pem # 生成证书
  ```

#### SSL 加密网站

- 配置

  ```bash
  server{
      listen 443 ssl;
      server_name www.test.com;
      
      ssl_certificate cert.pem
      ssl_certificate_key cert.key;
      
      ssl_protocols SSLv2 SSLv3 TLSv1;
      ssl_ciphers HIGH:!aNULL:!MD5;
      ssl_prefer_server_ciphers on;
      location/{
          root html;
          index index.html index.htm;
      }
  }
  ```

## 其他

- Linux 使用最小化系统后，需要安装一些常用工具
  - *vim、bash-completion、net-tools*
