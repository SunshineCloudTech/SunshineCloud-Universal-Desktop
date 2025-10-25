# SunshineCloud Universal Desktop

SunshineCloud Universal Desktop 是一个容器化的多功能开发环境，基于 Debian Bookworm 构建，集成了完整的桌面环境和 AI/ML 工具链。项目提供了一个通用的基础镜像和多个专门用于不同 AI 应用的桌面环境。

## 项目结构

### 基础镜像构建
项目通过多阶段构建流程创建通用基础镜像：

- **Install-Application**: 安装基础应用程序和开发工具
- **Install-Cuda**: 安装 NVIDIA CUDA 支持和 GPU 加速组件
- **.devcontainer**: DevContainer 配置和完整的开发环境

### AI/ML 专门化桌面环境
基于通用基础镜像构建的专门化 AI 桌面环境：

- **Stable-Diffusion-ComfyUI-Desktop**: ComfyUI 图像生成环境
- **Stable-Diffusion-Fooocus-Desktop**: Fooocus 图像生成环境
- **Stable-Diffusion-WebUI-Desktop**: AUTOMATIC1111 WebUI 环境
- **Stable-Diffusion-WebUI-Forge-Desktop**: WebUI Forge 增强版环境
- **Text-Generation-WebUI-Desktop**: 文本生成和大语言模型环境

## 核心功能

### 桌面环境
- XFCE 4.18 轻量级桌面环境
- XRDP 远程桌面支持
- 多语言字体和输入法支持
- 音频系统和媒体播放支持

### 开发工具
- 多语言开发支持 (Python, Node.js, Java, .NET, Go, Ruby, PHP)
- 版本控制工具 (Git, GitHub CLI)
- 容器化工具 (Docker, Kubernetes)
- 机器学习工具 (Conda, Micromamba, JupyterLab)

### 数据库服务
- MySQL 8.0 关系型数据库
- Redis 内存数据库
- Supervisor 服务管理

### AI/ML 支持
- NVIDIA CUDA 和 GPU 加速
- Ollama 大语言模型服务
- PyTorch GPU 优化安装
- 各种 AI 框架和扩展

## 快速开始

### 使用基础镜像

```bash
# 拉取基础镜像
docker pull sunshinecloud007/sunshinecloud-universal-desktop:latest

# 运行基础环境
docker run -d \
  --name sunshine-desktop \
  -p 3389:3389 \
  -p 3306:3306 \
  -p 6379:6379 \
  -p 22:22 \
  --privileged \
  -v /path/to/your/code:/app \
  sunshinecloud007/sunshinecloud-universal-desktop:latest
```

### 使用专门的 AI 桌面环境

```bash
# ComfyUI 环境
docker pull sunshinecloud007/stable-diffusion-comfyui-desktop:latest

# Fooocus 环境
docker pull sunshinecloud007/stable-diffusion-fooocus-desktop:latest

# AUTOMATIC1111 WebUI 环境
docker pull sunshinecloud007/stable-diffusion-webui-desktop:latest

# WebUI Forge 环境
docker pull sunshinecloud007/stable-diffusion-webui-forge-desktop:latest

# 文本生成环境
docker pull sunshinecloud007/text-generation-webui-desktop:latest
```

### DevContainer 开发

1. 安装前置条件：
   - VS Code
   - Dev Containers 扩展
   - Docker Desktop

2. 克隆项目并在容器中打开：
   ```bash
   git clone https://github.com/SunshineCloudTech/SunshineCloud-Universal-Desktop.git
   cd SunshineCloud-Universal-Desktop
   code .
   # 在 VS Code 中选择 "Reopen in Container"
   ```

### 远程桌面访问

使用 RDP 客户端连接到桌面环境：

- 地址: localhost:3389 (或服务器IP:3389)
- 用户名: matrix0523  
- 密码: 123456789
## 技术规格

### 系统要求
- 操作系统: Debian 12 (Bookworm)
- 架构: AMD64/x86_64
- 容器运行时: Docker 或兼容的容器引擎

### 网络端口
- 3389: XRDP 远程桌面服务
- 3306: MySQL 数据库服务  
- 6379: Redis 缓存服务
- 22: SSH 服务

### 默认用户账户
- 用户名: matrix0523 / Administrator
- 密码: 123456789
- 权限: sudo

## 项目结构

