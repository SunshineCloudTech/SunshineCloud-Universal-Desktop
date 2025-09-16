# 🖥️ SunshineCloud Universal Desktop

🚀 **构建状态** | 🐳 **Docker 镜像** | 📄 **MIT 许可证** | 🖥️ **XFCE 桌面环境** | 🔊 **音频支持** | 🌐 **远程访问** | 🧰 **多语言开发** | 📦 **DevContainer 就绪**

SunshineCloud Universal Desktop 是一个功能完整的容器化桌面开发环境，基于 Debian Bookworm 构建，集成了 XFCE 桌面环境、多语言开发工具链、数据库服务和远程访问功能。项目旨在为开发者提供一致、可复现、开箱即用的跨平台开发环境。

## ✨ 主要特性

### 🖥️ 桌面环境
- **XFCE 4.18** - 轻量级、高效的桌面环境
- **XRDP 远程桌面** - 支持 Windows RDP 协议访问
- **多语言字体支持** - 包含 Noto、CJK、阿拉伯语、印地语等字体
- **主题美化** - Adwaita 主题和图标支持

### 🎵 音频系统
- **PulseAudio** - 完整的音频子系统
- **XRDP 音频模块** - 远程桌面音频重定向支持
- **音频面板插件** - XFCE 面板集成音频控制

### 🔧 XFCE 面板插件
- **系统托盘** (systray) - 应用程序通知区域
- **音频控制** (pulseaudio) - 音量和设备管理
- **天气显示** (weather) - 实时天气信息
- **CPU 图表** (cpugraph) - 系统资源监控
- **应用菜单** 和 **任务栏** - 标准桌面功能

### 💻 开发环境
- **多语言支持**: Python 3.10+, Node.js LTS, Java 8+, .NET, Go, Ruby, PHP
- **构建工具**: Maven, Gradle, Ant, Yarn, pnpm, Composer
- **版本控制**: Git, Git LFS, GitHub CLI
- **容器化**: Docker-in-Docker, Kubernetes 工具
- **机器学习**: Conda, Micromamba, JupyterLab

### 🗄️ 数据库服务
- **MySQL 8.0** - 关系型数据库 (端口: 3306)
- **Redis 7.0** - 内存数据库 (端口: 6379)
- **Supervisor 管理** - 自动启动和监控数据库服务

### 🌐 网络服务
- **XRDP 服务** - Windows 远程桌面协议 (默认端口: 3389)
- **SSH 服务** - 安全远程访问 (端口: 22)
- **HTTP 代理** - 支持各种 Web 服务 (可配置端口)

## 🚀 快速开始

### 使用 Docker 运行

```bash
# 拉取最新镜像
docker pull sunshinecloud007/sunshinecloud-universal-desktop:latest

# 运行桌面环境
docker run -d \
  --name sunshine-desktop \
  -p 3389:3389 \
  -p 3306:3306 \
  -p 6379:6379 \
  -p 22:22 \
  --privileged \
  -v /path/to/your/code:/SunshineCloud \
  sunshinecloud007/sunshinecloud-universal-desktop:latest
```

### 使用 VS Code DevContainer

