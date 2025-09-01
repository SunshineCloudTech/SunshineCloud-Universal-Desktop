#  SunshineCloud-Universal-Desktop

🐳 **容器化开发** | ☕ **Java生态支持** | 🚀 **一键部署** | 🔧 **多工具集成** | 📦 **DevContainer就绪**

 SunshineCloud-Universal-Desktop 是一个为 Java8 开发环境量身定制的 DevContainer 项目，旨在通过容器化技术为开发者提供一致、可复现且易于扩展的开发环境。该项目支持主流 Java 构建工具（Gradle、Maven、Ant）、Groovy 以及 Node.js 生态，适用于需要在不同平台间无缝切换的团队协作和持续集成场景。

## 项目结构

```
.
├── .devcontainer/
│   └── devcontainer.json         # DevContainer 配置文件
├── .github/
│   └── workflows/
│       └── devcontainer-build.yml # GitHub Actions 工作流，自动构建并推送 DevContainer 镜像
├── .idea/                        # JetBrains IDE 配置目录
│   └── .gitignore
├── .gitignore                    # Git 忽略规则
├── LICENSE                       # MIT 开源许可证
└── README.md                     # 项目说明文档
```

## 主要功能

🎯 **一键式 DevContainer 环境**通过 [.devcontainer/devcontainer.json](.devcontainer/devcontainer.json) 配置，自动拉取并初始化包含 Java、Node.js 等开发工具的基础镜像。

🌐 **多语言支持**集成 Java（支持 Gradle、Maven、Ant、Groovy）和 Node.js（支持 Yarn、pnpm、nvm），满足多样化开发需求。

⚙️ **自动化 CI/CD**利用 [.github/workflows/devcontainer-build.yml](.github/workflows/devcontainer-build.yml) 实现 DevContainer 镜像的自动构建、优化与推送，便于团队协作和持续集成。

📁 **灵活的工作区挂载与配置**
  支持本地代码与容器工作目录的高效同步，便于本地与容器间的无缝开发体验。

## 快速开始

1. **克隆本仓库**

   ```sh
   git clone https://github.com/SunshineCloudAI/SunshineCloud-Universal-Desktop.git
   cd SunshineCloud-Universal-Desktop
   ```
2. **使用 VS Code Remote - Containers 打开项目**

   - 安装 [Dev Containers 扩展](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
   - 选择“使用 Dev Container 重新打开项目”
3. **自动安装依赖与工具链**

   - 容器启动后，Java、Node.js 及相关工具会自动安装到最新版本，无需手动配置。

## DevContainer 配置说明

详见 [.devcontainer/devcontainer.json](.devcontainer/devcontainer.json)：

☕ **基础镜像**：`sunshinecloud007/base-bookworm:lite`
🔨 **Java 相关特性**：Gradle、Maven、Ant、Groovy（均为最新版）
🌍 **Node.js 相关特性**：支持 Yarn、pnpm、nvm
📂 **工作区挂载**：本地目录与容器 `/SunshineCloud/SunshineCloud-Universal-Desktop-Git` 绑定

## CI/CD 自动化流程

详见 [.github/workflows/devcontainer-build.yml](.github/workflows/devcontainer-build.yml)：

🏗️ **自动构建** DevContainer 镜像
⚡ **镜像优化与合并**
🚀 **推送至 Docker Hub**（需配置仓库 Secrets）

## 许可证

本项目采用 [MIT License](LICENSE)。

## 贡献指南

欢迎提交 Issue 和 Pull Request 参与贡献！如有建议或问题，请在 GitHub 上反馈。
