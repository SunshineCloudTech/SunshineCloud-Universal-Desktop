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
        libcap2-bin libkrb5-3 libnss-mdns libnss-myhostname libvte-2.9-common \
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
        fcitx5-pinyin firefox fonts-arphic-ukai fonts-arphic-uming \
        fonts-noto-cjk fonts-noto-cjk-extra fonts-wqy-microhei fonts-wqy-zenhei \
        libasound2-dev libatk1.0-0 libcairo-gobject2 libgconf-2-4 \
        libgdk-pixbuf2.0-0 libglib2.0-dev libglib2.0-0 libgtk-3-0 libgtk-3-dev \
        libnss3-dev libpangocairo-1.0-0 libselinux1-dev libxrandr2 libxss1 \
        libxtst6 openssh-server pulseaudio sassc tigervnc-standalone-server \
        tigervnc-viewer tigervnc-xorg-extension uuid-runtime vim vlc \
        xautolock xfce4 xfce4-clipman-plugin xfce4-cpugraph-plugin \
        xfce4-netload-plugin xfce4-screenshooter xfce4-taskmanager \
        xfce4-terminal xfce4-xkb-plugin xfonts-intl-chinese xfonts-wqy \
        libxml2-utils xorgxrdp xprintidle xrdp xterm \
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
RUN mkdir -p /runner/Linux/{x86_64,ARM64,Power} \
        /runner/macOS/Intel/x86_64 \
        /runner/macOS/Silicon/M1/ARM64 \
        /app /SunshineCloud /lost+found \
        /DATA/{AppData,Documents,Downloads,Gallery,Compressed,Desktop,Games,General,ISOS,Media,Others,Programs,Public,Templates,Tools,Torrents,Videos} \
        /DATA/Media/{Movies,Music,TV_Shows} \
        /SunshineCloud/{AppData,Documents,Downloads,Gallery,Compressed,Desktop,Games,General,ISOS,Media,Others,Programs,Public,Templates,Tools,Torrents,Videos} \
        /SunshineCloud/Media/{Movies,Music,TV_Shows} \
        /data/{appdata,documents,downloads,gallery,compressed,desktop,games,general,isos,media,others,programs,public,templates,tools,torrents,videos} \
        /data/media/{movies,music,tv_shows} \
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
    cd /tmp && \
    curl -L https://ollama.com/download/ollama-linux-amd64.tgz -o ollama-linux-amd64.tgz && \
    tar -C /usr -xzf ollama-linux-amd64.tgz && \
    rm -rf ollama-linux-amd64.tgz && \
    # Install filebrowser
    curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash && \
    # Clean up
    find /tmp -name "*ollama*" -delete 2>/dev/null || true

# Configure repositories and install Java
RUN curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null && \
    echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared any main' | tee /etc/apt/sources.list.d/cloudflared.list && \
    wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null && \
    echo "deb https://packages.adoptium.net/artifactory/deb/ bookworm main" | tee /etc/apt/sources.list.d/adoptium.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends cloudflared temurin-8-jdk temurin-11-jdk temurin-17-jdk temurin-21-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Homebrew
RUN mkdir -p /SunshineCloud/Homebrew/ && \
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
    echo "#!/bin/bash" > /etc/update-motd.d/10-uname && \
    echo "bash -c fastfetch" >> /etc/update-motd.d/10-uname && \
    chmod +x /etc/update-motd.d/10-uname

WORKDIR /SunshineCloud/
USER matrix0523

