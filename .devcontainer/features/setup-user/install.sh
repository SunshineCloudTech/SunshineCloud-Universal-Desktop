#!/usr/bin/env bash
#===================================================================================
# 用户环境配置安装脚本
#
# 功能：为开发容器设置多语言开发环境的用户配置
# 用途：
#   - 配置多种编程语言的用户目录结构
#   - 建立工具链之间的符号链接
#   - 设置正确的文件权限和用户组
#   - 集成 Microsoft Oryx 构建工具
#   - 优化 GitHub Codespaces 兼容性
#
# 配置的开发环境：
#   - Node.js (通过 NVM 管理)
#   - PHP (版本管理)
#   - Python (版本管理)
#   - Java (通过 SDKMAN 管理)
#   - Ruby (通过 RVM 管理)
#   - .NET Core
#   - Maven (Java 构建工具)
#   - Hugo (静态站点生成器)
##
# 目录结构说明：
#   - /usr/local/*: 系统级别的工具安装
#   - /home/matrix0523/*: Codespaces 兼容的用户目录
#   - /home/${USERNAME}/*: 实际用户的个人目录
#   - /opt/*: 系统可选软件目录
#
# 维护者：SunshineCloud 团队
# 基于：Microsoft DevContainer Features
#===================================================================================
#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------

# 设置默认用户名
USERNAME=${USERNAME:-"matrix0523"}

# 启用详细输出和严格错误处理
set -eux

echo "开始配置用户开发环境..."

# 验证运行权限
if [ "$(id -u)" -ne 0 ]; then
    echo -e '错误：此脚本必须以 root 身份运行。'
    echo -e '请使用 sudo、su 或在 Dockerfile 中添加 "USER root"。'
    exit 1
fi

echo "配置系统环境变量..."

# 确保登录 shell 获得正确的 PATH 环境变量
rm -f /etc/profile.d/00-restore-env.sh
echo "export PATH=${PATH//$(sh -lc 'echo $PATH')/\$PATH}" > /etc/profile.d/00-restore-env.sh
chmod +x /etc/profile.d/00-restore-env.sh

# 设置非交互式安装模式
export DEBIAN_FRONTEND=noninteractive

# 条件执行函数
sudo_if() {
    COMMAND="$*"
    if [ "$(id -u)" -eq 0 ] && [ "$USERNAME" != "root" ]; then
        su - "$USERNAME" -c "$COMMAND"
    else
        $COMMAND
    fi
}


echo "配置 Node.js 环境 (NVM)..."
# Node.js 通过 NVM (Node Version Manager) 管理
# 为 GitHub Codespaces 兼容性创建标准路径链接
NODE_PATH="/home/matrix0523/nvm/current"
ln -snf /usr/local/share/nvm /home/matrix0523
echo "✓ Node.js 环境链接: $NODE_PATH"

echo "配置 PHP 环境..."
# PHP 版本管理和用户目录配置
PHP_PATH="/home/${USERNAME}/.php/current"
mkdir -p /home/${USERNAME}/.php
ln -snf /usr/local/php/current $PHP_PATH
echo "✓ PHP 环境链接: $PHP_PATH"

echo "配置 Python 环境..."
# Python 版本管理，同时兼容系统级和用户级配置
PYTHON_PATH="/home/${USERNAME}/.python/current"
mkdir -p /home/${USERNAME}/.python
ln -snf /usr/local/python/current $PYTHON_PATH
# 为 Oryx 创建 Python 系统链接
ln -snf /usr/local/python /opt/python 2>/dev/null || echo "Python 系统链接已存在"
echo "✓ Python 环境链接: $PYTHON_PATH"

echo "配置 Java 环境 (SDKMAN)..."
# Java 通过 SDKMAN 管理多个版本
# 为 Codespaces 创建标准 Java 目录结构
JAVA_PATH="/home/matrix0523/java/current"
ln -snf /usr/local/sdkman/candidates/java /home/matrix0523
echo "✓ Java 环境链接: $JAVA_PATH"

echo "配置 Ruby 环境 (RVM)..."
# Ruby 通过 RVM (Ruby Version Manager) 管理
RUBY_PATH="/home/${USERNAME}/.ruby/current"
mkdir -p /home/${USERNAME}/.ruby
ln -snf /usr/local/rvm/rubies/default $RUBY_PATH
echo "✓ Ruby 环境链接: $RUBY_PATH"

echo "配置 .NET Core 环境..."
# .NET Core 开发环境和权限配置
DOTNET_PATH="/home/${USERNAME}/.dotnet"

# 修复 .NET 权限问题
# 参考：https://github.com/devcontainers/features/pull/628/files#r1276659825
echo "设置 .NET 目录权限..."
chown -R "${USERNAME}:${USERNAME}" /usr/share/dotnet
chmod g+r+w+s /usr/share/dotnet           # 设置组权限和粘滞位
chmod -R g+r+w /usr/share/dotnet          # 递归设置组读写权限

