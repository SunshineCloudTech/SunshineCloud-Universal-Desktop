# [Choice] Debian version (use bullseye on local arm64/Apple Silicon): bookworm, bullseye, buster
ARG VARIANT="bookworm"
ARG CUSTOM_PACKAGE_LIST="openssl"
FROM buildpack-deps:${VARIANT}-curl

# Set environment variables early
ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true
ENV MAMBA_ROOT_PREFIX="/opt/micromamba"
ENV PATH="/SunshineCloud/Homebrew/bin:${PATH}"
ENV HOMEBREW_PREFIX=/SunshineCloud/Homebrew
ENV HOMEBREW_CACHE=/SunshineCloud/Homebrew/cache

# Install all packages in a single layer to reduce image size
RUN apt-get update && apt-get -y install --no-install-recommends ${CUSTOM_PACKAGE_LIST} && \
    # Install Distrobox dependencies and extra packages
    apt-get install -y --no-install-recommends \
        apt-utils bash-completion bc bzip2 curl dialog diffutils findutils \
        gnupg gnupg2 gpgsm hostname iproute2 iputils-ping keyutils less \
        libcap2-bin libkrb5-3 libnss-mdns libnss-myhostname libvte-2.9*-common \
        libvte-common locales lsof man-db manpages mtr ncurses-base \
        openssh-client passwd pigz pinentry-curses procps rsync sudo \
        tcpdump time traceroute tree tzdata unzip util-linux wget xauth \
        xz-utils zip libgl1 libegl-mesa0 libegl1-mesa libgl1-mesa-glx \
        libegl1 libglx-mesa0 libvulkan1 mesa-vulkan-drivers \
        # Extra dependencies
        git git-lfs gcc-multilib g++-multilib gcc-x86-64-linux-gnu \
        g++-x86-64-linux-gnu progress debootstrap dbus-daemon sysvinit-utils \
        software-properties-common lsb-release ca-certificates locales-all \
        build-essential fonts-noto fonts-wqy-zenhei nano tasksel xrdp \
        bash-completion libgl1 libglib2.0-0 ffmpeg \
        # Additional packages for later use
        wget apt-transport-https jq supervisor pkgconf file \
        # Desktop environment packages
        ca-certificates crudini dbus dbus-x11 fcitx5 fcitx5-chinese-addons \
        fcitx5-pinyin firefox* fonts-arphic-ukai fonts-arphic-uming \
        fonts-noto-cjk fonts-noto-cjk-extra fonts-wqy-microhei fonts-wqy-zenhei \
        libasound2-dev libatk1.0-0 libcairo-gobject2 libgconf-2-4 \
        libgdk-pixbuf2.0-0 libglib2.0-dev libglib2.0-0 libgtk-3-0 libgtk-3-dev \
        libnss3-dev libpangocairo-1.0-0 libselinux1-dev libxrandr2 libxss1 \
        libxtst6 openssh-server pulseaudio sassc tigervnc-standalone-server \
        tigervnc-viewer tigervnc-xorg-extension uuid-runtime vim vlc \
        xautolock xfce4* \
        # Audio packages
        pavucontrol ucspi-tcp gstreamer1.0-plugins-good gstreamer1.0-pulseaudio \
        gstreamer1.0-tools python3-pip && \
    # Clean up in the same layer
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create users and configure sudo
RUN useradd -m "Administrator" -s /bin/bash && \
    echo "Administrator:123456789" | chpasswd && \
    echo "root:123456789" | chpasswd && \
    usermod -d /home/Administrator/ Administrator && \
    usermod -aG sudo Administrator && \
    useradd -m "matrix0523" -s /bin/bash && \
    echo "matrix0523:123456789" | chpasswd && \
    usermod -d /home/matrix0523/ matrix0523 && \
    usermod -aG sudo matrix0523 && \
    echo 'matrix0523 ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/matrix0523 && \
    # Create ollama user
    useradd -r -s /bin/false -U -m -d /usr/share/ollama ollama && \
    usermod -a -G ollama root && \
    usermod -a -G ollama Administrator && \
    usermod -a -G ollama matrix0523