# Download PulseAudio XRDP modules and clone repositories
RUN echo "Fetching latest release information..." && \
    RELEASE_INFO=$(curl -s https://api.github.com/repos/SunshineCloudTech/SunshineCloud-Universal-Utils/releases/latest) && \
    if [ "$RELEASE_INFO" != "null" ] && echo "$RELEASE_INFO" | jq -e '.assets' > /dev/null 2>&1; then \
        echo "Found release assets, looking for pulseaudio utils..."; \
        LATEST_RELEASE_URL=$(echo "$RELEASE_INFO" | jq -r '.assets[] | select(.name | startswith("pulseaudio-xrdp-utils-") and endswith(".tar.gz")) | .browser_download_url' | head -1); \
        if [ -n "$LATEST_RELEASE_URL" ] && [ "$LATEST_RELEASE_URL" != "null" ]; then \
            echo "Downloading from: $LATEST_RELEASE_URL"; \
            curl -L "$LATEST_RELEASE_URL" -o pulseaudio-xrdp-utils.tar.gz; \
        else \
            echo "No matching release assets found, trying fallback downloads..."; \
            curl -L "https://github.com/SunshineCloudTech/SunshineCloud-Universal-Utils/releases/download/main/pulseaudio-xrdp-utils-20250901_141607.tar.gz" -o pulseaudio-xrdp-utils.tar.gz || \
            curl -L "https://github.com/SunshineCloudTech/SunshineCloud-Universal-Utils/archive/refs/heads/main.tar.gz" -o pulseaudio-xrdp-utils.tar.gz; \
        fi; \
    else \
        echo "API returned null or invalid response, trying direct download..."; \
        curl -L "https://github.com/SunshineCloudTech/SunshineCloud-Universal-Utils/releases/download/main/pulseaudio-xrdp-utils-20250901_141607.tar.gz" -o pulseaudio-xrdp-utils.tar.gz || \
        curl -L "https://github.com/SunshineCloudTech/SunshineCloud-Universal-Utils/archive/refs/heads/main.tar.gz" -o pulseaudio-xrdp-utils.tar.gz; \
    fi && \
    sudo mkdir -p /SunshineCloud/SunshineCloud-PulseAudio-Modules && \
    if tar -tzf pulseaudio-xrdp-utils.tar.gz > /dev/null 2>&1; then \
        echo "Valid tar.gz file, extracting..."; \
        tar -xzf pulseaudio-xrdp-utils.tar.gz; \
        find . -name "module-xrdp-source.so" -exec sudo cp {} /SunshineCloud/SunshineCloud-PulseAudio-Modules \; && \
        find . -name "module-xrdp-sink.so" -exec sudo cp {} /SunshineCloud/SunshineCloud-PulseAudio-Modules \; ; \
    else \
        echo "Invalid tar.gz file, extraction failed"; \
    fi && \
    rm -rf pulseaudio-xrdp-utils.tar.gz pulseaudio-modules/ SunshineCloud-Universal-Utils-main/ && \
    # Clone repositories with minimal depth
    git clone --depth=1 https://github.com/SunshineCloudTech/SunshineCloud-Universal-Utils.git && \
    git clone --depth=1 https://github.com/vinceliuice/WhiteSur-gtk-theme.git && \
    git clone --depth=1 https://github.com/vinceliuice/WhiteSur-wallpapers.git && \
    git clone --depth=1 https://github.com/vinceliuice/WhiteSur-icon-theme.git && \
    git clone --depth=1 https://github.com/novnc/noVNC.git && \
    git clone --depth=1 https://github.com/novnc/websockify.git /SunshineCloud/noVNC/utils/websockify

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
    # Configure PulseAudio daemon.conf
    echo "# PulseAudio daemon configuration for XRDP" > /etc/pulse/daemon.conf && \
    echo "default-sample-format = s16le" >> /etc/pulse/daemon.conf && \
    echo "default-sample-rate = 44100" >> /etc/pulse/daemon.conf && \
    echo "alternate-sample-rate = 48000" >> /etc/pulse/daemon.conf && \
    echo "realtime-scheduling = yes" >> /etc/pulse/daemon.conf && \
    echo "realtime-priority = 5" >> /etc/pulse/daemon.conf && \
    echo "default-fragments = 4" >> /etc/pulse/daemon.conf && \
    echo "default-fragment-size-msec = 25" >> /etc/pulse/daemon.conf && \
    echo "flat-volumes = yes" >> /etc/pulse/daemon.conf && \
    echo "system-instance = no" >> /etc/pulse/daemon.conf && \
    echo "allow-module-loading = yes" >> /etc/pulse/daemon.conf && \
    echo "log-level = info" >> /etc/pulse/daemon.conf && \
    echo "exit-idle-time = 20" >> /etc/pulse/daemon.conf && \
    echo "resample-method = speex-float-1" >> /etc/pulse/daemon.conf && \
    echo "enable-deferred-volume = yes" >> /etc/pulse/daemon.conf && \
    echo "avoid-resampling = no" >> /etc/pulse/daemon.conf && \
    echo "default-server = unix:/tmp/pulseaudio.socket" >> /etc/pulse/daemon.conf && \
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
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["sudo /usr/local/share/docker-init.sh bash -c 'sudo service supervisor start && sudo service dbus restart && sudo service xrdp start && bash'"]
