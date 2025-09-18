FROM sunshinecloud007/sunshinecloud-universal-desktop:base
# Install JetBrains Toolbox
RUN echo "Installing JetBrains Toolbox..." && \
    cd /tmp && \
    # Download JetBrains Toolbox for Linux AMD64
    wget -O jetbrains-toolbox.tar.gz "https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.9.0.56191.tar.gz" && \
    # Create extraction directory
    mkdir -p jetbrains-toolbox && \
    # Extract the archive
    tar -xzf jetbrains-toolbox.tar.gz -C jetbrains-toolbox --strip-components=1 && \
    # Copy the executable to /usr/local/bin for system-wide access
    cp -R jetbrains-toolbox/* /usr/local/ && \
    # Set executable permissions
    chmod +x /usr/local/bin/jetbrains-toolbox && \
    # Create desktop entry for all users
    mkdir -p /usr/share/applications && \
    echo '[Desktop Entry]' > /usr/share/applications/jetbrains-toolbox.desktop && \
    echo 'Version=1.0' >> /usr/share/applications/jetbrains-toolbox.desktop && \
    echo 'Type=Application' >> /usr/share/applications/jetbrains-toolbox.desktop && \
    echo 'Name=JetBrains Toolbox' >> /usr/share/applications/jetbrains-toolbox.desktop && \
    echo 'Icon=jetbrains-toolbox' >> /usr/share/applications/jetbrains-toolbox.desktop && \
    echo 'Exec=jetbrains-toolbox' >> /usr/share/applications/jetbrains-toolbox.desktop && \
    echo 'Comment=JetBrains Toolbox App' >> /usr/share/applications/jetbrains-toolbox.desktop && \
    echo 'Categories=Development;' >> /usr/share/applications/jetbrains-toolbox.desktop && \
    echo 'Terminal=false' >> /usr/share/applications/jetbrains-toolbox.desktop && \
    echo 'StartupWMClass=jetbrains-toolbox' >> /usr/share/applications/jetbrains-toolbox.desktop && \
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
    # apt-get install -y code && \
    # Clean up
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    echo "Visual Studio Code installation completed"

ENTRYPOINT ["/bin/bash", "-c"]
CMD ["sudo /usr/local/share/docker-init.sh bash -c 'sudo service supervisor start && sudo service dbus restart && sudo service xrdp start && bash'"]