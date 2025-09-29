FROM sunshinecloud007/sunshinecloud-universal-desktop:base
ENV MYSQL_PREFIX=/SunshineCloud/MySQL-Server
ENV MYSQL_DATADIR=/SunshineCloud/MySQL-Data
ENV MYSQL_USER=mysql
ENV CARGO_HOME=/usr/local/cargo
ENV RUSTUP_HOME=/usr/local/rustup
USER root
# Install JetBrains Toolbox
RUN echo "Installing JetBrains Toolbox..." && \
    cd /tmp && \
    # Download JetBrains Toolbox for Linux AMD64
    wget -O jetbrains-toolbox.tar.gz "https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.9.0.56191.tar.gz" && \
    # Create extraction directory
    mkdir -vp /usr/local/jetbrains-toolbox && \
    # Extract the archive
    tar -xzf jetbrains-toolbox.tar.gz -C /usr/local/jetbrains-toolbox --strip-components=1 && \
    # Copy the executable to /usr/local/bin for system-wide access
    # cp -R jetbrains-toolbox/* /usr/local/ && \
    ln -s /usr/local/jetbrains-toolbox/bin/jetbrains-toolbox /usr/local/bin/jetbrains-toolbox && \
    # Set executable permissions
    chmod +x /usr/local/jetbrains-toolbox/bin/jetbrains-toolbox && \
    # Create desktop entry for all users
    mkdir -p /usr/share/applications && \
    echo '[Desktop Entry]' > /usr/share/applications/jetbrains-toolbox.desktop && \
    echo 'Version=1.0' >> /usr/share/applications/jetbrains-toolbox.desktop && \
    echo 'Type=Application' >> /usr/share/applications/jetbrains-toolbox.desktop && \
    echo 'Name=JetBrains Toolbox' >> /usr/share/applications/jetbrains-toolbox.desktop && \
    echo 'Icon=/usr/local/jetbrains-toolbox/toolbox-tray-color.png' >> /usr/share/applications/jetbrains-toolbox.desktop && \
    echo 'Exec=jetbrains-toolbox' >> /usr/share/applications/jetbrains-toolbox.desktop && \
    echo 'Comment=JetBrains Toolbox App' >> /usr/share/applications/jetbrains-toolbox.desktop && \
    echo 'Categories=Development;' >> /usr/share/applications/jetbrains-toolbox.desktop && \
    echo 'Terminal=false' >> /usr/share/applications/jetbrains-toolbox.desktop && \
    echo 'StartupWMClass=jetbrains-toolbox' >> /usr/share/applications/jetbrains-toolbox.desktop && \
    echo 'Path=/usr/local/jetbrains-toolbox' >> /usr/share/applications/jetbrains-toolbox.desktop && \
    echo 'StartupNotify=true' >> /usr/share/applications/jetbrains-toolbox.desktop && \
    # Clean up temporary files
    rm -rf /tmp/jetbrains-toolbox* && \
    echo "JetBrains Toolbox installation completed"

# Install Visual Studio Code
RUN echo "Installing Visual Studio Code..." && \
    # Install dependencies
    apt-get update && \
    apt-get install -y wget gpg apt-transport-https && \
    # Add Microsoft GPG key and repository
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/microsoft.gpg && \
    install -D -o root -g root -m 644 /tmp/microsoft.gpg /usr/share/keyrings/microsoft.gpg && \
    rm -f /tmp/microsoft.gpg && \
    # Create VS Code repository configuration
    echo "Types: deb" > /etc/apt/sources.list.d/vscode.sources && \
    echo "URIs: https://packages.microsoft.com/repos/code" >> /etc/apt/sources.list.d/vscode.sources && \
    echo "Suites: stable" >> /etc/apt/sources.list.d/vscode.sources && \
    echo "Components: main" >> /etc/apt/sources.list.d/vscode.sources && \
    echo "Architectures: amd64,arm64,armhf" >> /etc/apt/sources.list.d/vscode.sources && \
    echo "Signed-By: /usr/share/keyrings/microsoft.gpg" >> /etc/apt/sources.list.d/vscode.sources && \
    # Update package cache and install VS Code
    apt-get update && \
    apt-get install -y code && \
    # Clean up
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    echo "Visual Studio Code installation completed"
RUN curl -fsSL https://ollama.com/install.sh | sh
# 设置 MySQL root 用户默认密码
RUN echo "配置 MySQL 默认密码..." && \
    # 临时启动 MySQL 服务器
    ${MYSQL_PREFIX}/bin/mysqld_safe --user=${MYSQL_USER} --datadir=${MYSQL_DATADIR} --socket=/tmp/mysql_temp.sock --pid-file=/tmp/mysql_temp.pid --skip-networking --skip-grant-tables &> /dev/null & \
    MYSQL_PID=$! && \
    # 等待 MySQL 启动
    sleep 10 && \
    # 设置 root 用户密码
    ${MYSQL_PREFIX}/bin/mysql --socket=/tmp/mysql_temp.sock --execute="FLUSH PRIVILEGES; ALTER USER 'root'@'localhost' IDENTIFIED BY '123456789'; CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '123456789'; GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;" && \
    # 停止临时 MySQL 服务器
    kill $MYSQL_PID && \
    wait $MYSQL_PID 2>/dev/null || true && \
    # 清理临时文件
    rm -f /tmp/mysql_temp.sock /tmp/mysql_temp.pid && \
    echo "MySQL 默认密码配置完成，root 密码: 123456789"
# Install Rust toolchain using official rustup installer
RUN echo "Installing Rust toolchain using rustup..." && \
    # Download and run the official rustup installer
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable && \
    # Source the cargo environment to make rust tools available
    # . ${CARGO_HOME}/env && \
    # Verify installation
    rustc --version && \
    cargo --version && \
    # Install additional useful Rust components
    rustup component add rustfmt clippy rust-analysis rust-src && \
    # Install commonly used Rust tools
    cargo install cargo-edit cargo-watch cargo-tree && \
    # Set proper permissions for all users
    chmod -R 755 ${RUSTUP_HOME} ${CARGO_HOME} && \
    echo "Rust toolchain installation completed"

# Install NVIDIA Container Toolkit using official method
RUN echo "Installing NVIDIA Container Toolkit..." && \
    # Configure the production repository
    curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg && \
    curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    tee /etc/apt/sources.list.d/nvidia-container-toolkit.list && \
    # Update the packages list from the repository
    apt-get update && \
    # Install the NVIDIA Container Toolkit packages
    apt-get install -y nvidia-container-toolkit && \
    # Configure the container runtime for Docker
    nvidia-ctk runtime configure --runtime=docker && \
    # systemctl restart docker || true && \
    # Clean up
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    echo "NVIDIA Container Toolkit installation completed"

USER matrix0523
WORKDIR /home/matrix0523
# 暴露 MySQL 和 Redis 端口
EXPOSE 3306 6379 3389
EXPOSE 3306/udp 6379/udp 3389/udp
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["sudo /usr/local/share/docker-init.sh bash -c 'sudo service supervisor start && sudo service dbus restart && sudo service xrdp start && bash'"]