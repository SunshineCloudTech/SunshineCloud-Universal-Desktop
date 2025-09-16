# 📋 SunshineCloud Universal Desktop - 发行说明

## 🚀 版本信息

### 当前版本: v2025.09-universal

**发布日期**: 2025年9月16日  
**Docker 镜像**: `sunshinecloud007/sunshinecloud-universal-desktop:latest`  
**基础系统**: Debian 12 (Bookworm)  
**架构支持**: AMD64/x86_64  

---

## 🆕 最新更新 (v2025.09-universal)

### ✨ 新增功能

#### 🖥️ 桌面环境增强
- **XFCE 4.18** 完整桌面环境集成
- **XRDP 远程桌面支持** - 支持 Windows RDP 协议
- **多语言字体包** - 全面支持中文、日文、韩文、阿拉伯文等
- **自定义主题** - Adwaita 主题和图标美化

#### 🔧 XFCE 面板插件
- ✅ **系统托盘 (systray)** - 应用程序通知区域
- ✅ **音频控制 (pulseaudio)** - 实时音量和设备管理
- ✅ **天气显示 (weather)** - 支持全球城市天气信息
- ✅ **CPU 图表 (cpugraph)** - 实时系统资源监控

#### 🎵 音频系统
- **PulseAudio 完整支持** - 容器内音频播放
- **XRDP 音频重定向** - 远程桌面音频传输
- **动态音频设备检测** - 自动识别可用音频设备

#### 💻 开发工具集成
- **Python 3.10+** - 数据科学和 Web 开发
- **Node.js LTS** - JavaScript/TypeScript 开发
- **Java 8+** - 企业级应用开发 (Temurin JDK)
- **.NET 8.0** - 跨平台应用开发
- **Go Latest** - 云原生应用开发
- **Ruby Latest** - Web 框架开发
- **PHP Latest** - Web 应用开发

#### 🛠️ 构建工具
- **Maven** - Java 项目管理
- **Gradle** - 现代构建自动化
- **Ant** - 传统 Java 构建工具
- **Yarn/pnpm** - Node.js 包管理
- **Composer** - PHP 依赖管理

#### 🗄️ 数据库服务
- **MySQL 8.0** 
  - 端口: 3306 (TCP/UDP)
  - 用户: root (无密码)
  - 配置路径: `/etc/mysql/my.cnf`
  - 数据目录: `/SunshineCloud/MySQL-Server`
  
- **Redis 7.0**
  - 端口: 6379 (TCP/UDP)
  - 配置路径: `/etc/redis/redis.conf`
  - 持久化: RDB + AOF

#### 🔄 服务管理
- **Supervisor** 进程管理
  - MySQL 自动启动和监控
  - Redis 自动启动和监控
  - 日志统一管理
  - 服务状态监控

### 🔧 技术改进

#### 📦 容器优化
- **分层构建优化** - 减少镜像体积
- **镜像扁平化** - 通过 export/import 优化层数
- **启动脚本改进** - 更可靠的服务启动序列

#### 🌐 网络配置
- **端口标准化** - 明确定义服务端口
- **防火墙兼容** - 优化容器网络配置
- **代理支持** - 支持 HTTP/HTTPS 代理环境

#### 🔐 安全增强
- **用户权限管理** - 标准化 sudo 配置
- **SSH 安全配置** - 优化远程访问安全
- **文件权限** - 正确的用户和组权限设置

### 🐛 问题修复

#### 🔊 音频问题
- ✅ 修复 PulseAudio XRDP 模块加载问题
- ✅ 解决音频设备检测失败
- ✅ 修复远程桌面音频延迟

#### 🗄️ 数据库问题
- ✅ 修复 MySQL CMake 构建错误
- ✅ 解决权限和锁文件问题
- ✅ 优化启动脚本和配置

#### 🖥️ 桌面问题
- ✅ 修复字体渲染问题
- ✅ 解决图标主题缺失
- ✅ 优化面板插件配置

#### 📦 包管理问题
- ✅ 移除不可用的软件包
- ✅ 修复 Flatpak 安装和配置
- ✅ 解决依赖冲突

---

## 📋 系统规格

### 🖥️ 基础环境
```
操作系统: Debian 12 (Bookworm)
桌面环境: XFCE 4.18
远程协议: XRDP (RDP)
音频系统: PulseAudio
```