1. **安装前置条件**
   - [VS Code](https://code.visualstudio.com/)
   - [Dev Containers 扩展](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
   - [Docker Desktop](https://www.docker.com/products/docker-desktop)

2. **克隆项目**
   ```bash
   git clone https://github.com/SunshineCloudTech/SunshineCloud-Universal-Desktop.git
   cd SunshineCloud-Universal-Desktop
   ```

3. **在 VS Code 中打开**
   - 打开 VS Code
   - 按 `Ctrl+Shift+P` (Windows/Linux) 或 `Cmd+Shift+P` (macOS)
   - 选择 `Dev Containers: Reopen in Container`

### 远程桌面连接

1. **Windows 用户**
   ```
   开始菜单 → 远程桌面连接
   计算机: localhost:3389 (或服务器IP:3389)
   用户名: matrix0523
   密码: 123456789
   ```

2. **macOS/Linux 用户**
   ```bash
   # 使用 rdesktop
   rdesktop -u matrix0523 -p 123456789 localhost:3389
   
   # 或使用 freerdp
   xfreerdp /u:matrix0523 /p:123456789 /v:localhost:3389
   ```

## 📖 技术规格

### 基础镜像
- **操作系统**: Debian 12 (Bookworm)
- **内核**: Linux 容器兼容
- **架构**: AMD64/x86_64

### 网络端口

| 服务 | 端口 | 协议 | 描述 |
|------|------|------|------|
| XRDP | 3389 | TCP | Windows 远程桌面协议 |
| MySQL | 3306 | TCP/UDP | MySQL 数据库服务 |
| Redis | 6379 | TCP/UDP | Redis 缓存数据库 |
| SSH | 22 | TCP | 安全外壳协议 |

### 用户账户

| 用户名 | 密码 | 权限 | 主目录 |
|--------|------|------|--------|
| matrix0523 | 123456789 | sudo | /home/matrix0523 |
| Administrator | 123456789 | sudo | /home/Administrator |

### 存储路径

| 路径 | 用途 |
|------|------|
| `/SunshineCloud` | 主工作目录 |
| `/SunshineCloud/MySQL-Server` | MySQL 安装目录 |
| `/SunshineCloud/SunshineCloud-PulseAudio-Modules` | 音频模块 |
| `/home/matrix0523` | 默认用户主目录 |
| `/var/log` | 系统和服务日志 |

### 环境变量

```bash
# 主要环境变量
XDG_DATA_DIRS="/usr/local/share:/usr/share:/var/lib/flatpak/exports/share"
DISPLAY=":0"
MYSQL_HOME="/etc/mysql"
```

## 🏗️ 构建流程

项目使用 GitHub Actions 实现自动化构建和发布：

### 构建工作流
1. **代码检出** - 获取最新代码
2. **环境准备** - 设置 Docker Buildx、QEMU
3. **磁盘优化** - 清理构建环境以节省空间
4. **镜像构建** - 使用 DevContainer CLI 构建镜像
5. **镜像优化** - 扁平化镜像层以减小体积
6. **推送发布** - 推送到 Docker Hub

### 构建配置
- **触发条件**: `main` 分支推送或手动触发
- **构建环境**: Ubuntu Latest GitHub Runner
- **构建工具**: DevContainer CLI, Docker Buildx
- **优化策略**: 分层构建 → 导出 → 导入 → 重新提交

## 📁 项目结构

```
.
├── .devcontainer/
│   ├── devcontainer.json         # DevContainer 配置
│   ├── Dockerfile                # 主构建文件
│   ├── config/                   # Supervisor 服务配置
│   │   ├── mysql.conf           # MySQL 服务配置
│   │   ├── redis-server.conf    # Redis 服务配置
│   │   └── ...
│   ├── system/                   # 系统配置文件
│   │   ├── bin/                 # 自定义脚本
│   │   └── etc/                 # 配置文件模板
│   ├── features/                # 自定义 DevContainer 特性
│   └── scripts/                 # 构建脚本
├── .github/
│   └── workflows/               # GitHub Actions 工作流
│       ├── Build-Desktop-Image.yml
│       └── Desktop-Image-Release.yml
├── scripts/                     # 项目脚本
└── docs/                        # 文档目录
```

## 🔧 自定义配置

### 修改用户凭据
```bash
# 在容器内修改密码
sudo passwd matrix0523
sudo passwd Administrator
```

### 配置数据库
```bash
# MySQL 配置文件
/etc/mysql/my.cnf

# Redis 配置文件  
/etc/redis/redis.conf
```

### XFCE 面板自定义
面板配置位于: `~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml`

### 添加开发工具
项目支持通过 DevContainer Features 添加额外工具，编辑 `devcontainer.json`：

```json
{
  "features": {
    "ghcr.io/devcontainers/features/terraform:1": "latest",
    "ghcr.io/devcontainers/features/aws-cli:1": "latest"
  }
}
```

## 🐛 故障排除

### 常见问题

1. **无法连接 XRDP**
   ```bash
   # 检查服务状态
   sudo service xrdp status
   
   # 重启服务
   sudo service xrdp restart
   ```

2. **音频无法工作**
   ```bash
   # 重启 PulseAudio
   pulseaudio --kill
   pulseaudio --start
   ```

3. **数据库连接失败**
   ```bash
   # 检查 MySQL 状态
   sudo supervisorctl status mysql
   
   # 检查 Redis 状态
   sudo supervisorctl status redis-server
   ```

### 日志查看
```bash
# 系统日志
sudo journalctl -f

# 服务日志
sudo supervisorctl tail -f mysql
sudo supervisorctl tail -f redis-server

# XRDP 日志
tail -f /var/log/xrdp.log
```

## 🤝 贡献指南

我们欢迎社区贡献！请遵循以下步骤：

1. **Fork 项目** 到您的 GitHub 账户
2. **创建特性分支** (`git checkout -b feature/AmazingFeature`)
3. **提交更改** (`git commit -m 'Add some AmazingFeature'`)
4. **推送分支** (`git push origin feature/AmazingFeature`)
5. **创建 Pull Request**

### 开发环境设置
```bash
# 克隆项目
git clone https://github.com/SunshineCloudTech/SunshineCloud-Universal-Desktop.git

# 在 DevContainer 中开发
code SunshineCloud-Universal-Desktop
# 选择 "Reopen in Container"
```

## 📄 许可证

本项目使用 [MIT 许可证](LICENSE)。您可以自由地使用、修改和分发此软件。

## 🙏 致谢

- **Debian 团队** - 提供稳定的基础操作系统
- **XFCE 社区** - 开发轻量级桌面环境
- **DevContainer 社区** - 推动容器化开发标准
- **所有贡献者** - 感谢每一位贡献代码和想法的开发者

## 📞 支持

- **GitHub Issues**: [报告问题](https://github.com/SunshineCloudTech/SunshineCloud-Universal-Desktop/issues)
- **GitHub Discussions**: [社区讨论](https://github.com/SunshineCloudTech/SunshineCloud-Universal-Desktop/discussions)
- **Docker Hub**: [镜像仓库](https://hub.docker.com/r/sunshinecloud007/sunshinecloud-universal-desktop)

---

<div align="center">

**⭐ 如果这个项目对您有帮助，请给我们一个 Star！**

[🏠 主页](https://github.com/SunshineCloudTech/SunshineCloud-Universal-Desktop) • [📝 文档](README.md) • [🐛 问题](https://github.com/SunshineCloudTech/SunshineCloud-Universal-Desktop/issues)

</div>