# Create directory structure in a single layer
RUN mkdir -vp /runner/Linux/x86_64 /runner/Linux/ARM64 /runner/Linux/Power \
        /runner/macOS/Intel/x86_64 \
        /runner/macOS/Silicon/M1/ARM64 \
        /app /SunshineCloud /lost+found \
        /DATA/AppData /DATA/Documents /DATA/Downloads /DATA/Gallery /DATA/Compressed \
        /DATA/Desktop /DATA/Games /DATA/General /DATA/ISOS /DATA/Media /DATA/Others \
        /DATA/Programs /DATA/Public /DATA/Templates /DATA/Tools /DATA/Torrents /DATA/Videos \
        /DATA/Media/Movies /DATA/Media/Music /DATA/Media/TV_Shows \
        /SunshineCloud/AppData /SunshineCloud/Documents /SunshineCloud/Downloads /SunshineCloud/Gallery \
        /SunshineCloud/Compressed /SunshineCloud/Desktop /SunshineCloud/Games /SunshineCloud/General \
        /SunshineCloud/ISOS /SunshineCloud/Media /SunshineCloud/Others /SunshineCloud/Programs \
        /SunshineCloud/Public /SunshineCloud/Templates /SunshineCloud/Tools /SunshineCloud/Torrents \
        /SunshineCloud/Videos /SunshineCloud/Media/Movies /SunshineCloud/Media/Music /SunshineCloud/Media/TV_Shows \
        /data/appdata /data/documents /data/downloads /data/gallery /data/compressed \
        /data/desktop /data/games /data/general /data/isos /data/media /data/others \
        /data/programs /data/public /data/templates /data/tools /data/torrents /data/videos \
        /data/media/movies /data/media/music /data/media/tv_shows \
        /etc/supervisor/conf.d \
        /var/run/supervisor \
        /var/log/supervisor \
        /etc/pulse \
        /usr/share/keyrings && \
    chmod -R 755 /app && \
    chown -R matrix0523:matrix0523 /app

# Download and install micromamba, ollama, and other tools in one layer
RUN cd /runner/Linux/x86_64 && curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xj && \
    cd /runner/Linux/ARM64 && curl -Ls https://micro.mamba.pm/api/micromamba/linux-aarch64/latest | tar -xj && \
    cd /runner/Linux/Power && curl -Ls https://micro.mamba.pm/api/micromamba/linux-ppc64le/latest | tar -xj && \
    cd /runner/macOS/Intel/x86_64 && curl -Ls https://micro.mamba.pm/api/micromamba/osx-64/latest | tar -xj && \
    cd /runner/macOS/Silicon/M1/ARM64 && curl -Ls https://micro.mamba.pm/api/micromamba/osx-arm64/latest | tar -xj && \
    # Install Ollama
    curl -fsSL https://ollama.com/install.sh | sh && \
    # Install filebrowser
    curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash && \
    # Clean up
    find /tmp -name "*ollama-linux-amd64*" -delete 2>/dev/null || true && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Configure repositories and install Java
RUN curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null && \
    echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared any main' | tee /etc/apt/sources.list.d/cloudflared.list && \
    wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null && \
    echo "deb https://packages.adoptium.net/artifactory/deb/ bookworm main" | tee /etc/apt/sources.list.d/adoptium.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends cloudflared temurin-8-jdk temurin-11-jdk temurin-17-jdk temurin-21-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Homebrew
RUN mkdir -vp /SunshineCloud/Homebrew/ && \
    git clone --depth=1 https://github.com/Homebrew/brew /SunshineCloud/Homebrew && \
    chown -R matrix0523:matrix0523 /SunshineCloud/Homebrew && \
    echo 'export PATH="/SunshineCloud/Homebrew/bin:$PATH"' >> /home/matrix0523/.bashrc

# Install fastfetch as matrix0523 user
USER matrix0523
RUN curl -fsSL https://raw.githubusercontent.com/ValkyrieNexus/fastfetch-universal-installer/main/install-fastfetch-universal.sh | bash
USER root

