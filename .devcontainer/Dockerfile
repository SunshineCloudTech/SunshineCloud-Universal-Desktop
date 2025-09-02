# [Choice] Debian version (use bullseye on local arm64/Apple Silicon): bookworm, bullseye, buster
ARG VARIANT="bookworm"
ARG CUSTOM_PACKAGE_LIST="openssl"
FROM buildpack-deps:${VARIANT}-curl
# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends ${CUSTOM_PACKAGE_LIST}
ENV DEBIAN_FRONTEND=noninteractive
ENV MAMBA_ROOT_PREFIX="/opt/micromamba"
# COPY sources/sources-${VARIANT}.list /etc/apt/sources.list
## Use Apt install Distrobox dependencies
RUN apt update && apt upgrade -y && \
    apt install -y apt-utils bash-completion bc bzip2 curl && \
    apt install -y dialog diffutils findutils gnupg gnupg2 && \
    apt install -y gpgsm hostname iproute2 iputils-ping keyutils && \
    apt install -y less libcap2-bin libkrb5-3 libnss-mdns && \
    apt install -y libnss-myhostname libvte-2.9*-common libvte-common locales lsof && \
    apt install -y man-db manpages mtr ncurses-base openssh-client && \
    apt install -y passwd pigz pinentry-curses procps rsync && \
    apt install -y sudo tcpdump time traceroute tree && \
    apt install -y tzdata unzip util-linux wget xauth && \
    apt install -y xz-utils zip libgl1 libegl-mesa0 libegl1-mesa && \
    apt install -y libgl1-mesa-glx libegl1 libglx-mesa0 libvulkan1 mesa-vulkan-drivers
# Install extra dependencies
RUN apt update && apt upgrade -y && \
    apt install -y git git-lfs gcc-multilib g++-multilib gcc-x86-64-linux-gnu && \
    apt install -y g++-x86-64-linux-gnu progress apt-mirror && \
    apt install -y debootstrap dbus-daemon sysvinit-utils && \
    apt install -y software-properties-common lsb-release* ca-certificates locales-all build-essential && \
    apt install -y fonts-noto* fonts-wqy-zenhei nano tasksel xrdp && \
    apt install -y bash-completion* bc bzip2* libgl1* libglib* && \
    apt install -y ffmpeg*
RUN sudo useradd -m "Administrator" -s /bin/bash && \
    echo "Administrator:123456789" | sudo chpasswd && \
    echo "root:123456789" | sudo chpasswd  && \
    sudo usermod -d /home/Administrator/ Administrator && \
    sudo usermod -aG sudo Administrator && \
    sudo useradd -m "matrix0523" -s /bin/bash && \ 
    echo "matrix0523:123456789" | sudo chpasswd && \
    sudo usermod -d /home/matrix0523/ matrix0523 && \
    sudo usermod -aG sudo matrix0523 && \
    sudo touch /etc/sudoers.d/matrix0523 && \ 
    sudo echo 'matrix0523 ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/matrix0523 
RUN sudo mkdir -vp /runner && sudo mkdir -vp /app && sudo mkdir -vp /SunshineCloud && sudo mkdir -vp /lost+found && \
    sudo mkdir -vp /runner/Linux/x86_64 && \
    sudo mkdir -vp /runner/Linux/ARM64 && \
    sudo mkdir -vp /runner/Linux/Power && \
    sudo mkdir -vp /runner/macOS/Intel/x86_64 && \
    sudo mkdir -vp /runner/macOS/Silicon/M1/ARM64 
