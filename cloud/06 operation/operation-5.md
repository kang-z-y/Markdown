# Linux 高级运维 05

- [Tomcat 服务器](#tomcat-服务器)
- [Tomcat 应用案例](#tomcat-应用案例)
- [maven 应用](#maven)

## Tomcat 服务器

- [概述](#概述)
  - Java 简介
  - JDK 简介
  - Java Servlet
- [安装 Tomcat](#安装-tomcat)
  - 安装部署 JDK
  - 安装部署 Tomcat
  - 测试服务器

### 概述

#### Java 简介

- Java
  - java 是一种跨平台的、面向对象的程序设计语言，Java 技术具有卓越的通用性、高效性、<font color=red>平台移植性</font>和安全性。
- Java 体系
  - Java SE（标准版）
  - Java EE（企业版）

#### JDK 简介

- JDK(*Java Development Kit*)是 *Sun* 针对 Java 开发者推出的<font color=red>Java 语言的软件开发工具包</font>
- JDK 是整个 Java 的核心
  - 包括了 Java 运行环境
  - Java 工具（如编译、排错、打包等工具）
  - Java 基础的类库
- JRE（*Java Runtime Environment*，Java 运行环境）
  - ==JRE 是 JDK 的子集==
- JRE 包括
  - Java 虚拟机（jvm）
  - Java 核心类库和支持文件
  - 不包含开发工具（JDK）-- 编译器、调试器和其他工具

#### Java Servlet

- Servlet 是 java 扩展 Web 服务器功能的组建规范
- 常见 Servlet 容器
  | servlet 容器 | 说明      |
  | ------------ | --------- |
  | IBM          | websphere |
  | Oracle       | weblogic  |
  | Apache       | tomcat    |
  | RedHat       | Jboss     |

### 安装 Tomcat

#### 安装部署 JDK

- 安装 jdk1.8

  ```sh
  yum -y install java-1.8.0-openjdk
  yum -y install java-1.8.0-openjdk-headless

  # 或者
  #yum -y install java
  ```

#### 安装部署 Tomcat

- 安装 Tomcat

  ```sh
  tar -xzf apache-tomcat-8.0.30.tar.gz
  mv apache-tomcat-8.0.30 /usr/local/tomcat
  ```

  - tomcat 目录
    | 目录       | 说明         |
    | ---------- | ------------ |
    | *bin/*     | 主程序目录   |
    | *lib/*     | 库文件目录   |
    | *logs/*    | 日志文件     |
    | *temp/*    | 临时目录     |
    | *work/*    | 自动编译目录 |
    | *conf/*    | 配置文件目录 |
    | *webapps/* | 页面目录     |
  - 启动 Tomcat
    `/usr/local/tomcat/bin/startup.sh`
  - 关闭 Tomcat
    `/usr/local/tomcat/bin/shutdown.sh`

##### 启动 Tomcat 失败

- 可能原因：
  - 端口被占用（8005、8009、8080）
    `ss -ntulp | egrep ':80(05|09|80)'`
  - 版本与系统不兼容
  - 提示：如果检查端口时，8005端口启动非常慢，默认 Tomcat 启动需要从 */dev/random* 读取大量的随机数据，默认该设备生成随机数据的速度很慢，可用使用下面的命令用 urandom 替换 random

    ```sh
    mv /dev/random /dev/random.bak
    ln -s /dev/urandom /dev/random
    killall java

    usr/local/tomcat/bin/startip.sh
 
    ss -ntulp | grep java
    ```

    或者：

    ```sh
    yum install rng-tools
    systemctl enable rngd --now
    ```

#### 测试服务器

- 生成测试页面

  ```jsp
  <html>
    <body>
      <center>
        Now time is:<%=new java.util.Date()%>
      </center>
    </body>
  </html>
  ```

- 客户端测试
  - firefox <http://localhost:8080>
  - firefox <http://localhost:8080/test.jsp>

## Tomcat 应用案例

- [Tomcat 虚拟主机](#tomcat-虚拟主机)
  - 主配置文件解析
  - 基于域名的虚拟主机
  - Tomcat 工作原理
  - SSL 加密站点
  - 日志
- [Tomcat 集群](#tomcat-集群)
  - Nginx 反向代理 tomcat

### Tomcat 虚拟主机

#### 主配置文件解析

- *server.xml* 配置文件框架

  ```xml
  <?xml version='1.0' encoding='utf-8'?>
  <Server port="8005" shutdown="SHUTDOWN">
    <Service name="Catalina">
      <Connector port="8080" protocol="HTTP/1.1"
                 connectionTimeout="20000"
                 redirectPort="8443" />
      <Connector port="8009" protocol="AJP/1.3" redirectPort="8443" />
      <Engine name="Catalina" defaultHost="localhost">
        <Host name="localhost" appBase="webapps"
              unpackWARs="true" autoDeploy="true">
          ...
        </Host>
      </Engine>
    </Service>
  </Server>
  ```

#### 基于域名的虚拟主机

- 配置说明
  - **name** 虚拟主机域名
  - **appBase** 定义基础目录，基础目录下可以有很多项目，默认项目 ROOT
  - **unpackWARs="true"** 自动解压 war 包
  - **autoDeploy="true"** 自动更新开发工程师编写的网站功能
  - **path** 指定用户访问的 URL
  - **docBase** 定义首页路径，默认路径为 ROOT
    - 例：
      */abc* 绝对路径
      *abc* 相对路径，相对于 **appBase**

- 修改 *server.xml* 文档，添加 host 虚拟主机

  ```sh
  vim /usr/local/tomcat/conf/server.xml
  ```

  ```xml
  ...
  <Host name="www.a.com" appBase="a" unpackWARs="true" autoDeploy="true">
  </Host>
  <Host name="www.b.com" appBase="b" unpackWARs="true" autoDeploy="true">
  </Host>
  ...
  ```

  ```sh
  mkdir -p /usr/local/tomcat/{a,b}/ROOT
  echo "A" > /usr/local/tomcat/a/ROOT/index.html
  echo "B" > /usr/local/tomcat/b/ROOT/index.html
  /usr/local/tomcat/bin/shutdown.sh
  /usr/local/tomcat/bin/startup.sh
  ```

- 修改 *server.xml* 文档，给 host 添加 context

  ```xml
  ...
  <Host name="www.a.com" appBase="a" unpackWARs="true" autoDeploy="true">
    <Context path="" docBase="base" reloadable="true" />
  </Host>
  <Host name="www.b.com" appBase="b" unpackWARs="true" autoDeploy="true">
  </Host>
  ...
  ```

  ```sh
  mkdir -p /usr/local/tomcat/a/base
  echo A base > /usr/local/tomcat/a/base/index.html
  usr/local/tomcat/bin/shutdown.sh
  usr/local/tomcat/bin/startup.sh
  ```

- 修改 *server.xml* 文档，给 host 添加 context

  ```xml
  ...
  <Host name="www.a.com" appBase="a" unpackWARs="true" autoDeploy="true">
    <Context path="/test" docBase="base" reloadable="true" />
  </Host>
  <Host name="www.b.com" appBase="b" unpackWARs="true" autoDeploy="true">
  </Host>
  ...
  ```

  - 验证：重启服务，访问：<http://IP:8080/test/>

- 测试：自动解压 war 包

  ```sh
  yum -y install java-1.8.0-openjdk-devel # 安装可以制作 war 包的工具
  jar -cf a.war /var/log # 使用 jar 命令打 war 包
  cp a.war /usr/local/tomcat/webapps
  ls /usr/local/tomcat/webapps/ # 可以看到 a 目录,表示 war 包已自动解开
  ```

#### Tomcat 工作原理

<div align=center> <img alt="Tomcat工作原理" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/Tomcat工作原理.png width=100%/> </div>

#### SSL 加密站点

- 生产私钥证书文件

  ```sh
  keytool -genkeypair -alias tomcat -keyalg RSA -keystore /usr/local/tomcat/keystore
  ```

- 修改 server.xml 配置文件

  ```xml
  <Connector port="8443" protocol="org.apache.coyote.http11.Http11NioProtocol"
             maxThreads="150" SSLEnabled="true" scheme="https" secure="true"
             keystoreFile="/usr/local/tomcat/keystore" keystorePass="123456"         
             clientAuth="false" sslProtocol="TLS" />
  ```

- 重启服务,测试
  `curl -k https://localhost:8443/`
  或 `firefox https://localhost:8443/`

#### 日志

- 虚拟主机创建独立日志文件
  
  ```xml
  <Host ...>
    ...
    <Valve className="org.apache.catalina.valves.AccessLogValve"
           prefix="wwwacom_access_log." suffix=".txt"
           pattern="common" />
           <!-- pattern="%h %l %u %t &quot;%r&quot; %s %b" -->
  </Host>
  
  ```

### Tomcat 集群

#### Nginx 反向代理 tomcat
  
- 修改 nginx 配置

  ```conf
  http {
      upstream toms {
          server 192.168.99.100:8080;
          server 192.168.99.200:8080;
      }
      server {
          listen 80;
          server_name localhost
          location / {
              proxy_pass http://toms;
          }
      }
  }
  ```

## Maven

- [功能介绍](#功能介绍)
  - 基本概念
  - 安装 maven
- [部署网站](#部署网站)
  - 上线网站系统
  - 测试

### 功能介绍

#### 基本概念

- Maven 是一个软件项目管理工具。
- 基于项目对象模型（POM），可以管理项目的构建、报告和文档。
- POM（project Object Model）项目对象模型，它是一个 XML 文件，包含了 Maven 创建项目的基本信息、构建过程、项目依赖等。
- 程序员编写项目时，需要使用各种依赖程序，之后还需要打包、测试之后才能发布到生产环境，这复杂的过程利用 Maven 可以极大的提高开发效率。
- 可以配合 Maven 来提高开发效率的还有工具 SpringBoot
  - 可以创建独立应用，简化 Maven 配置

  <div align=center> <img alt="SpringBoot-Maven" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/SpringBoot-Maven.png width=100%/> </div>

#### 安装 maven

- 释放软件包

  ```sh
  tar -xf apache-maven-3.6.3-bin.tar.gz
  mv apache-maven-3.6.3 /usr/local/maven
  ```

- 安装依赖（*java-1.8.0-openjdk、java-devel*）

  ```sh
  yum -y install java-1.8.0-openjdk java-devel
  ```

- 修改镜像仓库 */usr/local/maven/conf/settings.xml*

  ```xml
  <mirror>
    <id>nexus-aliyun</id>
    <mirrorOf>*</mirrorOf>
    <name>Nexus aliyun</name>
    <url>http://maven.aliyun.com/nexus/content/groups/public</url>
  </mirror>
  ```

### 部署网站

#### 上线网站系统

- 配置数据库

  ```sh
  yum -y install mariadb-server
  systemctl enable mariadb --now
  cd CMS
  cp src/main/resources/shishuocms.properties .
  mysql -uroot < sql/install.sql
  mysqladmin password
  ```

- 打包网站项目

  ```sh
  /usr/local/maven/bin/mvn clean package
  ```

#### 测试

- 开启 tomcat 服务，会自动部署网站

  ```sh
  cp target/shishuocms-2.0.1.war /usr/local/tomcat/webapps/ROOT.war
  /usr/local/tomcat/bin/startup.sh
  ```

- 使用浏览器访问：<http://192.168.99.5:8080>