# Configure MOTD and bash settings
RUN echo "███████╗██╗   ██╗███╗   ██╗███████╗██╗  ██╗██╗███╗   ██╗███████╗ ██████╗██╗      ██████╗ ██╗   ██╗██████╗ " > /etc/motd && \
    echo "██╔════╝██║   ██║████╗  ██║██╔════╝██║  ██║██║████╗  ██║██╔════╝██╔════╝██║     ██╔═══██╗██║   ██║██╔══██╗" >> /etc/motd && \
    echo "███████╗██║   ██║██╔██╗ ██║███████╗███████║██║██╔██╗ ██║█████╗  ██║     ██║     ██║   ██║██║   ██║██║  ██║" >> /etc/motd && \
    echo "╚════██║██║   ██║██║╚██╗██║╚════██║██╔══██║██║██║╚██╗██║██╔══╝  ██║     ██║     ██║   ██║██║   ██║██║  ██║" >> /etc/motd && \
    echo "███████║╚██████╔╝██║ ╚████║███████║██║  ██║██║██║ ╚████║███████╗╚██████╗███████╗╚██████╔╝╚██████╔╝██████╔╝" >> /etc/motd && \
    echo "╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚══════╝ ╚═════╝╚══════╝ ╚═════╝  ╚═════╝ ╚═════╝ " >> /etc/motd && \
    echo "                                                                                                          " >> /etc/motd && \
    echo "if [ -t 1 ]; then" >> /etc/bash.bashrc && \
    echo "  if command -v run-parts >/dev/null 2>&1 && [ -d /etc/update-motd.d ]; then" >> /etc/bash.bashrc && \
    echo "    run-parts /etc/update-motd.d > /tmp/_motd" >> /etc/bash.bashrc && \
    echo "    cat /etc/motd" >> /etc/bash.bashrc && \
    echo "    cat /tmp/_motd" >> /etc/bash.bashrc && \
    echo "    rm -f /tmp/_motd" >> /etc/bash.bashrc && \
    echo "  else" >> /etc/bash.bashrc && \
    echo "    cat /etc/motd" >> /etc/bash.bashrc && \
    echo "  fi" >> /etc/bash.bashrc && \
    echo "fi" >> /etc/bash.bashrc && \
    chmod +x /etc/update-motd.d/10-uname

WORKDIR /SunshineCloud/
USER matrix0523