### 🌐 网络端口
```
3389/tcp  - XRDP 远程桌面
3306/tcp  - MySQL 数据库
6379/tcp  - Redis 缓存
22/tcp    - SSH 远程访问
```

### 👤 用户账户
```
matrix0523:    123456789 (主用户)
Administrator: 123456789 (管理员)
```

### 📂 重要目录
```
/SunshineCloud/                     - 主工作目录
/SunshineCloud/MySQL-Server/        - MySQL 安装目录
/home/matrix0523/                   - 用户主目录
/var/log/                          - 系统日志目录
```

---

## 🚀 部署指南

### Docker 快速部署

```bash
# 基础运行
docker run -d \
  --name sunshine-desktop \
  -p 3389:3389 \
  -p 3306:3306 \
  -p 6379:6379 \
  sunshinecloud007/sunshinecloud-universal-desktop:latest

# 完整功能部署
docker run -d \
  --name sunshine-desktop \
  -p 3389:3389 \
  -p 3306:3306 \
  -p 6379:6379 \
  -p 22:22 \
  --privileged \
  -v /path/to/workspace:/SunshineCloud \
  -v /path/to/data:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=yourpassword \
  sunshinecloud007/sunshinecloud-universal-desktop:latest
```

### Docker Compose 部署

```yaml
version: '3.8'
services:
  sunshine-desktop:
    image: sunshinecloud007/sunshinecloud-universal-desktop:latest
    container_name: sunshine-desktop
    ports:
      - "3389:3389"
      - "3306:3306"
      - "6379:6379"
      - "22:22"
    volumes:
      - ./workspace:/SunshineCloud
      - ./mysql-data:/var/lib/mysql
      - ./redis-data:/var/lib/redis
    environment:
      - DISPLAY=:0
      - MYSQL_ROOT_PASSWORD=secure_password
    privileged: true
    restart: unless-stopped
```

### Kubernetes 部署

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sunshine-desktop
spec:
  replicas: 1
  selector:
    matchLabels:
      app: sunshine-desktop
  template:
    metadata:
      labels:
        app: sunshine-desktop
    spec:
      containers:
      - name: sunshine-desktop
        image: sunshinecloud007/sunshinecloud-universal-desktop:latest
        ports:
        - containerPort: 3389
        - containerPort: 3306
        - containerPort: 6379
        securityContext:
          privileged: true
---
apiVersion: v1
kind: Service
metadata:
  name: sunshine-desktop-service
spec:
  selector:
    app: sunshine-desktop
  ports:
  - name: rdp
    port: 3389
    targetPort: 3389
  - name: mysql
    port: 3306
    targetPort: 3306
  - name: redis
    port: 6379
    targetPort: 6379
  type: LoadBalancer
```

---

## 🔧 配置说明

### 数据库配置

#### MySQL 配置
```bash
# 配置文件位置
/etc/mysql/my.cnf

# 重要配置项
[mysqld]
bind-address = 0.0.0.0
port = 3306
datadir = /SunshineCloud/MySQL-Server/data
socket = /var/run/mysqld/mysqld.sock

# 服务管理
sudo supervisorctl status mysql
sudo supervisorctl restart mysql
```

#### Redis 配置
```bash
# 配置文件位置
/etc/redis/redis.conf

# 重要配置项
bind 0.0.0.0
port 6379
save 900 1
save 300 10
save 60 10000

# 服务管理
sudo supervisorctl status redis-server
sudo supervisorctl restart redis-server
```

### 桌面配置

#### XFCE 面板自定义
```bash
# 面板配置文件
~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml

# 重启面板
xfce4-panel -r

# 面板插件管理
xfce4-panel --preferences
```

#### 主题和字体
```bash
# GTK 配置
~/.config/gtk-3.0/settings.ini

# 字体配置
~/.config/fontconfig/fonts.conf

# 更新字体缓存
fc-cache -fv
```

### 远程访问配置

#### XRDP 配置
```bash
# 主配置文件
/etc/xrdp/xrdp.ini

# 会话配置
/etc/xrdp/sesman.ini

# 服务管理
sudo service xrdp status
sudo service xrdp restart
```

#### SSH 配置
```bash
# SSH 配置文件
/etc/ssh/sshd_config