```
SunshineCloud-Universal-Desktop/
├── .devcontainer/              # DevContainer 配置
│   ├── Dockerfile             # 主构建文件
│   ├── devcontainer.json      # DevContainer 配置文件
│   ├── config/                # 服务配置文件
│   ├── features/              # 自定义 DevContainer 功能
│   └── system/                # 系统配置文件
├── .github/workflows/          # GitHub Actions 工作流
├── Install-Application/        # 应用程序安装镜像
├── Install-Cuda/              # CUDA 安装镜像
├── scripts/                   # 构建和部署脚本
├── Stable-Diffusion-ComfyUI-Desktop/     # ComfyUI 桌面环境
├── Stable-Diffusion-Fooocus-Desktop/     # Fooocus 桌面环境
├── Stable-Diffusion-WebUI-Desktop/       # AUTOMATIC1111 桌面环境
├── Stable-Diffusion-WebUI-Forge-Desktop/ # WebUI Forge 桌面环境
└── Text-Generation-WebUI-Desktop/        # 文本生成桌面环境
```

## AI 环境配置

每个 AI 桌面环境都预配置了相应的工具和依赖：

### ComfyUI 环境
- ComfyUI 图形化界面
- 常用的自定义节点和扩展
- GPU 加速支持

### Fooocus 环境  
- Fooocus 简化界面
- 预训练模型和配置
- 自动化工作流支持

### AUTOMATIC1111 WebUI 环境
- Stable Diffusion WebUI
- 扩展插件生态系统
- 模型管理和训练支持

### WebUI Forge 环境
- WebUI Forge 增强版本
- 优化的性能和内存使用
- 高级功能和扩展

### 文本生成环境
- Text Generation WebUI
- 大语言模型支持
- API 接口和集成工具

## 构建和部署

项目使用 GitHub Actions 进行自动化构建：

1. Build Image Step 1 - 基础应用程序安装
2. Compress Step 1 Image - 镜像压缩优化
3. Build Image Step 2 - 额外组件安装
4. Compress Step 2 Image - 第二次压缩优化
5. Build Image Step 3 - CUDA 和 GPU 支持
6. Compress Step 3 Image - 最终镜像优化

## 配置和定制
```bash
# 在容器内修改密码
sudo passwd matrix0523
sudo passwd Administrator
```

### 配置数据库
```bash
# MySQL 配置文件
/etc/mysql/my.cnf

### 自定义配置

容器启动后可以修改以下配置：

```bash
# 数据库配置
/etc/mysql/mysql.conf.d/mysqld.cnf    # MySQL 配置
/etc/redis/redis.conf                 # Redis 配置

# 桌面环境配置  
~/.config/xfce4/                      # XFCE 用户配置
/etc/xrdp/xrdp.ini                    # XRDP 配置

# 服务管理
/etc/supervisor/conf.d/               # Supervisor 服务配置
```

### DevContainer 功能扩展

编辑 `.devcontainer/devcontainer.json` 添加额外功能：

```json
{
  "features": {
    "ghcr.io/devcontainers/features/terraform:1": "latest",
    "ghcr.io/devcontainers/features/aws-cli:1": "latest"
  }
}
```

## 故障排除

### 服务管理

```bash
# 查看所有服务状态
sudo supervisorctl status

# 重启特定服务
sudo supervisorctl restart mysql
sudo supervisorctl restart redis-server
sudo supervisorctl restart ollama

# 查看服务日志
sudo supervisorctl tail -f mysql
sudo supervisorctl tail -f redis-server
```

### 远程桌面问题

```bash
# 检查 XRDP 服务
sudo systemctl status xrdp

# 重启 XRDP 服务
sudo systemctl restart xrdp

# 查看 XRDP 日志
tail -f /var/log/xrdp.log
```

### GPU 相关问题

```bash
# 检查 NVIDIA 驱动
nvidia-smi

# 检查 CUDA 安装
nvcc --version

# 检查 PyTorch GPU 支持
python -c "import torch; print(torch.cuda.is_available())"
```

## 许可证

本项目基于 MIT 许可证开源。详见 [LICENSE](LICENSE) 文件。

## 贡献

欢迎贡献代码和提出建议：

1. Fork 本仓库
2. 创建功能分支
3. 提交更改
4. 创建 Pull Request

## 支持

- GitHub Issues: 报告问题和请求功能
- GitHub Discussions: 社区交流和讨论
- Docker Hub: 下载预构建镜像