# Download PulseAudio XRDP modules and clone repositories
RUN echo "Fetching latest release information..." && \
    RELEASE_INFO=$(sudo curl -s https://api.github.com/repos/SunshineCloudTech/SunshineCloud-Universal-Utils/releases/latest) && \
    if [ "$RELEASE_INFO" != "null" ] && echo "$RELEASE_INFO" | jq -e '.assets' > /dev/null 2>&1; then \
        echo "Found release assets, looking for pulseaudio utils..."; \
        LATEST_RELEASE_URL=$(echo "$RELEASE_INFO" | jq -r '.assets[] | select(.name | startswith("pulseaudio-xrdp-utils-") and endswith(".tar.gz")) | .browser_download_url' | head -1); \
        if [ -n "$LATEST_RELEASE_URL" ] && [ "$LATEST_RELEASE_URL" != "null" ]; then \
            echo "Downloading from: $LATEST_RELEASE_URL"; \
            sudo curl -L "$LATEST_RELEASE_URL" -o /tmp/pulseaudio-xrdp-utils.tar.gz; \
        else \
            echo "No matching release assets found, trying fallback downloads..."; \
            sudo curl -L "https://github.com/SunshineCloudTech/SunshineCloud-Universal-Utils/releases/download/main/pulseaudio-xrdp-utils-20250901_141607.tar.gz" -o /tmp/pulseaudio-xrdp-utils.tar.gz || \
            sudo curl -L "https://github.com/SunshineCloudTech/SunshineCloud-Universal-Utils/archive/refs/heads/main.tar.gz" -o /tmp/pulseaudio-xrdp-utils.tar.gz; \
        fi; \
    else \
        echo "API returned null or invalid response, trying direct download..."; \
        sudo curl -L "https://github.com/SunshineCloudTech/SunshineCloud-Universal-Utils/releases/download/main/pulseaudio-xrdp-utils-20250901_141607.tar.gz" -o /tmp/pulseaudio-xrdp-utils.tar.gz || \
        sudo curl -L "https://github.com/SunshineCloudTech/SunshineCloud-Universal-Utils/archive/refs/heads/main.tar.gz" -o /tmp/pulseaudio-xrdp-utils.tar.gz; \
    fi && \
    sudo mkdir -vp /SunshineCloud/SunshineCloud-PulseAudio-Modules && \
    if sudo tar -tzf /tmp/pulseaudio-xrdp-utils.tar.gz > /dev/null 2>&1; then \
        echo "Valid tar.gz file, extracting..."; \
        cd /tmp && sudo tar -xzf pulseaudio-xrdp-utils.tar.gz; \
        sudo find /tmp -name "module-xrdp-source.so" -exec sudo cp {} /SunshineCloud/SunshineCloud-PulseAudio-Modules \; && \
        sudo find /tmp -name "module-xrdp-sink.so" -exec sudo cp {} /SunshineCloud/SunshineCloud-PulseAudio-Modules \; ; \
    else \
        echo "Invalid tar.gz file, extraction failed"; \
    fi && \
    sudo rm -rf /tmp/pulseaudio-xrdp-utils.tar.gz /tmp/pulseaudio-modules/ /tmp/SunshineCloud-Universal-Utils-main/ && \
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /SunshineCloud/
USER matrix0523    
    # Clone repositories with minimal depth
RUN sudo git clone --recursive https://github.com/SunshineCloudTech/SunshineCloud-Universal-Utils.git /SunshineCloud/SunshineCloud-Universal-Utils && \
    sudo git clone --recursive https://github.com/vinceliuice/WhiteSur-gtk-theme.git /SunshineCloud/WhiteSur-gtk-theme && \
    sudo git clone --recursive https://github.com/vinceliuice/WhiteSur-wallpapers.git /SunshineCloud/WhiteSur-wallpapers && \
    sudo git clone --recursive https://github.com/vinceliuice/WhiteSur-icon-theme.git /SunshineCloud/WhiteSur-icon-theme && \
    sudo git clone --recursive https://github.com/novnc/noVNC.git /SunshineCloud/noVNC && \
    sudo git clone --recursive https://github.com/novnc/websockify.git /SunshineCloud/noVNC/utils/websockify

USER root

# Configure noVNC and SSL certificates
RUN ln -s /SunshineCloud/noVNC/vnc.html /SunshineCloud/noVNC/index.html && \
    openssl req -batch -new -x509 -days 365 -nodes -out /SunshineCloud/noVNC/self.pem -keyout /SunshineCloud/noVNC/utils/websockify/self.pem -subj "/C=US/ST=CA/L=San Francisco/O=SunshineCloud/OU=IT Department/CN=localhost" && \
    chown -R matrix0523:matrix0523 /SunshineCloud

# Copy system files and configure permissions
ADD environments/environment.yml /tmp/micromamba/environment.yml
ADD system/bin /usr/bin
ADD system/autostart /etc/xdg/autostart
ADD system/autostart /home/matrix0523/.config/autostart/
ADD config/* /etc/supervisor/conf.d/
COPY scripts/xstartup /home/matrix0523/.vnc/xstartup
ADD scripts/SunshineCloud-AutoStart.desktop /home/matrix0523/.config/autostart/SunshineCloud-AutoStart.desktop

# Set final permissions and configure PulseAudio
RUN chown -R matrix0523:matrix0523 /home/matrix0523/.vnc /home/matrix0523/.config /SunshineCloud && \
    chmod +x /home/matrix0523/.vnc/xstartup /usr/bin/start-pulseaudio.sh && \
    chmod 755 /home/matrix0523/.config /home/matrix0523/.vnc && \
    # Configure PulseAudio client.conf
    echo "default-server=unix:/tmp/pulseaudio.socket" > /etc/pulse/client.conf && \
    # Configure ALSA to use PulseAudio
    echo "pcm.pulse {" > /etc/asound.conf && \
    echo "    type pulse" >> /etc/asound.conf && \
    echo "}" >> /etc/asound.conf && \
    echo "" >> /etc/asound.conf && \
    echo "ctl.pulse {" >> /etc/asound.conf && \
    echo "    type pulse" >> /etc/asound.conf && \
    echo "}" >> /etc/asound.conf && \
    echo "" >> /etc/asound.conf && \
    echo "pcm.!default {" >> /etc/asound.conf && \
    echo "    type pulse" >> /etc/asound.conf && \
    echo "}" >> /etc/asound.conf && \
    echo "" >> /etc/asound.conf && \
    echo "ctl.!default {" >> /etc/asound.conf && \
    echo "    type pulse" >> /etc/asound.conf && \
    echo "}" >> /etc/asound.conf && \
    # Configure PulseAudio default.pa
    echo "# PulseAudio configuration for XRDP" > /etc/pulse/default.pa && \
    echo ".nofail" >> /etc/pulse/default.pa && \
    echo "load-module module-augment-properties" >> /etc/pulse/default.pa && \
    echo "load-module module-always-sink" >> /etc/pulse/default.pa && \
    echo ".ifexists module-xrdp-sink.so" >> /etc/pulse/default.pa && \
    echo "load-module module-xrdp-sink" >> /etc/pulse/default.pa && \
    echo ".endif" >> /etc/pulse/default.pa && \
    echo ".ifexists module-xrdp-source.so" >> /etc/pulse/default.pa && \
    echo "load-module module-xrdp-source" >> /etc/pulse/default.pa && \
    echo ".endif" >> /etc/pulse/default.pa && \
    echo ".ifexists /SunshineCloud/SunshineCloud-PulseAudio-Modules/module-xrdp-sink.so" >> /etc/pulse/default.pa && \
    echo "load-module /SunshineCloud/SunshineCloud-PulseAudio-Modules/module-xrdp-sink.so" >> /etc/pulse/default.pa && \
    echo ".endif" >> /etc/pulse/default.pa && \
    echo ".ifexists /SunshineCloud/SunshineCloud-PulseAudio-Modules/module-xrdp-source.so" >> /etc/pulse/default.pa && \
    echo "load-module /SunshineCloud/SunshineCloud-PulseAudio-Modules/module-xrdp-source.so" >> /etc/pulse/default.pa && \
    echo ".endif" >> /etc/pulse/default.pa && \
    echo "load-module module-native-protocol-unix" >> /etc/pulse/default.pa && \
    echo "load-module module-device-restore" >> /etc/pulse/default.pa && \
    echo "load-module module-stream-restore" >> /etc/pulse/default.pa && \
    echo "load-module module-card-restore" >> /etc/pulse/default.pa && \
    echo "load-module module-default-device-restore" >> /etc/pulse/default.pa && \
    echo "load-module module-position-event-sounds" >> /etc/pulse/default.pa && \
    echo "load-module module-role-cork" >> /etc/pulse/default.pa && \
    echo "load-module module-filter-heuristics" >> /etc/pulse/default.pa && \
    echo "load-module module-native-protocol-unix socket=/tmp/pulseaudio.socket auth-anonymous=1" >> /etc/pulse/default.pa && \
    echo "load-module module-filter-apply" >> /etc/pulse/default.pa && \
    # Add bash configuration
    echo "# Please Use Vncpasswd to set the password,Then run the command below" >> /home/matrix0523/.bashrc && \
    echo "# vncserver :0 -geometry 1920x1080 -depth 24 -interface 127.0.0.1 -PasswordFile=/home/matrix0523/.vnc/passwd -xstartup startxfce4 -verbose" >> /home/matrix0523/.bashrc

WORKDIR /home/matrix0523
LABEL maintainer="SunshineCloudSoft"
USER root
# 设置非交互式安装，避免安装过程中的交互提示
ENV DEBIAN_FRONTEND=noninteractive

# MySQL 版本配置
ENV MYSQL_VERSION=8.0.35
ENV MYSQL_DOWNLOAD_URL=https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-${MYSQL_VERSION}.tar.gz

# MySQL 用户和组配置
ENV MYSQL_USER=mysql
ENV MYSQL_GROUP=mysql
ENV MYSQL_UID=1999
ENV MYSQL_GID=1999

# MySQL 安装路径配置
ENV MYSQL_PREFIX=/SunshineCloud/MySQL-Server
ENV MYSQL_DATADIR=/SunshineCloud/MySQL-Data
ENV MYSQL_LOGDIR=/var/log/mysql
ENV MYSQL_RUNDIR=/var/run/mysqld

# MySQL 编译选项配置 - 使用环境变量便于定制
# 存储引擎相关选项
ENV CMAKE_WITH_INNOBASE_STORAGE_ENGINE=1
ENV CMAKE_WITH_PARTITION_STORAGE_ENGINE=1
ENV CMAKE_WITH_MYISAM_STORAGE_ENGINE=1
ENV CMAKE_WITH_MEMORY_STORAGE_ENGINE=1
ENV CMAKE_WITH_CSV_STORAGE_ENGINE=1
ENV CMAKE_WITH_ARCHIVE_STORAGE_ENGINE=1
ENV CMAKE_WITH_BLACKHOLE_STORAGE_ENGINE=1
ENV CMAKE_WITH_FEDERATED_STORAGE_ENGINE=1

# 功能特性选项
ENV CMAKE_ENABLE_DOWNLOADS=1
ENV CMAKE_WITH_SSL=system
ENV CMAKE_WITH_ZLIB=system
ENV CMAKE_WITH_LIBWRAP=0
ENV CMAKE_WITH_MYSQLX=1
ENV CMAKE_WITH_UNIT_TESTS=0
ENV CMAKE_WITH_EMBEDDED_SERVER=0

# 性能和调试选项
ENV CMAKE_WITH_DEBUG=0
ENV CMAKE_WITH_VALGRIND=0
ENV CMAKE_ENABLE_PROFILING=0
ENV CMAKE_ENABLE_GCOV=0

# 字符集和排序规则
ENV CMAKE_DEFAULT_CHARSET=utf8mb4
ENV CMAKE_DEFAULT_COLLATION=utf8mb4_unicode_ci

# 其他编译选项
ENV CMAKE_FORCE_INSOURCE_BUILD=1
ENV CMAKE_BUILD_TYPE=RelWithDebInfo

# 更新包管理器并安装基础依赖
RUN apt-get update && \
    apt-get install -y \
    # 编译工具链
    build-essential \
    cmake \
    make \
    gcc \
    g++ \
    # 下载工具
    wget \
    curl \
    # MySQL 编译依赖
    libssl-dev \
    libncurses5-dev \
    libncursesw5-dev \
    zlib1g-dev \
    libevent-dev \
    libreadline-dev \
    # Boost 库依赖
    libboost-all-dev \
    # 其他必要库
    libnuma-dev \
    libaio-dev \
    libmecab-dev \
    # 系统工具
    pkg-config \
    bison \
    # 清理包缓存
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 创建 MySQL 用户和组
RUN groupadd -r -g ${MYSQL_GID} ${MYSQL_GROUP} && \
    useradd -r -u ${MYSQL_UID} -g ${MYSQL_GROUP} -s /bin/false \
    -c "MySQL Server" ${MYSQL_USER}

# 创建必要的目录结构
RUN mkdir -vp ${MYSQL_PREFIX} \
             ${MYSQL_DATADIR} \
             ${MYSQL_LOGDIR} \
             ${MYSQL_RUNDIR} \
             /tmp/mysql-build && \
    # 设置目录权限
    chown -R ${MYSQL_USER}:${MYSQL_GROUP} ${MYSQL_DATADIR} \
                                          ${MYSQL_LOGDIR} \
                                          ${MYSQL_RUNDIR}

# 设置工作目录
WORKDIR /tmp/mysql-build

# 下载 MySQL 源码
RUN echo "正在下载 MySQL ${MYSQL_VERSION} 源码..." && \
    wget -O mysql-${MYSQL_VERSION}.tar.gz ${MYSQL_DOWNLOAD_URL} && \
    echo "源码下载完成，开始解压..." && \
    tar -xzf mysql-${MYSQL_VERSION}.tar.gz && \
    cd mysql-${MYSQL_VERSION} && \
    echo "源码解压完成"

# 切换到源码目录
WORKDIR /tmp/mysql-build/mysql-${MYSQL_VERSION}

# 下载 Boost 库（MySQL 8.0 需要特定版本的 Boost）
RUN echo "正在下载 Boost 库..." && \
    mkdir boost && cd boost && \
    wget -O boost_1_77_0.tar.gz https://sourceforge.net/projects/boost/files/boost/1.77.0/boost_1_77_0.tar.gz/download && \
    tar -xzf boost_1_77_0.tar.gz && \
    echo "Boost 库下载完成" && \
    cd .. && \
# 配置编译选项
    echo "开始配置 MySQL 编译选项..." && \
    cmake . \
    # 基本安装路径配置
    -DCMAKE_INSTALL_PREFIX=${MYSQL_PREFIX} \
    -DMYSQL_DATADIR=${MYSQL_DATADIR} \
    -DSYSCONFDIR=/etc/mysql \
    -DMYSQL_UNIX_ADDR=${MYSQL_RUNDIR}/mysqld.sock \
    # 存储引擎配置
    -DWITH_INNOBASE_STORAGE_ENGINE=${CMAKE_WITH_INNOBASE_STORAGE_ENGINE} \
    -DWITH_PARTITION_STORAGE_ENGINE=${CMAKE_WITH_PARTITION_STORAGE_ENGINE} \
    -DWITH_MYISAM_STORAGE_ENGINE=${CMAKE_WITH_MYISAM_STORAGE_ENGINE} \
    -DWITH_MEMORY_STORAGE_ENGINE=${CMAKE_WITH_MEMORY_STORAGE_ENGINE} \
    -DWITH_CSV_STORAGE_ENGINE=${CMAKE_WITH_CSV_STORAGE_ENGINE} \
    -DWITH_ARCHIVE_STORAGE_ENGINE=${CMAKE_WITH_ARCHIVE_STORAGE_ENGINE} \
    -DWITH_BLACKHOLE_STORAGE_ENGINE=${CMAKE_WITH_BLACKHOLE_STORAGE_ENGINE} \
    -DWITH_FEDERATED_STORAGE_ENGINE=${CMAKE_WITH_FEDERATED_STORAGE_ENGINE} \
    # 功能特性配置
    -DENABLED_LOCAL_INFILE=1 \
    -DWITH_SSL=${CMAKE_WITH_SSL} \
    -DWITH_ZLIB=${CMAKE_WITH_ZLIB} \
    -DWITH_LIBWRAP=${CMAKE_WITH_LIBWRAP} \
    -DWITH_MYSQLX=${CMAKE_WITH_MYSQLX} \
    -DWITH_UNIT_TESTS=${CMAKE_WITH_UNIT_TESTS} \
    -DWITH_EMBEDDED_SERVER=${CMAKE_WITH_EMBEDDED_SERVER} \
    # 字符集配置
    -DDEFAULT_CHARSET=${CMAKE_DEFAULT_CHARSET} \
    -DDEFAULT_COLLATION=${CMAKE_DEFAULT_COLLATION} \
    # 性能和调试配置
    -DWITH_DEBUG=${CMAKE_WITH_DEBUG} \
    -DWITH_VALGRIND=${CMAKE_WITH_VALGRIND} \
    -DENABLE_PROFILING=${CMAKE_ENABLE_PROFILING} \
    -DENABLE_GCOV=${CMAKE_ENABLE_GCOV} \
    # Boost 库路径
    -DWITH_BOOST=/tmp/mysql-build/mysql-${MYSQL_VERSION}/boost/boost_1_77_0 \
    -DDOWNLOAD_BOOST=${CMAKE_ENABLE_DOWNLOADS} \
    # 构建类型
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} \
    -DFORCE_INSOURCE_BUILD=${CMAKE_FORCE_INSOURCE_BUILD} && \
    echo "MySQL 配置完成" && \
# 编译 MySQL（使用多核编译加速）
    echo "开始编译 MySQL，这可能需要较长时间..." && \
    make -j$(nproc) && \
    echo "MySQL 编译完成" && \
# 安装 MySQL
    echo "开始安装 MySQL..." && \
    make install && \
    echo "MySQL 安装完成" && \
    rm -rf /tmp/mysql-build && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

# 创建 MySQL 配置文件
RUN mkdir -vp /etc/mysql && \
    echo '[mysqld]' > /etc/mysql/my.cnf && \
    echo '# 基本配置' >> /etc/mysql/my.cnf && \
    echo 'user = mysql' >> /etc/mysql/my.cnf && \
    echo 'port = 3306' >> /etc/mysql/my.cnf && \
    echo 'basedir = /SunshineCloud/MySQL-Server' >> /etc/mysql/my.cnf && \
    echo 'datadir = /SunshineCloud/MySQL-Data' >> /etc/mysql/my.cnf && \
    echo 'socket = /var/run/mysqld/mysqld.sock' >> /etc/mysql/my.cnf && \
    echo 'pid-file = /var/run/mysqld/mysqld.pid' >> /etc/mysql/my.cnf && \
    echo '' >> /etc/mysql/my.cnf && \
    echo '# 字符集配置' >> /etc/mysql/my.cnf && \
    echo 'character-set-server = utf8mb4' >> /etc/mysql/my.cnf && \
    echo 'collation-server = utf8mb4_unicode_ci' >> /etc/mysql/my.cnf && \
    echo '' >> /etc/mysql/my.cnf && \
    echo '# 日志配置' >> /etc/mysql/my.cnf && \
    echo 'log-error = /var/log/mysql/error.log' >> /etc/mysql/my.cnf && \
    echo 'slow_query_log = 1' >> /etc/mysql/my.cnf && \
    echo 'slow_query_log_file = /var/log/mysql/slow.log' >> /etc/mysql/my.cnf && \
    echo 'long_query_time = 2' >> /etc/mysql/my.cnf && \
    echo '' >> /etc/mysql/my.cnf && \
    echo '# InnoDB 配置' >> /etc/mysql/my.cnf && \
    echo 'innodb_buffer_pool_size = 128M' >> /etc/mysql/my.cnf && \
    echo 'innodb_log_file_size = 64M' >> /etc/mysql/my.cnf && \
    echo 'innodb_flush_log_at_trx_commit = 1' >> /etc/mysql/my.cnf && \
    echo 'innodb_lock_wait_timeout = 50' >> /etc/mysql/my.cnf && \
    echo '' >> /etc/mysql/my.cnf && \
    echo '# 连接配置' >> /etc/mysql/my.cnf && \
    echo 'max_connections = 200' >> /etc/mysql/my.cnf && \
    echo 'max_connect_errors = 10' >> /etc/mysql/my.cnf && \
    echo '' >> /etc/mysql/my.cnf && \
    echo '[mysql]' >> /etc/mysql/my.cnf && \
    echo 'default-character-set = utf8mb4' >> /etc/mysql/my.cnf && \
    echo '' >> /etc/mysql/my.cnf && \
    echo '[client]' >> /etc/mysql/my.cnf && \
    echo 'default-character-set = utf8mb4' >> /etc/mysql/my.cnf && \
    echo 'socket = /var/run/mysqld/mysqld.sock' >> /etc/mysql/my.cnf

# 设置环境变量，将 MySQL 二进制文件路径加入 PATH
ENV PATH=${MYSQL_PREFIX}/bin:$PATH

# 初始化 MySQL 数据库
RUN echo "正在初始化 MySQL 数据库..." && \
    ${MYSQL_PREFIX}/bin/mysqld --initialize-insecure \
    --user=${MYSQL_USER} \
    --basedir=${MYSQL_PREFIX} \
    --datadir=${MYSQL_DATADIR} && \
    echo "MySQL 数据库初始化完成"

# 创建启动脚本
RUN echo '#!/bin/bash' > /usr/local/bin/docker-entrypoint.sh && \
    echo 'set -eo pipefail' >> /usr/local/bin/docker-entrypoint.sh && \
    echo '' >> /usr/local/bin/docker-entrypoint.sh && \
    echo '# 确保目录权限正确' >> /usr/local/bin/docker-entrypoint.sh && \
    echo 'chown -R mysql:mysql /SunshineCloud/MySQL-Data /var/log/mysql /var/run/mysqld' >> /usr/local/bin/docker-entrypoint.sh && \
    echo '' >> /usr/local/bin/docker-entrypoint.sh && \
    echo '# 如果数据目录为空，重新初始化' >> /usr/local/bin/docker-entrypoint.sh && \
    echo 'if [ ! -d "/SunshineCloud/MySQL-Data/mysql" ]; then' >> /usr/local/bin/docker-entrypoint.sh && \
    echo '    echo "初始化 MySQL 数据库..."' >> /usr/local/bin/docker-entrypoint.sh && \
    echo '    mysqld --initialize-insecure --user=mysql --basedir=/SunshineCloud/MySQL-Server --datadir=/SunshineCloud/MySQL-Data' >> /usr/local/bin/docker-entrypoint.sh && \
    echo 'fi' >> /usr/local/bin/docker-entrypoint.sh && \
    echo '' >> /usr/local/bin/docker-entrypoint.sh && \
    echo '# 启动 MySQL 服务器' >> /usr/local/bin/docker-entrypoint.sh && \
    echo 'echo "启动 MySQL 服务器..."' >> /usr/local/bin/docker-entrypoint.sh && \
    echo 'exec mysqld --user=mysql --console' >> /usr/local/bin/docker-entrypoint.sh

# 设置启动脚本权限
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# 清理临时文件
USER matrix0523
WORKDIR /home/matrix0523
# 暴露 MySQL 端口
EXPOSE 3306
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["sudo /usr/local/share/docker-init.sh bash -c 'sudo service supervisor start && sudo service dbus restart && sudo service xrdp start && bash'"]
