# 企业级网络架构 02

- VLAN 技术及应用
- Trunk
- 链路聚合
- 网络层

## VLAN 技术及应用

- VLAN
  - 广播域
  - VLAN 概述
- VLAN 配置
  - 静态 VLAN 的配置
  - 将接口加入 VLAN
  - 验证 VLAN 的配置

### VLAN

#### 广播域

- 广播域指接收同样广播消息的范围，在该范围中的任何一个设备发送广播，所有其他设备都可以收到。
- 默认情况下交换机的所有接口属于同一个广播域

#### VLAN 概述

- 虚拟局域网（Virtual LAN，VLAN）
- 交换机的所有接口默认属于同一个广播域，随着接入设备的增多，网络中广播增多，降低了网络的效率，而使用 VLAN 可以分割广播域避免该问题。
- VLAN 的作用（优点）
  - **广播控制、增加安全、提高带宽利用、降低数据传递延迟**
- 基于接口划分 VLAN

### VLAN 配置

#### VLAN 的配置

1. 创建 VLAN
2. 将接口加入到相应的 VLAN 中
3. 验证

视图 | 命令 | 简写 | 说明
-- | -- | -- | --
系统视图 | `vlan 2` | `vl 2` | 创建 VLAN
系统视图 | `vlan batch 10 15 20` 或 `vlan batch 10 to 15` || 批量创建 VLAN
系统视图 | `undo vlan 10` 或 `undo vlan batch 10 15` 或 `undo vlan batch 15 to 20` || 删除 VLAN
接口（组）视图/链路聚合接口视图 | `port link-type access` | `port link-t a` | 设置接口类型为接入链路
接口（组）视图/链路聚合接口视图 | `port default vlan 2` | `p d v 2` | 将接口加入 VLAN（需要先将接口类型设置为接入链路）
系统视图 | `port-group 1` | `port-g 1` | 创建（进入）接口组（删除在开头加 `undo`）
接口组视图 | `group-member Ethernet0/0/1 Ethernet0/0/2` 或 `group-member Ethernet0/0/1 to Ethernet0/0/2` || 将某些接口加入到接口组（删除在开头加 `undo`）
任意视图 | `display vlan` | `d vl` | 查看 VLAN 的配置

## Trunk

- Trunk 原理
  - 交换机之间的 VLAN 通信
  - VLAN 标识
- Trunk 配置
  - 配置接口为 Trunk 模式
  - 配置 VLAN Trunk 实例
- 链路聚合
  - 链路聚合功能
  - 配置链路聚合

### Trunk 原理

#### 交换机之间的 VLAN 通信

- 有时，同 VLAN 的设备会接在不同交换机上
- 交换机给每个去往其他交换机的数据帧打上 VLAN 标识

<div align=center> <img alt="VLAN标识1" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/VLAN标识1.png width=100%/> </div>

---

<div align=center> <img alt="VLAN标识2" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/VLAN标识2.png width=100%/> </div>

---

<div align=center> <img alt="VLAN标识3" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/VLAN标识3.png width=100%/> </div>

### Trunk 配置

#### 配置接口为 Trunk 模式

- 进入端口号后修改端口链路类型
  - `port link-type trunk` `port link-t t`
- 为已经修改为 Trunk 模式的端口添加允许的 VLAN
  - `port trunk allow-pass vlan all` `p t a v a`

#### 配置 VLAN Trunk 实例

<div align=center> <img alt="配置 VLAN Trunk 实例" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/配置VLAN%20Trunk实例.png width=100%/> </div>

    [sw1]vlan batch 2 3

    [sw1]port-group 1
    [sw1-port-group-1]group-member Ethernet 0/0/1 to Ethernet 0/0/3
    [sw1-port-group-1]prot link-type access
    [sw1-port-group-1]q

    [sw1]port-group 2
    [sw1-port-group-2]group-member Ethernet 0/0/4 to Ethernet 0/0/10
    [sw1-port-group-2]prot link-type access
    [sw1-port-group-2]port default vlan 2

    [sw1]port-group 3
    [sw1-port-group-3]group-member Ethernet 0/0/11 to Ethernet 0/0/23
    [sw1-port-group-2]prot link-type access
    [sw1-port-group-2]port default vlan 3

    [sw1]interface Ethernet0/0/24
    [sw1-Ethernet0/0/24]port link-type trunk
    [sw1-Ethernet0/0/24]port trunk allow-pass vlan all

