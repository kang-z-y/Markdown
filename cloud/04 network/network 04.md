# 企业级网络架构 04

- 高级 ACL
- NAT 工作原理与配置应用
- VRRP 解析与配置

## ACL

- 高级 ACL
  - 高级 ACL 概述
  - 高级 ACL 的配置案例

### 高级 ACL

#### 高级 ACL 概述

- 高级 ACL
  : 基于源 IP 地址、目的 IP 地址、源端口、目的端口、协议过滤数据包
  : 列表号 ==3000~3999==

#### 高级 ACL 的配置命令

- 高级 ACL 可以配置：**允许/拒绝**、**所用协议**、**源地址**、**源地址端口**、**目的地址**、**目的地址端口号**等

        rule (integer<0-4294967294>) [permit|deny] [tcp|udp|ip|ospf] [source[IP_ADDR<X.X.X.X>|any]|source-port [eq|gt|lt|range]|destination|destination-port [eq|gt|lt|range]]

        rule integer<0-4294967294> description TEXT<"...">

#### 案例：高级 ACL 的配置

需求
: 通过配置高级 acl 禁止 pc2 访问 pc1 的 ftp 服务，禁止 pc3 访问 pc1 的 www 服务器，所有主机的其他服务不受限制
  <div align=center> <img alt="案例" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/案例：高级ACL配置.png width=100%/> </div>


## NAT

- NAT 概述
  - NAT 的作用
  - 私有 IP 地址分类
  - NAT 的特性
  - NAT 实现方式
  - NAT 的工作方式
- 静态 NAT
  - 静态 NAT 概述
  - 静态 NAT 的配置案例
- Easy IP
  - Easy IP 的配置案例

### NAT 概述

#### NAT 的作用

- NAT
  : Network Address Translation，网络地址转换
- 作用
  : 通过将内部网络的私有 IP 地址转换成全球惟一的公网 IP 地址，使内部网络可以连接到互联网

#### 私有 IP 地址分类

类别 | 起始 | 终止 | 数量
-- | -- | -- | --
A 类 | 10.0.0.0 | 10.255.255.255 | 约 1677 万个
B 类 | 172.16.0.0 | 172.31.255.255 | 约 104 万个
C 类 | 192.168.0.0 | 192.168.255.255 | 约 64 万个

#### NAT 的特性

- 使用 NAT 带来的好处
  - 节省公有合法 IP 地址
  - 处理地址重叠
  - 提高安全

#### NAT 实现方式

- 静态转换
- Easy IP

#### NAT 的工作过程

静态
: <div align=center> <img alt="静态" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/NAT静态.png width=100%/> </div>

---

Easy IP
: <div align=center> <img alt="" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/NAT%20Easy%20IP.png width=100%/> </div>

### 静态 NAT

#### 静态 NAT 概述

静态转换
: 将内部网络的私有地址转换为公有地址时，IP 地址的对应关系是确定的
: 静态装换是一对一的转换
: 静态转换是双向的

#### 静态 NAT 的配置命令

视图 | 命令 | 简写 | 说明
-- | -- | -- | --
端口视图 | `nat static global 200.1.1.11 inside 10.1.1.11` | `n st g 200.1.1.11 i 10.1.1.11` | 使用静态 nat 技术，将内部的 2.1 与外部的公网地址 100.0.0.2 进行相互转换

#### 案例：配置静态 NAT

需求
: 在 R1 上配置静态 NAT 使 192.168.2.1 转换为 100.0.0.2，192.168.2.2 转换为 100.0.0.3，实现外部网络访问
  <div align=center> <img alt="案例：配置静态NAT" title="案例：配置静态NAT" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/案例：配置静态NAT.png width=100%/> </div>

### Easy IP

#### Easy IP 的配置命令

- Easy IP 允许多个内部地址使用一个公网 ip

视图 | 命令 | 简写 | 说明
-- | -- | -- | --
系统视图 | `acl 2000` || 进入 acl 2000 视图
acl 视图 | `rule 5 permit source 10.1.1.0 0.0.0.255` || 配置 nat
端口视图 | `nat outbound 2000` || 应用 nat（easy ip 方式）

#### 案例：Easy IP 配置

需求
: 使内网利用路由器外网接口的 IP，实现对 100.0.0.1 的访问


## VRRP

- VRRP 概述
  - 单网关的缺陷
  - 多网关存在的问题
  - 什么是 VRRP
  - VRRP 组成员
- VRRP 配置案例
  - VRRP 配置步骤
  - VRRP 配置案例实现

### VRRP 概述

#### 单网关的缺陷

- 单网关场景分析
  - 当网关路由器出现故障时，本网段内以该设备为网关的主机都不能与其他网络进行通信
  <div align=center> <img alt="" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/单网关.png width=100%/> </div>

#### 多网关存在的问题

- 通过部署多网关的方式实现网关的备份
- 存在的问题
  - 网关间 IP 地址冲突
  - 主机会频繁切换网络出口
  <div align=center> <img alt="" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/多网关.png width=100%/> </div>

#### 什么是 VRRP

- VRRP 是虚拟路由冗余协议
- VRRP 能够在不改变组网的情况下，将多台路由器虚拟成一个虚拟路由器，通过配置虚拟路由器的 IP 地址为默认网关，实现网关的备份
  <div align=center> <img alt="" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/VRRP.png width=100%/> </div>

#### VRRP 组成员

- VRRP 组成员角色
  - 主（Master）路由器
  - 备份（Backup）路由器
  - 虚拟（Virtual）路由器

---

- VRRP 原理
  <div align=center> <img alt="" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/VRRP原理.png width=100%/> </div>

### VRRP 配置案例

#### VRRP 配置步骤

1. 配置为 VRRP 的成员
2. 配置 VRRP 的优先级（默认 100，越大优先级越高）
3. 查看 VRRP 信息

#### VRRP 配置命令

视图 | 命令 | 简写 | 说明
-- | -- | -- | --
系统视图 | `interface Vlanif 1` | `i v1` | 进入虚拟端口
端口视图 | `ip address 192.168.1.1 24` || 配置端口 IP
端口视图 | `vrrp vrid 1 virtual-ip 102.168.1.254` || 为端口开启 VRRP 功能
端口视图 | `vrrp vrid 1 priority 200` || 设置 VRRP 优先级
任意视图 | `display vrrp brief` || 查看 vrrp 状态（master、backup）

#### 案例：三层交换机配置 VRRP

需求
: 在三层交换机配置 VRRP 后，使其产生一个虚拟 IP 地址
192.168.1.254 为内网主机的网关
  <div align=center> <img alt="" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/案例：三层交换机配置VRRP.png width=100%/> </div>