RUN cd /runner/Linux/x86_64 && curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj 
RUN cd /runner/Linux/ARM64 && curl -Ls https://micro.mamba.pm/api/micromamba/linux-aarch64/latest | tar -xvj 
RUN cd /runner/Linux/Power && curl -Ls https://micro.mamba.pm/api/micromamba/linux-ppc64le/latest | tar -xvj  
RUN cd /runner/macOS/Intel/x86_64 && curl -Ls https://micro.mamba.pm/api/micromamba/osx-64/latest | tar -xvj  
RUN cd /runner/macOS/Silicon/M1/ARM64 && curl -Ls https://micro.mamba.pm/api/micromamba/osx-arm64/latest | tar -xvj 
RUN sudo mkdir -vp "/DATA" && \
    sudo mkdir -vp "/DATA/AppData" && \  
    sudo mkdir -vp "/DATA/Documents" && \
    sudo mkdir -vp "/DATA/Downloads" && \
    sudo mkdir -vp "/DATA/Gallery" && \
    sudo mkdir -vp "/DATA/Compressed" && \
    sudo mkdir -vp "/DATA/Desktop" && \
    sudo mkdir -vp "/DATA/Games" && \
    sudo mkdir -vp "/DATA/General" && \
    sudo mkdir -vp "/DATA/ISOS" && \
    sudo mkdir -vp "/DATA/Media" && \
    sudo mkdir -vp "/DATA/Others" && \
    sudo mkdir -vp "/DATA/Programs" && \
    sudo mkdir -vp "/DATA/Public" && \
    sudo mkdir -vp "/DATA/Templates" && \ 
    sudo mkdir -vp "/DATA/Tools" && \
    sudo mkdir -vp "/DATA/Torrents" && \ 
    sudo mkdir -vp "/DATA/Videos" && \
    sudo mkdir -vp "/DATA/Media/Movies" && \ 
    sudo mkdir -vp "/DATA/Media/Music" && \
    sudo mkdir -vp "/DATA/Media/TV_Shows" && \ 
    sudo mkdir -vp "/SunshineCloud" && \
    sudo mkdir -vp "/SunshineCloud/AppData" && \  
    sudo mkdir -vp "/SunshineCloud/Documents" && \
    sudo mkdir -vp "/SunshineCloud/Downloads" && \
    sudo mkdir -vp "/SunshineCloud/Gallery" && \
    sudo mkdir -vp "/SunshineCloud/Compressed" && \
    sudo mkdir -vp "/SunshineCloud/Desktop" && \
    sudo mkdir -vp "/SunshineCloud/Games" && \
    sudo mkdir -vp "/SunshineCloud/General" && \
    sudo mkdir -vp "/SunshineCloud/ISOS" && \
    sudo mkdir -vp "/SunshineCloud/Media" && \
    sudo mkdir -vp "/SunshineCloud/Others" && \
    sudo mkdir -vp "/SunshineCloud/Programs" && \
    sudo mkdir -vp "/SunshineCloud/Public" && \
    sudo mkdir -vp "/SunshineCloud/Templates" && \ 
    sudo mkdir -vp "/SunshineCloud/Tools" && \
    sudo mkdir -vp "/SunshineCloud/Torrents" && \ 
    sudo mkdir -vp "/SunshineCloud/Videos" && \
    sudo mkdir -vp "/SunshineCloud/Media/Movies" && \ 
    sudo mkdir -vp "/SunshineCloud/Media/Music" && \
    sudo mkdir -vp "/SunshineCloud/Media/TV_Shows" && \ 
    sudo mkdir -vp "/data" && \
    sudo mkdir -vp "/data/appdata" && \  
    sudo mkdir -vp "/data/documents" && \
    sudo mkdir -vp "/data/downloads" && \
    sudo mkdir -vp "/data/gallery" && \
    sudo mkdir -vp "/data/compressed" && \
    sudo mkdir -vp "/data/desktop" && \
    sudo mkdir -vp "/data/games" && \
    sudo mkdir -vp "/data/general" && \
    sudo mkdir -vp "/data/isos" && \
    sudo mkdir -vp "/data/media" && \
    sudo mkdir -vp "/data/others" && \
    sudo mkdir -vp "/data/programs" && \
    sudo mkdir -vp "/data/public" && \
    sudo mkdir -vp "/data/templates" && \ 
    sudo mkdir -vp "/data/tools" && \
    sudo mkdir -vp "/data/torrents" && \ 
    sudo mkdir -vp "/data/videos" && \
    sudo mkdir -vp "/data/media/movies" && \ 
    sudo mkdir -vp "/data/media/music" && \
    sudo mkdir -vp "/data/media/tv_shows"