### 链路聚合

#### 链路聚合功能

- Eth-trunk
  - 多条线路负载均衡，带宽提高
  - 容错，当一条线路失效时，不会造成全网中断

#### 配置链路聚合

视图 | 命令 | 简写 | 说明
-- | -- | -- | --
系统视图 | `interface Eth-trunk 1` | `int e1` | 创建（进入）链路聚合接口
链路聚合接口视图 | `trunkport ethernet 0/0/1 0/0/2` | `trun e 0/0/1 0/0/2` | 为链路聚合接口捆绑物理接口
系统视图 | `clear configuration interface Ethernet0/0/7` || 恢复物理接口为默认配置（会关闭接口）
接口视图 | `undo shutdown` || 开启接口

- 链路聚合相当于一个接口

## 网络层

- 网络层解析
  - 网络层的功能
  - 网络层协议
- 路由原理及配置
  - 什么是路由
  - 如何获得路由表
  - 静态路由

### 网络层解析

#### 网络层的功能

- 定义了 IP 地址
- 连接不同的媒介类型（不同范围的网络、不同的硬件、不同的系统）
- 选择数据通过网络路径（选路）

#### 网络层协议

- ICMP（Internet Control Message Protocol）互联网控制报文协议
- 通过 IP 数据报传送，用来发送错误和控制信息
- 常见的 ping 反馈结果
  - 连接建立成功，Reply from 目标地址...
  - 目标主机不可达，Destination host unreachable.
  - 请求时间超时，Request timed out.

---

- ARP（Address Resolution Protocol）地址解析协议
- 在网络中发送数据时，需要目标 ip 与目标 mac 地址，但由于发送时只知道目标 ip 地址，不知道其 mac 地址，所以用 ARP 可以根据 IP 地址信息解析出目标 mac 地址。以保证通信的顺利进行

### 路由原理及配置

#### 什么是路由

- 将数据包从一个网络发送到另一个网络
- 路由器可以根据路由表选择路径
  - 每个路由器都维护着一张路由表，这是路由器转发数据包的关键
  - 每条路由表记录指明了：到达某个网段应从哪个接口发送

#### 如何获得路由表

- 直连路由，将接口配置好 ip 并开启后自动产生
- 静态、默认路由
  - 在路由器上手工指定
- 动态路由
  - 根据网络拓扑或流量变化，由路由器通过路由协议自动设置
  - 适合 ISP 服务商、广域网等大型网络

#### 静态路由

- 使用 `ip route-static` 命令
  - 指定到达 IP 目的网络
  - 基本格式：
    - 系统视图：`ip route-static 目标网络ID 子网掩码 下一跳`

#### 路由器相关命令

视图 | 命令 | 简写 | 说明
-- | -- | -- | --
系统视图 | `interface GigabitEthernet 0/0/0` | `int g0/0/0` | 进入接口视图
接口视图 | `ip address 192.168.2.254 24` | `i a 192.168.2.254 24` | 配置端口的网段 ip
接口视图 | `undo ip address` || 删除端口的网段 ip 配置
任意视图 | `display ip interface brief` | `dis ip in b` | 查看端口的网段配置
任意视图| `display ip routing-table` | `dis ip ro` | 查看路由表信息
任意视图| `display ip routing-table \| include /24` | `dis ip ro \| i /24` | 查看路由表信息（管道 查询特定字段）
系统视图 | `ip route-static 192.168.1.0 24 192.168.2.1` || 添加静态路由

#### 案例：配置静态路由

- 按拓扑配置接口 IP 地址并通过静态路由实现全网互通

<div align=center> <img alt="案例：配置静态路由" title="" src=https://kkkkzzzzyy.oss-cn-beijing.aliyuncs.com/云计算/案例：配置静态路由.png width=100%/> </div>
