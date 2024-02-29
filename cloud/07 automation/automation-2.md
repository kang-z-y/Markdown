# 自动化运维 02

- 常用模块
- Playbook
- YAML 语言

## 常用模块

- 模块
  - yum_repository 模块
  - yum 模块
  - service 模块
  - lvg 模块
  - lvol 模块
  - filesystem 模块
  - mount 模块

### 模块

#### yum_repository 模块

- 使用 yum_repository 可以茶u嗯间或修改 yum 源配置文件

  ```sh
  # 在 webservers 组中的主机上，配置 yum
  
  ansible webservers -m yum_repository -a "file=myrepo
  name=myApp
  description='My App'
  baseurl=ftp://192.168.88.240/dev/AppStream
  gpgcheck=no
  enabled=yes"

  ansible webservers -m yum_repository -a "file=myrepo name=myBaseOS description='Base OS' baseurl=ftp://192.168.88.240/dev/BaseOS gpgcheck=0 enabled=1"
  ```

#### yum 模块

- 使用 yum 模块可以安装、卸载、升级软件包
  - state: present（安装）|absent（卸载）|latest（升级）

  ```sh
  ansible webservers -m yum -a "name=tar
  state=present"

  ansible webservers -m yum -a "name=wget,net-tools" # 安装可以省略 state=present

  ansible webservers -m yum -a "name=wget state=absent"
  ```

#### service 模块

- service 为服务管理模块（启动、关闭、重启服务等）
  - state: started|stopped|restarted
  - enabled: yes 设置开机启动

  ```sh
  ansible webservers -m yum -a "name=nginx state=latest"

  ansible webservers -m service -a "name=nginx
  state=started
  enabled=yes"
  ```

#### lvg 模块

- lvg 模块：创建、删除卷组（VG），修改卷组大小
  - state: present|absent

  ```sh
  # 在 web1 上创建名为 myvg 的卷组，该卷组由 /dev/vdb1 组成
  ansible web1 -m lvg -a "vg=myvg
  pvs=/dev/vdb1"

  # 扩容卷组。卷组由 PV 构成，只要向卷组中加入新的 PV，即可实现扩容
  ansible web1 -m lvg -a "vg=myvg
  pvs=/dev/vdb1,dev/vdb2"
  ```

#### lvol 模块

- lvol 模块：创建、删除逻辑卷（LV），修改逻辑卷大小
  - state: present|absent

  ```sh
  # 在 web1 上创建名为 mylv 的逻辑卷，大小为 2GB
  ansible web1 -m lvol -a "vg=myvg
  lv=mylv
  size=2G"

  # mylv 扩容至 4GB
  ansible web1 -m lvol -a "vg=myvg lv=mylv size=4G"
  ```

#### filesystem 模块

- 用于格式化，也就是创建文件系统
- fstype：指定文件系统类型，dev：指定要格式化的设备，可以是分区，可以是逻辑卷

  ```sh
  # 在 web1 上，把 /dev/myvg/mglv 格式化为 xfs
  ansible web1 -m filesystem -a "fstype=xfs
  dev=/dev/myvg/mglv"
  ```

#### mount 模块