# 重启 SSH 服务
sudo service ssh restart
```

---

## 🐛 已知问题和解决方案

### 音频问题

#### 问题: 远程桌面无音频
**解决方案**:
```bash
# 重启 PulseAudio
pulseaudio --kill
pulseaudio --start

# 检查 XRDP 音频模块
pactl list modules | grep xrdp

# 手动加载模块
pactl load-module module-xrdp-sink
```

#### 问题: 音频设备未检测
**解决方案**:
```bash
# 检查音频硬件
aplay -l

# 重新配置 PulseAudio
rm -rf ~/.config/pulse
pulseaudio --kill
pulseaudio --start
```

### 数据库问题

#### 问题: MySQL 启动失败
**解决方案**:
```bash
# 检查错误日志
sudo tail -f /var/log/mysql/mysql.err.log

# 修复权限
sudo chown -R mysql:mysql /SunshineCloud/MySQL-Server
sudo chmod 755 /SunshineCloud/MySQL-Server

# 重新初始化
sudo mysql_install_db --user=mysql --datadir=/SunshineCloud/MySQL-Server/data
```

#### 问题: Redis 内存不足
**解决方案**:
```bash
# 检查内存使用
redis-cli info memory

# 配置最大内存
redis-cli config set maxmemory 1gb
redis-cli config set maxmemory-policy allkeys-lru

# 持久化配置
echo "maxmemory 1gb" >> /etc/redis/redis.conf
```

### 远程桌面问题

#### 问题: RDP 连接拒绝
**解决方案**:
```bash
# 检查 XRDP 状态
sudo service xrdp status

# 检查端口监听
netstat -tlnp | grep 3389

# 重启服务
sudo service xrdp restart
sudo service dbus restart
```

#### 问题: 桌面显示异常
**解决方案**:
```bash
# 重置 XFCE 配置
mv ~/.config/xfce4 ~/.config/xfce4.bak
startxfce4

# 修复权限
sudo chown -R matrix0523:matrix0523 /home/matrix0523
```

---

## 📈 性能优化

### 内存优化
```bash
# 调整 swap 使用
echo 'vm.swappiness=10' >> /etc/sysctl.conf

# 优化 MySQL 内存
[mysqld]
innodb_buffer_pool_size = 256M
query_cache_size = 64M
```

### 网络优化
```bash
# 优化 TCP 设置
echo 'net.core.rmem_max = 16777216' >> /etc/sysctl.conf
echo 'net.core.wmem_max = 16777216' >> /etc/sysctl.conf

# 优化 RDP 连接
echo 'tcp_keepalives_idle = 600' >> /etc/xrdp/xrdp.ini
```

### 存储优化
```bash
# 启用 MySQL 压缩
[mysqld]
innodb_compression_level = 6

# Redis 配置优化
save 900 1
stop-writes-on-bgsave-error no
```

---

## 🔄 升级指南

### 从旧版本升级

1. **备份数据**
   ```bash
   # 备份 MySQL 数据
   mysqldump --all-databases > backup.sql
   
   # 备份用户配置
   tar -czf config-backup.tar.gz ~/.config
   ```

2. **拉取新镜像**
   ```bash
   docker pull sunshinecloud007/sunshinecloud-universal-desktop:latest
   ```

3. **停止旧容器**
   ```bash
   docker stop sunshine-desktop
   docker rm sunshine-desktop
   ```

4. **启动新容器**
   ```bash
   docker run -d \
     --name sunshine-desktop \
     -p 3389:3389 \
     -p 3306:3306 \
     -p 6379:6379 \
     -v /path/to/backup:/backup \
     sunshinecloud007/sunshinecloud-universal-desktop:latest
   ```

5. **恢复数据**
   ```bash
   # 恢复 MySQL 数据
   mysql < /backup/backup.sql
   
   # 恢复用户配置
   tar -xzf /backup/config-backup.tar.gz -C ~/
   ```

<div align="center">

## 🎯 项目状态

🏷️ **GitHub 发布版本** | 🐳 **Docker 下载量** | ⭐ **GitHub 星标** | 🍴 **GitHub 分支** | 🐛 **问题跟踪**

**📅 最后更新**: 2025年9月16日  
**🏷️ 版本**: v2025.09-universal  
**📦 镜像大小**: ~4.2GB (压缩后 ~1.8GB)  
**⚡ 构建时间**: ~45分钟  

</div>