RUN apt update && apt full-upgrade -y 
RUN apt-get install -y wget apt-transport-https curl
RUN apt-get update && \
    cd /tmp && \
    curl -L https://ollama.com/download/ollama-linux-amd64.tgz -o ollama-linux-amd64.tgz && \
    sudo tar -C /usr -xzf ollama-linux-amd64.tgz && \
    rm -rf ollama-linux-amd64.tgz && \
    find / -name "ollama-linux-amd64.tgz" -type f -delete 2>/dev/null || true && \
    find /tmp -name "*ollama*" -type f -delete 2>/dev/null || true && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
RUN sudo useradd -r -s /bin/false -U -m -d /usr/share/ollama ollama && \
    sudo usermod -a -G ollama root && \
    sudo usermod -a -G ollama Administrator && \  
    sudo usermod -a -G ollama matrix0523 
# RUN curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -
# RUN apt-get install nodejs -y && apt-get install nsolid -y
RUN curl -fsSL https://raw.githubusercontent.com/ValkyrieNexus/fastfetch-universal-installer/main/install-fastfetch-universal.sh | su - matrix0523 -c bash
RUN echo "███████╗██╗   ██╗███╗   ██╗███████╗██╗  ██╗██╗███╗   ██╗███████╗ ██████╗██╗      ██████╗ ██╗   ██╗██████╗ " > /etc/motd && \
    echo "██╔════╝██║   ██║████╗  ██║██╔════╝██║  ██║██║████╗  ██║██╔════╝██╔════╝██║     ██╔═══██╗██║   ██║██╔══██╗" >> /etc/motd && \
    echo "███████╗██║   ██║██╔██╗ ██║███████╗███████║██║██╔██╗ ██║█████╗  ██║     ██║     ██║   ██║██║   ██║██║  ██║" >> /etc/motd && \
    echo "╚════██║██║   ██║██║╚██╗██║╚════██║██╔══██║██║██║╚██╗██║██╔══╝  ██║     ██║     ██║   ██║██║   ██║██║  ██║" >> /etc/motd && \
    echo "███████║╚██████╔╝██║ ╚████║███████║██║  ██║██║██║ ╚████║███████╗╚██████╗███████╗╚██████╔╝╚██████╔╝██████╔╝" >> /etc/motd && \
    echo "╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚══════╝ ╚═════╝╚══════╝ ╚═════╝  ╚═════╝ ╚═════╝ " >> /etc/motd && \
    echo "                                                                                                          " >> /etc/motd
RUN  apt update && \
     apt install procps iproute2 net-tools bc -y
RUN echo "if [ -t 1 ]; then" >> /etc/bash.bashrc && \
    echo "  if command -v run-parts >/dev/null 2>&1 && [ -d /etc/update-motd.d ]; then" >> /etc/bash.bashrc && \
    echo "    run-parts /etc/update-motd.d > /tmp/_motd" >> /etc/bash.bashrc && \
    echo "    cat /etc/motd" >> /etc/bash.bashrc && \
    echo "    cat /tmp/_motd" >> /etc/bash.bashrc && \
    echo "    rm -f /tmp/_motd" >> /etc/bash.bashrc && \
    echo "  else" >> /etc/bash.bashrc && \
    echo "    cat /etc/motd" >> /etc/bash.bashrc && \
    echo "  fi" >> /etc/bash.bashrc && \
    echo "fi" >> /etc/bash.bashrc
RUN echo "#!/bin/bash" > /etc/update-motd.d/10-uname
RUN echo "bash -c fastfetch" >> /etc/update-motd.d/10-uname
LABEL maintainer="SunshineCloudSoft"
ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true
RUN sudo apt-get update && \
    sudo apt-get install -y --no-install-recommends supervisor*
