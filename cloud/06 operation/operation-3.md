# Linux 高级运维 03

- [Nginx 调度器](#nginx-调度器)
- [Nginx 优化](#nginx-优化)

## Nginx 调度器

- [HTTP 调度](#http-调度)
  - Nginx 反向代理架构
  - Nginx 反向代理语法格式
  - Nginx 调度算法
  - 服务器组主机状态
  - 案例应用
- [TCP/UDP 调度](#tcpudp-调度)
  - 模块
  - 语法格式
  - 案例应用

### HTTP 调度

#### Nginx 反向代理架构

- 实验拓扑

  <div align=center> <img alt="Nginx反向代理架构" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/Nginx反向代理架构.png width=100%/> </div>

#### Nginx 反向代理语法格式

```bash
http {
    upstream sergrp {
        server 192.168.99.100:80; # 定义源服务器组
        server 192.168.99.200:80;
    }
    server {
        listen 80;
        server_name locahost # Web 主机名
        location / {
            ...
            proxy_pass http://sergrp; # 调用服务组
        }
    }
}
```

#### Nginx 调度算法

- nginx 目前支持的调度算法
  - **轮询（默认的）**：逐一循环调度
  - **weight**：指定轮询几率，权重值和访问比率成正比（默认为 1）
  - **ip_hash**：根据客户端 IP 分配固定的后端服务器[^1]

[^1]:一般用于小网站，可能导致业务压力不均衡

#### 服务器组主机状态

- 状态类型
  - **down**：表示当前 server 暂时不参与负载
  - **max_fails**：允许请求失败的次数（默认为 1）[^2]
  - **fail_timeout**：max_fails 次失败后，暂停提供服务的时间（默认为 10s）

[^2]:默认开启健康检查

#### Web 案例应用

```bash
upstream sergrp {
    #ip_hash;
    #server 192.168.99.100:80 weight=2;
    #server 192.168.99.200:80 down;
    server 192.168.99.100:80;
    #server 192.168.99.200:80 max_fails=2 fail_timeout=30; # 30 秒
}
```

<div align=center> <img alt="web应用案例" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/web应用案例.png width=100%/> </div>

### TCP/UDP 调度

#### 模块

- *ngx_stream_core_module* 模块
- 使用 <font color=red>--with-stream</font> 开启该模块
- 注意：
  - nginx 从 <font color=red>1.9 版本</font> 才开始支持该功能

#### 语法格式

```bash
stream {
    upstream backend {
        server backend1.example.com:12345 weight=5;
        server 127.0.0.1:22 max_fails=3 fails_timeout=30s;
    }
    server {
        listen 12345;
        proxy_pass backend;
    }
}

http {
    ... ...
}
```

#### SSH 案例应用

- 使用 Nginx 调度后端 SSH 服务
  
  <div align=center> <img alt="SSH应用案例" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/SSH应用案例.png width=100%/> </div>

  <div align=center> <img alt="SSH案例应用" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/SSH案例应用.png width=100%/> </div>

## Nginx 优化

- [HTTP 错误代码](#http-错误代码)
  - HTTP 常见错误代码列表
  - Nginx 如何返回错误页面
- [Nginx 状态页面](#nginx-状态页面)
  - status 模块
  - status 页面
  - 状态信息
- [配置优化](#配置优化)
  - 常用压力测试工具
  - 全局配置优化
  - EVENT 模块优化
  - HTTP 模块优化

### HTTP 错误代码

#### HTTP 常见错误代码列表

| 返回码 | 描述                                                                                              |
| ------ | ------------------------------------------------------------------------------------------------- |
| 200    | 一切正常                                                                                          |
| 400    | 请求语法错误                                                                                      |
| 401    | 访问被拒绝（账户或密码错误）                                                                      |
| 403    | 资源不可用，通常由于服务器上文件或目录的权限设置导致                                              |
| 403    | 禁止访问：客户端的 IP 地址被拒绝                                                                  |
| 404    | 无法找到指定位置的资源（Not Found）                                                               |
| 414    | 请求 URI 头部太长                                                                                 |
| 500    | 服务器内部错误                                                                                    |
| 502    | 服务器作为网关或者代理时，为了完成请求访问下一个服务器，但该服务器返回了非法的应答（Bad Gateway） |
| 503    | 服务器暂时无法完成请求                                                                            |

#### Nginx 如何返回错误页面

- 遇到访问错误时，处理错误代码还有别的选择
  
  ```bash
  http {
      fastcgi_intercept_errors on; # 错误页面重定向
      server {
          error_page 404 /40x.html; # 自定义错误页面

          error_page 500 502 503 504 /50x.html;
          location = /50x.html {
              root html;
          }
      }
  }
  ```

### Nginx 状态页面

#### status 模块

- status
  - <font color=red>--with-http_stub_status_module</font> 开启模块功能
  - 可以查看 Nginx 连接数等信息

  ```bash
  ./configure --with-http_stub_status_module ...
  # 注意：这里省略了其他选项...

  make
  
  cp objs/nginx /usr/local/nginx/sbin/nginx # 已经安装的可以只覆盖 nginx 可执行文件，来更新安装配置

  /usr/local/nginx/sbin/nginx -V
  ```

#### status 页面

- 修改配置文件 nginx.conf
  
  ```bash
  ... ...
  location /status {
      stub_status on;
  }
  ```

- 浏览器访问状态页面
  
  ```bash
  curl http://192.168.88.5/status
  ```

#### 状态信息

- *Active connections*
  - 当前活动的连接数量
- *Accepts*
  - 已经接受客户端的连接总数量
- *Handled*
  - 已经处理客户端的连接总数量（一般与 *accepts* 一致，除非服务器限制了连接数量）
- *Requests*
  - 客户端发送的请求数量
- *Reading*
  - 当前服务器正在读取客户端请求头的数量
- *Writing*
  - 当前服务器正在写响应信息的数量
- *Waiting*
  - 当前多少客户端在等待服务器的响应

### 配置优化

#### 常用压力测试工具

- `ab`
  - `ab -c 并发数 -n 总请求数 URL`
- 其他常见压力测试软件（需要额外下载）
  - *http_load、webbench、siege*

#### 全局配置优化

- 调整进程数量
  
  ```bash
  worker_processes 2; # 与 CPU 核心数量一致
  ```

#### EVENT 模块优化

- 网站常见指标：并发、PV（Page Views）、UV（Unique Visitors）
- $max\_clients = worker\_processes * worker\_connections$
- 注意修改系统 ulimit 限制 */etc/security/limits.conf*

  ```bash
  ulimit -n # 查看最大文件数量
  ulimit -n 10000 # 临时设置最大文件数量

  vim /etc/security/limits.conf
  ```

  - *limits.conf* 配置

    ```bash
    ...
    *   soft    nofile    10000
    *   hard    nofile    10000

    # 该配置文件分 4 列，分别如下：
    # 用户或组  硬限制或软限制  需要限制的项目 限制的值
    # 软限制：警告值
    # 硬限制：最大值
    ```

- Nginx 配置

  ```bash
  events {
      worker_connections 10000; # 每个 worker 最大并发连接数
  }
  ```

#### HTTP 模块优化

- 客户端浏览器缓存数据
  
  ```bash
  location ~* \.(jpg|jpeg|gif|png|css|js|ico|xml)$ {
      expires 30d;
  }
  ```

- 使用 Firefox 浏览器查看缓存
  - 在 Firefox 地址栏内输入 **about:cache** 将显示 Firefox 浏览器的缓存信息，点击List Cache Entries可以查看详细信息。
  - **可以在历史记录中清空 Firefox 本地缓存**

- 解决客户端访问头部信息过长的问题

  ```bash
  http {
      client_header_buffer_size 200k;
      # 默认请求包头信息的缓存
      large_client_header_buffers 4 200k;
      # 大请求包头部信息的缓存个数与容量
      ...
  }
  ```

  - 可以使用以下脚本命令进行测试

    ```sh
    #!/bin/bash
    URL=http://192.168.88.1/index.html?
    for i in {1..5000}
    do
        URL=${URL}v$i=$i
    done
    curl $URL
    ```