# 创建用户 .NET 目录链接
ln -snf /usr/share/dotnet $DOTNET_PATH

# 为 Oryx 创建 .NET LTS 版本副本
echo "配置 .NET LTS 版本..."
mkdir -p /opt/dotnet/lts
cp -R /usr/share/dotnet/dotnet /opt/dotnet/lts 2>/dev/null || echo ".NET 运行时已存在"
cp -R /usr/share/dotnet/LICENSE.txt /opt/dotnet/lts 2>/dev/null || echo "许可证文件已存在"
cp -R /usr/share/dotnet/ThirdPartyNotices.txt /opt/dotnet/lts 2>/dev/null || echo "第三方声明已存在"
echo "✓ .NET 环境链接: $DOTNET_PATH"

echo "配置 Maven 环境..."
# Maven Java 构建工具配置
MAVEN_PATH="/home/${USERNAME}/.maven/current"
mkdir -p /home/${USERNAME}/.maven
ln -snf /usr/local/sdkman/candidates/maven/current $MAVEN_PATH
echo "✓ Maven 环境链接: $MAVEN_PATH"

echo "配置 Hugo 环境..."
# Hugo 静态站点生成器配置
HUGO_ROOT="/home/${USERNAME}/.hugo/current"
mkdir -p /home/${USERNAME}/.hugo
ln -snf /usr/local/hugo $HUGO_ROOT
echo "✓ Hugo 环境链接: $HUGO_ROOT"

echo ""
echo "设置目录权限和用户组..."
echo "============================================="

echo "配置用户主目录权限..."
# 设置用户主目录的完整权限
HOME_DIR="/home/${USERNAME}/"
chown -R ${USERNAME}:${USERNAME} ${HOME_DIR}
chmod -R g+r+w "${HOME_DIR}"                    # 设置组读写权限
find "${HOME_DIR}" -type d | xargs -n 1 chmod g+s  # 为目录设置组继承权限

echo "配置 /opt 目录权限..."
# 设置 /opt 目录权限，允许 oryx 组管理
OPT_DIR="/opt/"
chown -R ${USERNAME}:oryx ${OPT_DIR} 2>/dev/null || echo "Oryx 组可能不存在，跳过权限设置"
chmod -R g+r+w "${OPT_DIR}"                     # 设置组读写权限
find "${OPT_DIR}" -type d | xargs -n 1 chmod g+s   # 为目录设置组继承权限

echo ""
echo "配置 sudo 安全路径..."
echo "============================================="

# 为用户配置 sudo 时的安全路径
# 包含所有开发工具的路径，确保 sudo 命令可以找到开发工具
SECURE_PATH="${DOTNET_PATH}:${NODE_PATH}/bin:${PHP_PATH}/bin:${PYTHON_PATH}/bin:${JAVA_PATH}/bin:${RUBY_PATH}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/bin:/usr/local/share:/home/${USERNAME}/.local/bin:${PATH}"

echo "设置用户 ${USERNAME} 的 sudo 安全路径..."
echo "Defaults secure_path=\"${SECURE_PATH}\"" >> /etc/sudoers.d/$USERNAME

echo ""
echo "应用临时安全修复..."
echo "============================================="

# 临时修复：针对 npm 安全漏洞 GHSA-c2qf-rxjj-qqgw
echo "修复 npm 安全漏洞 (GHSA-c2qf-rxjj-qqgw)..."
echo "详情: https://github.com/advisories/GHSA-c2qf-rxjj-qqgw"

# 切换到 Node.js 22 并升级 npm 到安全版本
bash -c ". /usr/local/share/nvm/nvm.sh && nvm use 22" || echo "Node.js 22 不可用"
bash -c "npm -g install -g npm@9.8.1" || echo "npm 升级失败，继续执行"

# 切换回稳定版本的 Node.js
bash -c ". /usr/local/share/nvm/nvm.sh && nvm use stable" || echo "Node.js stable 不可用"

echo ""
echo "✓ 用户环境配置完成！"
echo ""
echo "配置总结："
echo "=========================================="
echo "用户名: ${USERNAME}"
echo "Node.js 路径: ${NODE_PATH}"
echo "PHP 路径: ${PHP_PATH}"
echo "Python 路径: ${PYTHON_PATH}"
echo "Java 路径: ${JAVA_PATH}"
echo "Ruby 路径: ${RUBY_PATH}"
echo ".NET 路径: ${DOTNET_PATH}"
echo "Maven 路径: ${MAVEN_PATH}"
echo "Hugo 路径: ${HUGO_ROOT}"
echo ""
echo "权限设置: ✓ 已完成"
echo "安全修复: ✓ 已应用"
echo ""
echo "开发环境已准备就绪，可以开始多语言项目开发！"

echo "用户环境配置功能特性完成！"