RUN sudo chmod -R 755 /app
RUN sudo chown -R matrix0523:matrix0523 /app
WORKDIR /SunshineCloud/
RUN sudo mkdir -p --mode=0755 /usr/share/keyrings
RUN sudo curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null
RUN echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared any main' | sudo tee /etc/apt/sources.list.d/cloudflared.list
RUN sudo apt-get update && sudo apt-get install cloudflared -y
# Cloudflare Tunnel Sample CMD ["cloudflared tunnel --url http://localhost:7860 --metrics 0.0.0.0:8080"]
RUN sudo curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash
# Setup Supervisor
RUN sudo mkdir -vp /etc/supervisor/conf.d
ADD environments/environment.yml /tmp/micromamba/environment.yml
RUN sudo apt-get update && \
    sudo apt-get install -y build-essential supervisor* pkgconf curl file git && \
    sudo mkdir -p /SunshineCloud/Homebrew/ && \
    sudo git clone https://github.com/Homebrew/brew /SunshineCloud/Homebrew      
RUN sudo chown -R matrix0523:matrix0523 /SunshineCloud/Homebrew
ENV PATH="/SunshineCloud/Homebrew/bin:${PATH}"
ENV HOMEBREW_PREFIX=/SunshineCloud/Homebrew
# ENV HOMEBREW_REPOSITORY=/SunshineCloud/Homebrew
ENV HOMEBREW_CACHE=/SunshineCloud/Homebrew/cache
RUN echo 'export PATH="/SunshineCloud/Homebrew/bin:$PATH"' >> /home/matrix0523/.bashrc
USER matrix0523
ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true
WORKDIR /SunshineCloud/Downloads
# Download PulseAudio XRDP modules from GitHub Release
RUN sudo apt-get update && sudo apt-get install -y jq && \
    echo "Fetching latest release information..." && \
    RELEASE_INFO=$(sudo curl -s https://api.github.com/repos/SunshineCloudTech/SunshineCloud-Universal-Utils/releases/latest) && \
    if [ "$RELEASE_INFO" != "null" ] && echo "$RELEASE_INFO" | jq -e '.assets' > /dev/null 2>&1; then \
        echo "Found release assets, looking for pulseaudio utils..."; \
        LATEST_RELEASE_URL=$(echo "$RELEASE_INFO" | jq -r '.assets[] | select(.name | startswith("pulseaudio-xrdp-utils-") and endswith(".tar.gz")) | .browser_download_url' | head -1); \
        if [ -n "$LATEST_RELEASE_URL" ] && [ "$LATEST_RELEASE_URL" != "null" ]; then \
            echo "Downloading from: $LATEST_RELEASE_URL"; \
            sudo curl -L "$LATEST_RELEASE_URL" -o pulseaudio-xrdp-utils.tar.gz; \
        else \
            echo "No matching release assets found, trying fallback downloads..."; \
            if ! sudo curl -L "https://github.com/SunshineCloudTech/SunshineCloud-Universal-Utils/releases/download/main/pulseaudio-xrdp-utils-20250901_141607.tar.gz" -o pulseaudio-xrdp-utils.tar.gz; then \
                echo "Fallback 1 failed, trying alternative..."; \
                sudo curl -L "https://github.com/SunshineCloudTech/SunshineCloud-Universal-Utils/archive/refs/heads/main.tar.gz" -o pulseaudio-xrdp-utils.tar.gz; \
            fi; \
        fi; \
    else \
        echo "API returned null or invalid response, trying direct download..."; \
        if ! sudo curl -L "https://github.com/SunshineCloudTech/SunshineCloud-Universal-Utils/releases/download/main/pulseaudio-xrdp-utils-20250901_141607.tar.gz" -o pulseaudio-xrdp-utils.tar.gz; then \
            echo "Direct download failed, trying source archive..."; \
            sudo curl -L "https://github.com/SunshineCloudTech/SunshineCloud-Universal-Utils/archive/refs/heads/main.tar.gz" -o pulseaudio-xrdp-utils.tar.gz; \
        fi; \
    fi && \
    sudo mkdir -p /SunshineCloud/SunshineCloud-PulseAudio-Modules && \
    if sudo tar -tzf pulseaudio-xrdp-utils.tar.gz > /dev/null 2>&1; then \
        echo "Valid tar.gz file, extracting..."; \
        sudo tar -xzf pulseaudio-xrdp-utils.tar.gz; \
    else \
        echo "Invalid tar.gz file, extraction failed"; \
        exit 1; \
    fi && \
    sudo find . -name "module-xrdp-source.so" -exec cp {} /SunshineCloud/SunshineCloud-PulseAudio-Modules \; && \
    sudo find . -name "module-xrdp-sink.so" -exec cp {} /SunshineCloud/SunshineCloud-PulseAudio-Modules \; && \
    sudo rm -rf pulseaudio-xrdp-utils.tar.gz pulseaudio-modules/ SunshineCloud-Universal-Utils-main/
WORKDIR /SunshineCloud/
RUN sudo chown -R matrix0523:matrix0523 /SunshineCloud
LABEL maintainer="SunshineCloudSoft"   
WORKDIR /home/matrix0523
RUN sudo apt-get update && sudo apt full-upgrade -y && \
    sudo apt-get install -y \
            ca-certificates \
            crudini \
            dbus \
            dbus-x11 \
            fcitx5 \
            fcitx5-chinese-addons \
            fcitx5-pinyin \
            firefox* \
            fonts-arphic-ukai \
            fonts-arphic-uming \
            fonts-noto-cjk \
            fonts-noto-cjk-extra \
            fonts-wqy-microhei \
            fonts-wqy-zenhei \
            git \
            git-lfs \
            less \
            libasound2-dev \
            libatk1.0-0 \
            libcairo-gobject2 \
            libgconf-2-4 \
            libgdk-pixbuf2.0-0 \
            libglib2.0-dev \
            libglib2.0* \
            libgtk-3-0 \
            libgtk-3-dev \
            libnss3-dev \
            libpangocairo-1.0-0 \
            libselinux1-dev \
            libxrandr2 \
            libxss1 \
            libxtst6 \
            locales \
            openssh-server \
            pulseaudio \
            sassc \
            sudo \
            supervisor \
            tigervnc-standalone-server \
            tigervnc-viewer \
            tigervnc-xorg-extension \
            uuid-runtime \
            vim \
            vlc \
            wget \
            xauth \
            xautolock \
            xf* \
            xfce4* \
            xfce4-clipman-plugin \
            xfce4-cpugraph-plugin \
            xfce4-netload-plugin \
            xfce4-screenshooter \
            xfce4-taskmanager \
            xfce4-terminal \
            xfce4-xkb-plugin \
            xfonts-intl-chinese \
            xfonts-wqy \
            *xmllint \
            xorgxrdp \
            xprintidle \
            xrdp* \
            xterm && \
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*
WORKDIR /SunshineCloud/
# RUN sudo git clone --recursive https://github.com/SunshineCloudSoft/SunshineCloud-Universal-Desktop.git
RUN sudo git clone --recursive https://github.com/SunshineCloudTech/SunshineCloud-Universal-Utils.git
RUN sudo git clone --recursive https://github.com/vinceliuice/WhiteSur-gtk-theme.git
RUN sudo git clone --recursive https://github.com/vinceliuice/WhiteSur-wallpapers.git
RUN sudo git clone --recursive https://github.com/vinceliuice/WhiteSur-icon-theme.git
RUN sudo git clone --recursive https://github.com/novnc/noVNC.git
RUN sudo git clone --recursive https://github.com/novnc/websockify.git /SunshineCloud/noVNC/utils/websockify
# Configure noVNC and SSL certificates
RUN sudo ln -s /SunshineCloud/noVNC/vnc.html /SunshineCloud/noVNC/index.html && \
    sudo openssl req -batch -new -x509 -days 365 -nodes -out /SunshineCloud/noVNC/self.pem -keyout /SunshineCloud/noVNC/utils/websockify/self.pem -subj "/C=US/ST=CA/L=San Francisco/O=SunshineCloud/OU=IT Department/CN=localhost"
# Audio requirements - Install additional PulseAudio and GStreamer packages
RUN sudo apt-get update && \
    DEBIAN_FRONTEND=noninteractive sudo apt-get install -y --no-install-recommends \
        pavucontrol \
        ucspi-tcp \
        gstreamer1.0-plugins-good \
        gstreamer1.0-pulseaudio \
        gstreamer1.0-tools && \
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*
# Copy custom noVNC files and configure WebAudio support
ADD system/novnc/ /SunshineCloud/noVNC/
RUN sed -i "/import RFB/a \
        import '../webaudio.js'" \
    /SunshineCloud/noVNC/app/ui.js

RUN sudo chown -R matrix0523:matrix0523 /SunshineCloud/SunshineCloud-Universal-Utils
RUN sudo apt update && sudo apt install -y python3-pip 
ADD system/bin /usr/bin
# ADD system/etc /etc
ADD system/autostart /etc/xdg/autostart
ADD system/autostart /home/matrix0523/.config/autostart/
# Configure PulseAudio - Write daemon.conf directly to avoid encoding issues
RUN sudo mkdir -p /etc/pulse && \
    echo "# PulseAudio daemon configuration for XRDP" | sudo tee /etc/pulse/daemon.conf > /dev/null && \
    echo "# This file configures the PulseAudio daemon for remote desktop use" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "# Basic audio settings" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "default-sample-format = s16le" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "default-sample-rate = 44100" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "alternate-sample-rate = 48000" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "# Real-time scheduling" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "realtime-scheduling = yes" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "realtime-priority = 5" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "# Buffer configuration for lower latency" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "default-fragments = 4" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "default-fragment-size-msec = 25" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "# Volume control" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "flat-volumes = yes" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "# System configuration" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "system-instance = no" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "allow-module-loading = yes" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "# Logging" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "log-level = info" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "# Container optimization" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "exit-idle-time = 20" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "# Resampling" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "resample-method = speex-float-1" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "# Network/remote desktop optimizations" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "enable-deferred-volume = yes" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "avoid-resampling = no" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "# Server configuration" | sudo tee -a /etc/pulse/daemon.conf > /dev/null && \
    echo "default-server = unix:/tmp/pulseaudio.socket" | sudo tee -a /etc/pulse/daemon.conf > /dev/null
# Write PulseAudio XRDP configuration directly to avoid encoding issues
RUN echo "# PulseAudio configuration for XRDP" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "# This configuration enables PulseAudio to work with XRDP" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo ".nofail" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo ".fail" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "# Core modules" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "load-module module-augment-properties" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "load-module module-always-sink" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "# XRDP modules with conditional loading" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo ".ifexists module-xrdp-sink.so" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "load-module module-xrdp-sink" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo ".endif" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo ".ifexists module-xrdp-source.so" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "load-module module-xrdp-source" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo ".endif" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "# Custom XRDP modules from build location" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo ".ifexists /SunshineCloud/SunshineCloud-PulseAudio-Modulesmodule-xrdp-sink.so" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "load-module /SunshineCloud/SunshineCloud-PulseAudio-Modulesmodule-xrdp-sink.so" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo ".endif" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo ".ifexists /SunshineCloud/SunshineCloud-PulseAudio-Modulesmodule-xrdp-source.so" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "load-module /SunshineCloud/SunshineCloud-PulseAudio-Modulesmodule-xrdp-source.so" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo ".endif" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "# Network protocol" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "load-module module-native-protocol-unix" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "# Additional modules for enhanced functionality" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "load-module module-device-restore" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "load-module module-stream-restore" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "load-module module-card-restore" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "load-module module-default-device-restore" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "load-module module-position-event-sounds" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "load-module module-role-cork" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "load-module module-filter-heuristics" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "load-module module-native-protocol-unix socket=/tmp/pulseaudio.socket auth-anonymous=1" | sudo tee -a /etc/pulse/default.pa > /dev/null && \
    echo "load-module module-filter-apply" | sudo tee -a /etc/pulse/default.pa > /dev/null
# RUN sudo cp /etc/pulse-daemon.conf /etc/pulse/daemon.conf
RUN sudo chmod +x /usr/bin/start-pulseaudio.sh
WORKDIR /SunshineCloud/SunshineCloud-Universal-Utils/Jetbrains-Installer/
# 安装和配置Jetbrains IDE软件，用到那个软件就取消注释需要使用特定版本只需修改命令行字段中的版本号即可
# RUN python3 cli.py ./listing.json --clion 2024.1.3 CLion
# RUN python3 cli.py ./listing.json --datagrip 2024.1.3 DataGrip
# RUN python3 cli.py ./listing.json --dataspell 2024.1.3 DataSpell
# RUN python3 cli.py ./listing.json --goland 2024.1.3 GoLand
# RUN python3 cli.py ./listing.json --idea-community 2024.1.3 IDEA-Community
# RUN python3 cli.py ./listing.json --idea-ultimate 2024.1.3 IDEA-Ultimate
# RUN python3 cli.py ./listing.json --PhpStorm 2024.1.3 PhpStorm
# RUN python3 cli.py ./listing.json --pycharm-community 2024.1.3 PyCharm-Community
# RUN python3 cli.py ./listing.json --pycharm 2024.1.3 PyCharm
# RUN python3 cli.py ./listing.json --rider 2024.1.3 Rider
# RUN python3 cli.py ./listing.json --rubymine 2024.1.3 RubyMine
# RUN python3 cli.py ./listing.json --webstorm 2024.1.3 WebStorm
# RUN python3 cli.py ./listing.json --RustRover 2024.1.3 RustRover
WORKDIR /SunshineCloud/
# 配置temurin JDK/JRE
RUN sudo apt install -y wget apt-transport-https gpg
RUN wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
RUN echo "deb https://packages.adoptium.net/artifactory/deb/ bookworm main" | sudo tee /etc/apt/sources.list.d/adoptium.list
RUN sudo apt-get update && sudo apt-get install -y temurin-* -y
# 配置supervisor
RUN sudo apt update && sudo apt install -y supervisor
RUN sudo mkdir -p /var/run/supervisor
RUN sudo mkdir -p /var/log/supervisor
ADD config/* /etc/supervisor/conf.d/
COPY scripts/xstartup /home/matrix0523/.vnc/xstartup
RUN sudo chown -R matrix0523:matrix0523 /home/matrix0523/.vnc && sudo chmod +x /home/matrix0523/.vnc
ADD scripts/SunshineCloud-AutoStart.desktop /home/matrix0523/.config/autostart/SunshineCloud-AutoStart.desktop
RUN sudo chown -R matrix0523:matrix0523 /home/matrix0523/.config
RUN chmod 755 /home/matrix0523/.config /home/matrix0523/.vnc
RUN echo "# Please Use Vncpasswd to set the password,Then run the command below" >> /home/matrix0523/.bashrc
RUN echo "# vncserver :0 -geometry 1920x1080 -depth 24 -interface 127.0.0.1 -PasswordFile=/home/matrix0523/.vnc/passwd -xstartup startxfce4 -verbose" >> /home/matrix0523/.bashrc
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["sudo /usr/local/share/docker-init.sh bash -c 'sudo service supervisor start && sudo service dbus restart && sudo service xrdp start && bash'"]