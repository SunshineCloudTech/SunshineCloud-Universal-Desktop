# SunshineCloud Universal Desktop - 发行说明

## 版本信息

当前版本: v2025.10
发布日期: 2025年10月25日
Docker 镜像: sunshinecloud007/sunshinecloud-universal-desktop:latest
基础系统: Debian 12 (Bookworm)
架构支持: AMD64/x86_64

## 最新更新 (v2025.10)

### 新增功能

#### AI/ML 桌面环境
- 新增 Stable Diffusion ComfyUI 专门桌面环境
- 新增 Stable Diffusion Fooocus 专门桌面环境
- 新增 AUTOMATIC1111 WebUI 专门桌面环境
- 新增 WebUI Forge 专门桌面环境
- 新增 Text Generation WebUI 专门桌面环境

#### GPU 支持优化
- 完整的 NVIDIA CUDA 支持
- PyTorch GPU 优化安装脚本
- 专门的 GPU 环境变量配置
- Ollama 大语言模型服务集成

#### 构建流程改进
- 多阶段 Docker 镜像构建
- 自动化的镜像压缩优化
- GitHub Actions 持续集成
- 分层构建策略以减小镜像体积

#### 桌面环境
- XFCE 4.18 轻量级桌面环境
- XRDP 远程桌面支持
- 多语言字体和输入法支持
- 音频系统完整支持

#### 开发工具
- Python 3.10+ 开发环境
- Node.js LTS JavaScript/TypeScript 支持
- Java 多版本支持 (8, 11, 17, 21)
- .NET 8.0 跨平台开发
- Go 云原生开发支持
- Ruby Web 框架支持
- PHP Web 应用开发

#### 数据库服务
- MySQL 8.0 关系型数据库
- Redis 内存数据库
- Supervisor 服务管理

### 技术改进

#### 容器优化
- 多阶段构建减少镜像体积
- 自动化镜像压缩流程
- 优化的启动脚本和服务管理
- 改进的依赖管理和包安装

#### 服务管理
- Supervisor 统一服务管理
- 自动启动和监控数据库服务
- Ollama AI 模型服务集成
- 统一的日志管理和查看

#### 安全改进
- 标准化用户权限配置
- 优化的文件和目录权限设置
- 安全的默认配置
- 改进的网络安全配置

### 问题修复

#### 包管理修复
- 修复 uv pip install 缺少 --system 参数问题
- 统一化所有 Dockerfile 的包安装方式
- 修复文件权限错误（特别是包含空格的目录）
- 移除 Microsoft Oryx 相关依赖

#### GPU 支持修复
- 集成专门的 PyTorch GPU 安装脚本
- 添加 GPU 优化环境变量
- 修复 CUDA 相关权限问题
- 优化 AI 模型加载和推理性能

#### 服务配置修复
- 统一所有项目的 Ollama supervisor 配置
- 修复服务启动顺序和依赖关系
- 改进服务监控和自动重启机制
- 优化资源使用和内存管理

## 系统规格

### 基础环境
- 操作系统: Debian 12 (Bookworm)
- 桌面环境: XFCE 4.18
- 远程协议: XRDP (RDP)
- 音频系统: PulseAudio

### 网络端口
- 3389: XRDP 远程桌面
- 3306: MySQL 数据库
- 6379: Redis 缓存
- 22: SSH 远程访问
- 11434: Ollama API 服务

### 用户账户
- matrix0523: 123456789 (主用户)
- Administrator: 123456789 (管理员)
- ollama: (AI 模型服务用户)

### 重要目录
- /app: 主工作目录
- /var/lib/ollama: Ollama 模型存储
- /home/matrix0523: 用户主目录
- /var/log: 系统和服务日志

## 部署指南

### 基础镜像部署

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

```bash
docker run -d \
  --name sunshine-desktop \
  -p 3389:3389 \
  -p 3306:3306 \
  -p 6379:6379 \
  -p 22:22 \
  --privileged \
  -v /path/to/workspace:/app \
  sunshinecloud007/sunshinecloud-universal-desktop:latest
```

### AI 专门桌面环境部署

```bash
# ComfyUI 环境
docker run -d --gpus all \
  --name comfyui-desktop \
  -p 3389:3389 \
  -p 8188:8188 \
  --privileged \
  sunshinecloud007/stable-diffusion-comfyui-desktop:latest

# AUTOMATIC1111 WebUI 环境
docker run -d --gpus all \
  --name webui-desktop \
  -p 3389:3389 \
  -p 7860:7860 \
  --privileged \
  sunshinecloud007/stable-diffusion-webui-desktop:latest

# 文本生成环境
docker run -d --gpus all \
  --name textgen-desktop \
  -p 3389:3389 \
  -p 7860:7860 \
  -p 11434:11434 \
  --privileged \
  sunshinecloud007/text-generation-webui-desktop:latest
```

### Docker Compose 部署示例

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
    volumes:
      - ./workspace:/app
    privileged: true
    restart: unless-stopped
```

## 配置说明

### 服务管理

```bash
# 查看所有服务状态
sudo supervisorctl status

# 管理数据库服务
sudo supervisorctl restart mysql
sudo supervisorctl restart redis-server

# 管理 AI 服务
sudo supervisorctl restart ollama

# 查看服务日志
sudo supervisorctl tail -f mysql
sudo supervisorctl tail -f ollama
```

### AI 模型配置

```bash
# Ollama 模型管理
ollama list                    # 列出已安装模型
ollama pull llama2            # 下载模型
ollama run llama2             # 运行模型

# 模型存储位置
/var/lib/ollama/models/       # 模型文件存储目录
```

### GPU 支持配置

```bash
# 检查 GPU 状态
nvidia-smi

# 检查 CUDA 版本
nvcc --version

# 验证 PyTorch GPU 支持
python -c "import torch; print(torch.cuda.is_available())"
## 已知问题和解决方案

### 远程桌面问题

**问题**: RDP 连接失败
**解决方案**:
```bash
# 检查 XRDP 服务状态
sudo systemctl status xrdp

# 重启 XRDP 服务
sudo systemctl restart xrdp

# 检查端口监听
netstat -tlnp | grep 3389
```

### 服务管理问题

**问题**: 服务无法启动
**解决方案**:
```bash
# 查看所有服务状态
sudo supervisorctl status

# 重启特定服务
sudo supervisorctl restart mysql
sudo supervisorctl restart redis-server
sudo supervisorctl restart ollama

# 查看服务日志
sudo supervisorctl tail -f mysql
```

### GPU 相关问题

**问题**: GPU 不可用或检测失败
**解决方案**:
```bash
# 检查 NVIDIA 驱动
nvidia-smi

# 检查 CUDA 安装
nvcc --version

# 验证 PyTorch GPU 支持
python -c "import torch; print(torch.cuda.is_available())"

# 重新安装 PyTorch GPU 版本
./Torch-Install-GPU.sh
```

### AI 模型服务问题

**问题**: Ollama 服务无法启动
**解决方案**:
```bash
# 检查 Ollama 用户和目录权限
sudo chown -R ollama:ollama /var/lib/ollama
sudo chmod -R 755 /var/lib/ollama

# 手动启动 Ollama 服务
sudo -u ollama /usr/local/bin/ollama serve

# 检查 Ollama 服务状态
sudo supervisorctl status ollama
```

## 性能优化建议

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

### 容器配置优化

```bash
# 为容器分配足够的资源
docker run -d \
  --name sunshine-desktop \
  --memory=8g \
  --cpus=4 \
  --shm-size=2g \
  -p 3389:3389 \
  sunshinecloud007/sunshinecloud-universal-desktop:latest
```

### AI 工作负载优化

```bash
# GPU 加速环境变量
export TORCH_GPU_SKIP_VERIFICATION=true
export FORCE_REINSTALL=true
export CUDA_VERSION=12.1

# 使用 GPU 优化的 PyTorch 安装
./Torch-Install-GPU.sh
```

### 存储优化

```bash
# 使用外部存储卷
-v /path/to/models:/var/lib/ollama/models \
-v /path/to/data:/app/data \
-v /path/to/output:/app/output
```

## 历史版本

### v2025.09 (2025年9月)
- 初始发布版本
- 基础桌面环境和开发工具

### v2025.10 (2025年10月)  
- 新增 AI/ML 专门桌面环境
- GPU 支持和 CUDA 集成
- Ollama 大语言模型服务
- 多阶段构建优化
- 自动化测试和部署流程

## 项目状态

最后更新: 2025年10月25日
当前版本: v2025.10
镜像大小: 基础镜像 ~3.2GB, AI 专门镜像 ~8-12GB
构建时间: 基础镜像 ~30分钟, AI 镜像 ~60-90分钟

## 联系和支持

- GitHub Issues: 问题报告和功能请求
- GitHub Discussions: 社区讨论和交流  
- Docker Hub: 预构建镜像下载