# [Choice] Debian version (use bullseye on local arm64/Apple Silicon): bookworm, bullseye, buster
ARG VARIANT="bookworm"
ARG CUSTOM_PACKAGE_LIST="openssl"
FROM buildpack-deps:${VARIANT}

# Set environment variables early
ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true
ENV MAMBA_ROOT_PREFIX="/opt/micromamba"
ENV PATH="/SunshineCloud/Homebrew/bin:${PATH}"
ENV HOMEBREW_PREFIX=/SunshineCloud/Homebrew
ENV HOMEBREW_CACHE=/SunshineCloud/Homebrew/cache
# Locale environment variables
ENV LANG=zh_CN.UTF-8
ENV LANGUAGE=zh_CN:en_US
ENV LC_ALL=zh_CN.UTF-8
# Flatpak environment variables
ENV XDG_DATA_DIRS="/usr/local/share:/usr/share:/var/lib/flatpak/exports/share:/home/matrix0523/.local/share/flatpak/exports/share"
ENV FLATPAK_SYSTEM_DIR="/var/lib/flatpak"
ENV FLATPAK_USER_DIR="/home/matrix0523/.local/share/flatpak"

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
        # 扩展字体支持 - Unicode和多语言字体
        fonts-noto-core fonts-noto-ui-core fonts-noto-unhinted \
        fonts-noto-color-emoji fonts-noto-cjk fonts-noto-cjk-extra \
        fonts-liberation fonts-liberation2 fonts-dejavu fonts-dejavu-extra \
        fonts-droid-fallback fonts-opensymbol \
        fonts-symbola fonts-unifont fonts-ancient-scripts \
        fonts-arphic-ukai fonts-arphic-uming fonts-wqy-microhei fonts-wqy-zenhei \
        fonts-ipafont fonts-ipafont-gothic fonts-ipafont-mincho \
        fonts-takao fonts-vlgothic fonts-hanazono \
        fonts-thai-tlwg fonts-khmeros fonts-lao fonts-sil-padauk \
        fonts-tibetan-machine fonts-indic fonts-guru fonts-guru-extra \
        fonts-gargi fonts-samyak fonts-firacode \
        # XFCE和GTK图标字体支持
        adwaita-icon-theme gnome-icon-theme hicolor-icon-theme \
        fonts-font-awesome fontconfig-config \
        bash-completion libgl1 libglib2.0-0 ffmpeg \
        # Additional packages for later use
        wget apt-transport-https jq supervisor pkgconf file tightvncpasswd \
        # Desktop environment packages
        ca-certificates crudini dbus dbus-x11 fcitx5 fcitx5-chinese-addons \
        fcitx5-pinyin firefox* fonts-arphic-ukai fonts-arphic-uming \
        fonts-noto-cjk fonts-noto-cjk-extra fonts-wqy-microhei fonts-wqy-zenhei \
        libasound2-dev libatk1.0-0 libcairo-gobject2 libgconf-2-4 \
        libgdk-pixbuf2.0-0 libglib2.0-dev libglib2.0-0 libgtk-3-0 libgtk-3-dev \
        libnss3-dev libpangocairo-1.0-0 libselinux1-dev libxrandr2 libxss1 \
        libxtst6 openssh-server pulseaudio sassc tigervnc-standalone-server \
        tigervnc-viewer tigervnc-xorg-extension uuid-runtime vim vlc \
        xautolock xfce* xinit xorgxrdp im-config \
        # XFCE panel plugins
        xfce4-pulseaudio-plugin xfce4-weather-plugin \
        xfce4-cpugraph-plugin xfce4-panel xfce4-goodies fcitx5-config-qt \
        # Audio packages
        pavucontrol ucspi-tcp gstreamer1.0-plugins-good gstreamer1.0-pulseaudio \
        gstreamer1.0-tools python3-pip x11-common zenity elementary*icon*theme* \
        # Flatpak packages
        flatpak* xdg-desktop-portal-gtk systemd systemd-sysv && \
    # Clean up in the same layer
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Configure fonts and locales
RUN echo "配置字体和区域设置..." && \
    # 配置需要的 locale
    echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    # 生成指定的区域设置
    locale-gen zh_CN.UTF-8 en_US.UTF-8 && \
    # 设置系统默认 locale 为简体中文
    echo "LANG=zh_CN.UTF-8" > /etc/default/locale && \
    echo "LANGUAGE=zh_CN:en" >> /etc/default/locale && \
    echo "LC_ALL=zh_CN.UTF-8" >> /etc/default/locale && \
    update-locale LANG=zh_CN.UTF-8 LC_ALL=zh_CN.UTF-8 && \
    # 设置默认字体配置
    echo '<?xml version="1.0"?>' > /etc/fonts/local.conf && \
    echo '<!DOCTYPE fontconfig SYSTEM "fonts.dtd">' >> /etc/fonts/local.conf && \
    echo '<fontconfig>' >> /etc/fonts/local.conf && \
    echo '  <!-- 设置默认字体 -->' >> /etc/fonts/local.conf && \
    echo '  <alias>' >> /etc/fonts/local.conf && \
    echo '    <family>serif</family>' >> /etc/fonts/local.conf && \
    echo '    <prefer>' >> /etc/fonts/local.conf && \
    echo '      <family>Noto Serif</family>' >> /etc/fonts/local.conf && \
    echo '      <family>Liberation Serif</family>' >> /etc/fonts/local.conf && \
    echo '      <family>Noto Serif CJK SC</family>' >> /etc/fonts/local.conf && \
    echo '    </prefer>' >> /etc/fonts/local.conf && \
    echo '  </alias>' >> /etc/fonts/local.conf && \
    echo '  <alias>' >> /etc/fonts/local.conf && \
    echo '    <family>sans-serif</family>' >> /etc/fonts/local.conf && \
    echo '    <prefer>' >> /etc/fonts/local.conf && \
    echo '      <family>Noto Sans</family>' >> /etc/fonts/local.conf && \
    echo '      <family>Liberation Sans</family>' >> /etc/fonts/local.conf && \
    echo '      <family>Noto Sans CJK SC</family>' >> /etc/fonts/local.conf && \
    echo '    </prefer>' >> /etc/fonts/local.conf && \
    echo '  </alias>' >> /etc/fonts/local.conf && \
    echo '  <alias>' >> /etc/fonts/local.conf && \
    echo '    <family>monospace</family>' >> /etc/fonts/local.conf && \
    echo '    <prefer>' >> /etc/fonts/local.conf && \
    echo '      <family>Fira Code</family>' >> /etc/fonts/local.conf && \
    echo '      <family>Liberation Mono</family>' >> /etc/fonts/local.conf && \
    echo '      <family>DejaVu Sans Mono</family>' >> /etc/fonts/local.conf && \
    echo '      <family>Noto Sans Mono CJK SC</family>' >> /etc/fonts/local.conf && \
    echo '    </prefer>' >> /etc/fonts/local.conf && \
    echo '  </alias>' >> /etc/fonts/local.conf && \
    echo '  <!-- Unicode字符和图标字体回退 -->' >> /etc/fonts/local.conf && \
    echo '  <alias>' >> /etc/fonts/local.conf && \
    echo '    <family>Noto Color Emoji</family>' >> /etc/fonts/local.conf && \
    echo '    <default><family>emoji</family></default>' >> /etc/fonts/local.conf && \
    echo '  </alias>' >> /etc/fonts/local.conf && \
    echo '  <!-- 确保系统图标字体优先级 -->' >> /etc/fonts/local.conf && \
    echo '  <match target="pattern">' >> /etc/fonts/local.conf && \
    echo '    <test name="family" qual="any"><string>monospace</string></test>' >> /etc/fonts/local.conf && \
    echo '    <edit name="family" mode="prepend" binding="weak">' >> /etc/fonts/local.conf && \
    echo '      <string>DejaVu Sans Mono</string>' >> /etc/fonts/local.conf && \
    echo '    </edit>' >> /etc/fonts/local.conf && \
    echo '  </match>' >> /etc/fonts/local.conf && \
    echo '  <!-- 保持系统UI字体的图标支持 -->' >> /etc/fonts/local.conf && \
    echo '  <match target="pattern">' >> /etc/fonts/local.conf && \
    echo '    <test name="family" qual="any"><string>sans-serif</string></test>' >> /etc/fonts/local.conf && \
    echo '    <edit name="family" mode="append" binding="weak">' >> /etc/fonts/local.conf && \
    echo '      <string>DejaVu Sans</string>' >> /etc/fonts/local.conf && \
    echo '    </edit>' >> /etc/fonts/local.conf && \
    echo '  </match>' >> /etc/fonts/local.conf && \
    echo '  <!-- 允许图标字体渲染 -->' >> /etc/fonts/local.conf && \
    echo '  <match target="font">' >> /etc/fonts/local.conf && \
    echo '    <test name="family" qual="any"><string>DejaVu Sans</string></test>' >> /etc/fonts/local.conf && \
    echo '    <edit name="antialias" mode="assign"><bool>true</bool></edit>' >> /etc/fonts/local.conf && \
    echo '    <edit name="hinting" mode="assign"><bool>true</bool></edit>' >> /etc/fonts/local.conf && \
    echo '    <edit name="hintstyle" mode="assign"><const>hintslight</const></edit>' >> /etc/fonts/local.conf && \
    echo '  </match>' >> /etc/fonts/local.conf && \
    echo '</fontconfig>' >> /etc/fonts/local.conf && \
    # 再次更新字体缓存
    fc-cache -fv && \
    echo "字体配置完成"

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

# Configure user locale settings
RUN echo "# Locale settings for Chinese/English support" >> /home/matrix0523/.bashrc && \
    echo "export LANG=zh_CN.UTF-8" >> /home/matrix0523/.bashrc && \
    echo "export LANGUAGE=zh_CN:en" >> /home/matrix0523/.bashrc && \
    echo "export LC_ALL=zh_CN.UTF-8" >> /home/matrix0523/.bashrc && \
    echo "# Locale settings for Chinese/English support" >> /home/Administrator/.bashrc && \
    echo "export LANG=zh_CN.UTF-8" >> /home/Administrator/.bashrc && \
    echo "export LANGUAGE=zh_CN:en" >> /home/Administrator/.bashrc && \
    echo "export LC_ALL=zh_CN.UTF-8" >> /home/Administrator/.bashrc && \
    # Copy locale settings to profile
    echo "export LANG=zh_CN.UTF-8" >> /etc/profile && \
    echo "export LANGUAGE=zh_CN:en" >> /etc/profile && \
    echo "export LC_ALL=zh_CN.UTF-8" >> /etc/profile

# Create standard user directories for all users
RUN mkdir -vp /home/Administrator/Desktop /home/Administrator/Documents /home/Administrator/Downloads \
             /home/Administrator/Music /home/Administrator/Pictures /home/Administrator/Public \
             /home/Administrator/Templates /home/Administrator/thinclient_drives /home/Administrator/Videos && \
    mkdir -vp /home/matrix0523/Desktop /home/matrix0523/Documents /home/matrix0523/Downloads \
             /home/matrix0523/Music /home/matrix0523/Pictures /home/matrix0523/Public \
             /home/matrix0523/Templates /home/matrix0523/thinclient_drives /home/matrix0523/Videos && \
    # Set ownership for Administrator directories
    chown -R Administrator:Administrator /home/Administrator/Desktop /home/Administrator/Documents \
                                        /home/Administrator/Downloads /home/Administrator/Music \
                                        /home/Administrator/Pictures /home/Administrator/Public \
                                        /home/Administrator/Templates /home/Administrator/thinclient_drives \
                                        /home/Administrator/Videos && \
    # Set ownership for matrix0523 directories
    chown -R matrix0523:matrix0523 /home/matrix0523/Desktop /home/matrix0523/Documents \
                                   /home/matrix0523/Downloads /home/matrix0523/Music \
                                   /home/matrix0523/Pictures /home/matrix0523/Public \
                                   /home/matrix0523/Templates /home/matrix0523/thinclient_drives \
                                   /home/matrix0523/Videos && \
    # Set appropriate permissions
    chmod 755 /home/Administrator/Desktop /home/Administrator/Documents /home/Administrator/Downloads \
              /home/Administrator/Music /home/Administrator/Pictures /home/Administrator/Public \
              /home/Administrator/Templates /home/Administrator/thinclient_drives /home/Administrator/Videos && \
    chmod 755 /home/matrix0523/Desktop /home/matrix0523/Documents /home/matrix0523/Downloads \
              /home/matrix0523/Music /home/matrix0523/Pictures /home/matrix0523/Public \
              /home/matrix0523/Templates /home/matrix0523/thinclient_drives /home/matrix0523/Videos

# Configure Flatpak system
RUN mkdir -p /var/lib/flatpak && \
    mkdir -p /home/matrix0523/.local/share/flatpak && \
    chown -R matrix0523:matrix0523 /home/matrix0523/.local && \
    # Initialize Flatpak system repository
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo && \
    # Set proper permissions for Flatpak
    chmod 755 /var/lib/flatpak && \
    # Allow matrix0523 user to use Flatpak system operations
    echo 'matrix0523 ALL=(ALL) NOPASSWD: /usr/bin/flatpak' >> /etc/sudoers.d/matrix0523-flatpak

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
    # curl -fsSL https://ollama.com/install.sh | sh && \
    # Install filebrowser
    curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash && \
    # Clean up
    # find /tmp -name "*ollama-linux-amd64*" -delete 2>/dev/null || true && \
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

# Configure Flatpak for matrix0523 user
USER matrix0523
RUN mkdir -p /home/matrix0523/.local/share/flatpak && \
    # Add user Flatpak repository
    flatpak --user remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo && \
    # Configure XDG environment for current session
    echo 'export XDG_DATA_DIRS="/usr/local/share:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share:$XDG_DATA_DIRS"' >> /home/matrix0523/.bashrc && \
    echo 'export PATH="$HOME/.local/share/flatpak/exports/bin:$PATH"' >> /home/matrix0523/.bashrc

# Configure fonts for matrix0523 user
RUN mkdir -p /home/matrix0523/.config/fontconfig && \
    echo '<?xml version="1.0"?>' > /home/matrix0523/.config/fontconfig/fonts.conf && \
    echo '<!DOCTYPE fontconfig SYSTEM "fonts.dtd">' >> /home/matrix0523/.config/fontconfig/fonts.conf && \
    echo '<fontconfig>' >> /home/matrix0523/.config/fontconfig/fonts.conf && \
    echo '  <!-- 用户字体偏好设置 -->' >> /home/matrix0523/.config/fontconfig/fonts.conf && \
    echo '  <match target="pattern">' >> /home/matrix0523/.config/fontconfig/fonts.conf && \
    echo '    <test qual="any" name="family"><string>serif</string></test>' >> /home/matrix0523/.config/fontconfig/fonts.conf && \
    echo '    <edit name="family" mode="prepend" binding="strong">' >> /home/matrix0523/.config/fontconfig/fonts.conf && \
    echo '      <string>Noto Serif</string>' >> /home/matrix0523/.config/fontconfig/fonts.conf && \
    echo '    </edit>' >> /home/matrix0523/.config/fontconfig/fonts.conf && \
    echo '  </match>' >> /home/matrix0523/.config/fontconfig/fonts.conf && \
    echo '  <!-- 确保UI字体正确显示图标 -->' >> /home/matrix0523/.config/fontconfig/fonts.conf && \
    echo '  <match target="pattern">' >> /home/matrix0523/.config/fontconfig/fonts.conf && \
    echo '    <test qual="any" name="family"><string>sans-serif</string></test>' >> /home/matrix0523/.config/fontconfig/fonts.conf && \
    echo '    <edit name="family" mode="prepend" binding="weak">' >> /home/matrix0523/.config/fontconfig/fonts.conf && \
    echo '      <string>DejaVu Sans</string>' >> /home/matrix0523/.config/fontconfig/fonts.conf && \
    echo '    </edit>' >> /home/matrix0523/.config/fontconfig/fonts.conf && \
    echo '  </match>' >> /home/matrix0523/.config/fontconfig/fonts.conf && \
    echo '  <!-- 保持系统UI渲染质量 -->' >> /home/matrix0523/.config/fontconfig/fonts.conf && \
    echo '  <match target="font">' >> /home/matrix0523/.config/fontconfig/fonts.conf && \
    echo '    <edit name="antialias" mode="assign"><bool>true</bool></edit>' >> /home/matrix0523/.config/fontconfig/fonts.conf && \
    echo '    <edit name="hinting" mode="assign"><bool>true</bool></edit>' >> /home/matrix0523/.config/fontconfig/fonts.conf && \
    echo '    <edit name="hintstyle" mode="assign"><const>hintslight</const></edit>' >> /home/matrix0523/.config/fontconfig/fonts.conf && \
    echo '    <edit name="rgba" mode="assign"><const>rgb</const></edit>' >> /home/matrix0523/.config/fontconfig/fonts.conf && \
    echo '  </match>' >> /home/matrix0523/.config/fontconfig/fonts.conf && \
    echo '</fontconfig>' >> /home/matrix0523/.config/fontconfig/fonts.conf && \
    chown -R matrix0523:matrix0523 /home/matrix0523/.config

# Configure XFCE notification and panel settings for proper icon display
RUN mkdir -p /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml && \
    # Configure XFCE panel without notification area
    echo '<?xml version="1.0" encoding="UTF-8"?>' > /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '<channel name="xfce4-panel" version="1.0">' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '  <property name="configver" type="int" value="2"/>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '  <property name="panels" type="array">' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '    <value type="int" value="1"/>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '    <property name="panel-1" type="empty">' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '      <property name="position" type="string" value="p=6;x=0;y=0"/>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '      <property name="length" type="uint" value="100"/>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '      <property name="position-locked" type="bool" value="true"/>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '      <property name="icon-size" type="uint" value="16"/>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '      <property name="size" type="uint" value="26"/>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '      <property name="plugin-ids" type="array">' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '        <value type="int" value="1"/>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '        <value type="int" value="2"/>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '        <value type="int" value="3"/>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '        <value type="int" value="4"/>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '        <value type="int" value="5"/>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '        <value type="int" value="6"/>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '        <value type="int" value="7"/>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '        <value type="int" value="8"/>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '        <value type="int" value="9"/>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '      </property>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '    </property>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '  </property>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '  <property name="plugins" type="empty">' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '    <property name="plugin-1" type="string" value="applicationsmenu"/>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '    <property name="plugin-2" type="string" value="tasklist"/>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '    <property name="plugin-3" type="string" value="separator">' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '      <property name="expand" type="bool" value="true"/>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '      <property name="style" type="uint" value="0"/>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '    </property>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '    <property name="plugin-4" type="string" value="systray"/>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '    <property name="plugin-5" type="string" value="pulseaudio"/>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '    <property name="plugin-6" type="string" value="weather"/>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '    <property name="plugin-7" type="string" value="cpugraph"/>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '    <property name="plugin-8" type="string" value="clock"/>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '    <property name="plugin-9" type="string" value="actions"/>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '  </property>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    echo '</channel>' >> /home/matrix0523/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    # Set proper GTK icon theme configuration
    mkdir -p /home/matrix0523/.config/gtk-3.0 && \
    echo '[Settings]' > /home/matrix0523/.config/gtk-3.0/settings.ini && \
    echo 'gtk-theme-name=Adwaita' >> /home/matrix0523/.config/gtk-3.0/settings.ini && \
    echo 'gtk-icon-theme-name=Adwaita' >> /home/matrix0523/.config/gtk-3.0/settings.ini && \
    echo 'gtk-font-name=DejaVu Sans 10' >> /home/matrix0523/.config/gtk-3.0/settings.ini && \
    echo 'gtk-cursor-theme-name=Adwaita' >> /home/matrix0523/.config/gtk-3.0/settings.ini && \
    echo 'gtk-cursor-theme-size=24' >> /home/matrix0523/.config/gtk-3.0/settings.ini && \
    echo 'gtk-toolbar-style=GTK_TOOLBAR_BOTH_HORIZ' >> /home/matrix0523/.config/gtk-3.0/settings.ini && \
    echo 'gtk-toolbar-icon-size=GTK_ICON_SIZE_SMALL_TOOLBAR' >> /home/matrix0523/.config/gtk-3.0/settings.ini && \
    echo 'gtk-button-images=1' >> /home/matrix0523/.config/gtk-3.0/settings.ini && \
    echo 'gtk-menu-images=1' >> /home/matrix0523/.config/gtk-3.0/settings.ini && \
    echo 'gtk-enable-event-sounds=1' >> /home/matrix0523/.config/gtk-3.0/settings.ini && \
    echo 'gtk-enable-input-feedback-sounds=1' >> /home/matrix0523/.config/gtk-3.0/settings.ini && \
    # Configure weather plugin with basic settings
    mkdir -p /home/matrix0523/.config/xfce4/panel && \
    echo '<?xml version="1.0" encoding="UTF-8"?>' > /home/matrix0523/.config/xfce4/panel/weather-6.rc && \
    echo '<weather>' >> /home/matrix0523/.config/xfce4/panel/weather-6.rc && \
    echo '  <location>' >> /home/matrix0523/.config/xfce4/panel/weather-6.rc && \
    echo '    <name>New York</name>' >> /home/matrix0523/.config/xfce4/panel/weather-6.rc && \
    echo '    <latitude>40.7128</latitude>' >> /home/matrix0523/.config/xfce4/panel/weather-6.rc && \
    echo '    <longitude>-74.0060</longitude>' >> /home/matrix0523/.config/xfce4/panel/weather-6.rc && \
    echo '    <timezone>America/New_York</timezone>' >> /home/matrix0523/.config/xfce4/panel/weather-6.rc && \
    echo '  </location>' >> /home/matrix0523/.config/xfce4/panel/weather-6.rc && \
    echo '  <units>' >> /home/matrix0523/.config/xfce4/panel/weather-6.rc && \
    echo '    <temperature>celsius</temperature>' >> /home/matrix0523/.config/xfce4/panel/weather-6.rc && \
    echo '    <pressure>mmhg</pressure>' >> /home/matrix0523/.config/xfce4/panel/weather-6.rc && \
    echo '    <windspeed>kmh</windspeed>' >> /home/matrix0523/.config/xfce4/panel/weather-6.rc && \
    echo '  </units>' >> /home/matrix0523/.config/xfce4/panel/weather-6.rc && \
    echo '  <refresh>' >> /home/matrix0523/.config/xfce4/panel/weather-6.rc && \
    echo '    <enabled>true</enabled>' >> /home/matrix0523/.config/xfce4/panel/weather-6.rc && \
    echo '    <interval>30</interval>' >> /home/matrix0523/.config/xfce4/panel/weather-6.rc && \
    echo '  </refresh>' >> /home/matrix0523/.config/xfce4/panel/weather-6.rc && \
    echo '</weather>' >> /home/matrix0523/.config/xfce4/panel/weather-6.rc && \
    # Configure CPU graph plugin with basic settings
    echo '<?xml version="1.0" encoding="UTF-8"?>' > /home/matrix0523/.config/xfce4/panel/cpugraph-7.rc && \
    echo '<cpugraph>' >> /home/matrix0523/.config/xfce4/panel/cpugraph-7.rc && \
    echo '  <properties>' >> /home/matrix0523/.config/xfce4/panel/cpugraph-7.rc && \
    echo '    <update-interval>1000</update-interval>' >> /home/matrix0523/.config/xfce4/panel/cpugraph-7.rc && \
    echo '    <width>40</width>' >> /home/matrix0523/.config/xfce4/panel/cpugraph-7.rc && \
    echo '    <height>20</height>' >> /home/matrix0523/.config/xfce4/panel/cpugraph-7.rc && \
    echo '    <bars>true</bars>' >> /home/matrix0523/.config/xfce4/panel/cpugraph-7.rc && \
    echo '    <border>true</border>' >> /home/matrix0523/.config/xfce4/panel/cpugraph-7.rc && \
    echo '    <frame>0</frame>' >> /home/matrix0523/.config/xfce4/panel/cpugraph-7.rc && \
    echo '    <mode>0</mode>' >> /home/matrix0523/.config/xfce4/panel/cpugraph-7.rc && \
    echo '    <color-mode>1</color-mode>' >> /home/matrix0523/.config/xfce4/panel/cpugraph-7.rc && \
    echo '    <foreground1>#0072FF</foreground1>' >> /home/matrix0523/.config/xfce4/panel/cpugraph-7.rc && \
    echo '    <foreground2>#FF7200</foreground2>' >> /home/matrix0523/.config/xfce4/panel/cpugraph-7.rc && \
    echo '    <background>#F5F5F5</background>' >> /home/matrix0523/.config/xfce4/panel/cpugraph-7.rc && \
    echo '  </properties>' >> /home/matrix0523/.config/xfce4/panel/cpugraph-7.rc && \
    echo '</cpugraph>' >> /home/matrix0523/.config/xfce4/panel/cpugraph-7.rc && \
    chown -R matrix0523:matrix0523 /home/matrix0523/.config/xfce4 /home/matrix0523/.config/gtk-3.0

USER root   
# 优化 XRDP 性能配置 - 减少连接卡顿
RUN echo "优化 XRDP 配置以提升性能..." && \
    # 备份原始配置文件
    cp /etc/xrdp/xrdp.ini /etc/xrdp/xrdp.ini.bak && \
    cp /etc/xrdp/sesman.ini /etc/xrdp/sesman.ini.bak && \
    # 优化 xrdp.ini 配置
    echo "# XRDP Performance Optimizations" >> /etc/xrdp/xrdp.ini && \
    echo "" >> /etc/xrdp/xrdp.ini && \
    # 设置编码优化
    sed -i 's/^bitmap_cache=.*/bitmap_cache=yes/' /etc/xrdp/xrdp.ini && \
    sed -i 's/^bitmap_compression=.*/bitmap_compression=yes/' /etc/xrdp/xrdp.ini && \
    sed -i 's/^bulk_compression=.*/bulk_compression=yes/' /etc/xrdp/xrdp.ini && \
    # 添加性能优化参数
    echo "# 优化网络传输" >> /etc/xrdp/xrdp.ini && \
    echo "tcp_nodelay=yes" >> /etc/xrdp/xrdp.ini && \
    echo "tcp_keepalive=yes" >> /etc/xrdp/xrdp.ini && \
    echo "use_fastpath=both" >> /etc/xrdp/xrdp.ini && \
    echo "fastpath_input=yes" >> /etc/xrdp/xrdp.ini && \
    echo "fastpath_output=yes" >> /etc/xrdp/xrdp.ini && \
    echo "" >> /etc/xrdp/xrdp.ini && \
    # 优化颜色深度和分辨率
    echo "# 显示优化" >> /etc/xrdp/xrdp.ini && \
    echo "max_bpp=32" >> /etc/xrdp/xrdp.ini && \
    echo "xserverbpp=24" >> /etc/xrdp/xrdp.ini && \
    echo "" >> /etc/xrdp/xrdp.ini && \
    # 优化缓存设置
    echo "# 缓存优化" >> /etc/xrdp/xrdp.ini && \
    echo "bitmap_cache_persist_enable=yes" >> /etc/xrdp/xrdp.ini && \
    echo "bitmap_cache_memory_limit=64000000" >> /etc/xrdp/xrdp.ini && \
    echo "" >> /etc/xrdp/xrdp.ini && \
    # 优化 sesman.ini 配置
    echo "优化会话管理器配置..." && \
    # 设置会话超时
    sed -i 's/^DisconnectedTimeLimit=.*/DisconnectedTimeLimit=0/' /etc/xrdp/sesman.ini && \
    sed -i 's/^IdleTimeLimit=.*/IdleTimeLimit=0/' /etc/xrdp/sesman.ini && \
    # 启用会话共享
    sed -i 's/^EnableUserWindowManager=.*/EnableUserWindowManager=true/' /etc/xrdp/sesman.ini
# 添加系统级性能优化
RUN echo "应用系统级性能优化..." && \
    # 优化内核参数
    echo "# XRDP 系统性能优化配置" >> /etc/sysctl.conf && \
    echo "# 网络缓冲区优化" >> /etc/sysctl.conf && \
    echo "net.core.rmem_default = 262144" >> /etc/sysctl.conf && \
    echo "net.core.rmem_max = 16777216" >> /etc/sysctl.conf && \
    echo "net.core.wmem_default = 262144" >> /etc/sysctl.conf && \
    echo "net.core.wmem_max = 16777216" >> /etc/sysctl.conf && \
    echo "" >> /etc/sysctl.conf && \
    echo "# TCP 优化" >> /etc/sysctl.conf && \
    echo "net.ipv4.tcp_rmem = 4096 87380 16777216" >> /etc/sysctl.conf && \
    echo "net.ipv4.tcp_wmem = 4096 65536 16777216" >> /etc/sysctl.conf && \
    echo "net.ipv4.tcp_congestion_control = bbr" >> /etc/sysctl.conf && \
    echo "net.ipv4.tcp_window_scaling = 1" >> /etc/sysctl.conf && \
    echo "net.ipv4.tcp_timestamps = 1" >> /etc/sysctl.conf && \
    echo "net.ipv4.tcp_sack = 1" >> /etc/sysctl.conf && \
    echo "" >> /etc/sysctl.conf && \
    echo "# 文件系统优化" >> /etc/sysctl.conf && \
    echo "fs.file-max = 2097152" >> /etc/sysctl.conf
# Copy XFCE configuration to Administrator user
USER root
RUN mkdir -p /home/Administrator/.config && \
    cp -r /home/matrix0523/.config/xfce4 /home/Administrator/.config/ && \
    cp -r /home/matrix0523/.config/gtk-3.0 /home/Administrator/.config/ && \
    cp -r /home/matrix0523/.config/fontconfig /home/Administrator/.config/ && \
    chown -R Administrator:Administrator /home/Administrator/.config

USER Administrator
RUN gtk-update-icon-cache -f /usr/share/icons/Adwaita || true && \
    gtk-update-icon-cache -f /usr/share/icons/hicolor || true

USER matrix0523
RUN gtk-update-icon-cache -f /usr/share/icons/Adwaita || true && \
    gtk-update-icon-cache -f /usr/share/icons/hicolor || true
USER root
# Create script to configure panel plugins at startup
RUN echo '#!/bin/bash' > /usr/local/bin/configure-panel-plugins.sh && \
    echo '# Script to ensure XFCE panel plugins are properly configured' >> /usr/local/bin/configure-panel-plugins.sh && \
    echo 'export DISPLAY=:0' >> /usr/local/bin/configure-panel-plugins.sh && \
    echo 'sleep 5' >> /usr/local/bin/configure-panel-plugins.sh && \
    echo '# Ensure systray plugin is enabled' >> /usr/local/bin/configure-panel-plugins.sh && \
    echo 'xfconf-query -c xfce4-panel -p /plugins/plugin-4 -s "systray" -t string 2>/dev/null || true' >> /usr/local/bin/configure-panel-plugins.sh && \
    echo '# Ensure pulseaudio plugin is enabled' >> /usr/local/bin/configure-panel-plugins.sh && \
    echo 'xfconf-query -c xfce4-panel -p /plugins/plugin-5 -s "pulseaudio" -t string 2>/dev/null || true' >> /usr/local/bin/configure-panel-plugins.sh && \
    echo '# Ensure weather plugin is enabled' >> /usr/local/bin/configure-panel-plugins.sh && \
    echo 'xfconf-query -c xfce4-panel -p /plugins/plugin-6 -s "weather" -t string 2>/dev/null || true' >> /usr/local/bin/configure-panel-plugins.sh && \
    echo '# Ensure cpugraph plugin is enabled' >> /usr/local/bin/configure-panel-plugins.sh && \
    echo 'xfconf-query -c xfce4-panel -p /plugins/plugin-7 -s "cpugraph" -t string 2>/dev/null || true' >> /usr/local/bin/configure-panel-plugins.sh && \
    echo '# Restart panel to apply changes' >> /usr/local/bin/configure-panel-plugins.sh && \
    echo 'xfce4-panel -r 2>/dev/null || true' >> /usr/local/bin/configure-panel-plugins.sh && \
    chmod +x /usr/local/bin/configure-panel-plugins.sh && \
    # Create autostart entries for both users
    mkdir -p /home/matrix0523/.config/autostart /home/Administrator/.config/autostart && \
    echo '[Desktop Entry]' > /home/matrix0523/.config/autostart/configure-panel-plugins.desktop && \
    echo 'Type=Application' >> /home/matrix0523/.config/autostart/configure-panel-plugins.desktop && \
    echo 'Name=Configure Panel Plugins' >> /home/matrix0523/.config/autostart/configure-panel-plugins.desktop && \
    echo 'Exec=/usr/local/bin/configure-panel-plugins.sh' >> /home/matrix0523/.config/autostart/configure-panel-plugins.desktop && \
    echo 'Hidden=false' >> /home/matrix0523/.config/autostart/configure-panel-plugins.desktop && \
    echo 'NoDisplay=true' >> /home/matrix0523/.config/autostart/configure-panel-plugins.desktop && \
    echo 'X-GNOME-Autostart-enabled=true' >> /home/matrix0523/.config/autostart/configure-panel-plugins.desktop && \
    cp /home/matrix0523/.config/autostart/configure-panel-plugins.desktop /home/Administrator/.config/autostart/ && \
    chown -R matrix0523:matrix0523 /home/matrix0523/.config/autostart && \
    chown -R Administrator:Administrator /home/Administrator/.config/autostart

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
    # Create welcome message for MOTD
    echo '#!/bin/sh' > /etc/update-motd.d/10-uname && \
    echo 'echo "👋 Welcome to SunshineCloud Codespaces! You are on our default image."' >> /etc/update-motd.d/10-uname && \
    echo 'echo "   - It includes runtimes and tools for Python, Node.js, Docker, and more. See the full list here: https://aka.ms/ghcs-default-image"' >> /etc/update-motd.d/10-uname && \
    echo 'echo "   - Want to use a custom image instead? Learn more here: https://aka.ms/configure-codespace"' >> /etc/update-motd.d/10-uname && \
    echo 'echo ""' >> /etc/update-motd.d/10-uname && \
    echo 'echo "🔍 To explore VS Code to its fullest, search using the Command Palette (Cmd/Ctrl + Shift + P or F1)."' >> /etc/update-motd.d/10-uname && \
    echo 'echo ""' >> /etc/update-motd.d/10-uname && \
    echo 'echo "📝 Edit away, run your app as usual, and we'"'"'ll automatically make it available for you to access."' >> /etc/update-motd.d/10-uname && \
    echo 'echo ""' >> /etc/update-motd.d/10-uname && \
    chmod +x /etc/update-motd.d/10-uname

WORKDIR /SunshineCloud/
USER matrix0523

# Download PulseAudio XRDP modules and clone repositories
ADD scripts/install-pulseaudio-xrdp-modules.sh /tmp/install-pulseaudio-xrdp-modules.sh
RUN sudo chmod +x /tmp/install-pulseaudio-xrdp-modules.sh && \
    sudo bash /tmp/install-pulseaudio-xrdp-modules.sh && \
    sudo rm -f /tmp/install-pulseaudio-xrdp-modules.sh

WORKDIR /SunshineCloud/
USER matrix0523    
    # Clone repositories with minimal depth
RUN sudo git clone --recursive https://github.com/SunshineCloudTech/SunshineCloud-Universal-Utils.git /SunshineCloud/SunshineCloud-Universal-Utils && \
    sudo git clone --recursive https://github.com/vinceliuice/WhiteSur-gtk-theme.git /SunshineCloud/WhiteSur-gtk-theme && \
    sudo git clone --recursive https://github.com/vinceliuice/WhiteSur-wallpapers.git /SunshineCloud/WhiteSur-wallpapers && \
    sudo git clone --recursive https://github.com/vinceliuice/WhiteSur-icon-theme.git /SunshineCloud/WhiteSur-icon-theme && \
    sudo bash /SunshineCloud/WhiteSur-icon-theme/install.sh && \
    # sudo bash /SunshineCloud/WhiteSur-gtk-theme/install.sh && \
    sudo bash /SunshineCloud/WhiteSur-wallpapers/install-wallpapers.sh && \
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
ADD config/*.conf /etc/supervisor/conf.d/
ADD scripts/xstartup /home/matrix0523/.vnc/xstartup
ADD scripts/SunshineCloud-AutoStart.desktop /home/matrix0523/.config/autostart/SunshineCloud-AutoStart.desktop
# 允许xrdp使用xfce4桌面
RUN echo "xfce4-session" > /home/matrix0523/.xsession && \
    chown matrix0523:matrix0523 /home/matrix0523/.xsession
RUN mkdir -vp /var/run/dbus && touch /etc/X11/Xwrapper.config && \
    cp /etc/X11/xrdp/xorg.conf /etc/X11 && \
    sed -i "s/console/anybody/g" /etc/X11/Xwrapper.config && \
    sed -i "s/xrdp\/xorg/xorg/g" /etc/xrdp/sesman.ini && \
    echo "xfce4-session" > /etc/skel/.Xclients
# 配置xrdp
RUN sed -i.bak '/^test -x \/etc\/X11\/Xsession/ s/^/#/' /etc/xrdp/startwm.sh && \
    echo "startxfce4" >> /etc/xrdp/startwm.sh
# Set final permissions and configure PulseAudio
RUN chown -R matrix0523:matrix0523 /home/matrix0523/.vnc /home/matrix0523/.config /SunshineCloud && \
    chmod +x /home/matrix0523/.vnc/xstartup /usr/bin/start-pulseaudio.sh && \
    chmod 755 /home/matrix0523/.config /home/matrix0523/.vnc && \
    # Configure PulseAudio client.conf (修复冲突配置)
    echo "# PulseAudio client configuration for SunshineCloud" > /etc/pulse/client.conf && \
    echo "# Disable autospawn to prevent conflicts" >> /etc/pulse/client.conf && \
    echo "autospawn = no" >> /etc/pulse/client.conf && \
    echo "# Use dedicated pulse server socket" >> /etc/pulse/client.conf && \
    echo "# default-server = unix:/tmp/pulse-server" >> /etc/pulse/client.conf && \
    echo "# Enable memory file descriptor for better performance" >> /etc/pulse/client.conf && \
    echo "enable-memfd = yes" >> /etc/pulse/client.conf && \
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
    echo "# PulseAudio configuration for XRDP" > /etc/xrdp/pulse/default.pa && \
    echo ".nofail" >> /etc/xrdp/pulse/default.pa && \
    echo "load-module module-augment-properties" >> /etc/xrdp/pulse/default.pa && \
    echo "load-module module-always-sink" >> /etc/xrdp/pulse/default.pa && \
    echo ".ifexists module-xrdp-sink.so" >> /etc/xrdp/pulse/default.pa && \
    echo "load-module module-xrdp-sink" >> /etc/xrdp/pulse/default.pa && \
    echo ".endif" >> /etc/xrdp/pulse/default.pa && \
    echo ".ifexists module-xrdp-source.so" >> /etc/xrdp/pulse/default.pa && \
    echo "load-module module-xrdp-source" >> /etc/xrdp/pulse/default.pa && \
    echo ".endif" >> /etc/xrdp/pulse/default.pa && \
    echo ".ifexists /SunshineCloud/SunshineCloud-PulseAudio-Modules/module-xrdp-sink.so" >> /etc/xrdp/pulse/default.pa && \
    echo "load-module /SunshineCloud/SunshineCloud-PulseAudio-Modules/module-xrdp-sink.so" >> /etc/xrdp/pulse/default.pa && \
    echo ".endif" >> /etc/xrdp/pulse/default.pa && \
    echo ".ifexists /SunshineCloud/SunshineCloud-PulseAudio-Modules/module-xrdp-source.so" >> /etc/xrdp/pulse/default.pa && \
    echo "load-module /SunshineCloud/SunshineCloud-PulseAudio-Modules/module-xrdp-source.so" >> /etc/xrdp/pulse/default.pa && \
    echo ".endif" >> /etc/xrdp/pulse/default.pa && \
    echo "load-module module-native-protocol-unix" >> /etc/xrdp/pulse/default.pa && \
    echo "load-module module-device-restore" >> /etc/xrdp/pulse/default.pa && \
    echo "load-module module-stream-restore" >> /etc/xrdp/pulse/default.pa && \
    echo "load-module module-card-restore" >> /etc/xrdp/pulse/default.pa && \
    echo "load-module module-default-device-restore" >> /etc/xrdp/pulse/default.pa && \
    echo "load-module module-position-event-sounds" >> /etc/xrdp/pulse/default.pa && \
    echo "load-module module-role-cork" >> /etc/xrdp/pulse/default.pa && \
    echo "load-module module-dbus-protocol" >> /etc/xrdp/pulse/default.pa && \
    echo ".ifexists module-esound-protocol-unix.so" >> /etc/xrdp/pulse/default.pa && \
    echo "load-module module-esound-protocol-unix" >> /etc/xrdp/pulse/default.pa && \
    echo ".endif" >> /etc/xrdp/pulse/default.pa && \
    echo "load-module module-filter-heuristics" >> /etc/xrdp/pulse/default.pa && \
    echo "# Optional: Additional socket for XRDP connections" >> /etc/xrdp/pulse/default.pa && \
    echo "load-module module-native-protocol-unix socket=/tmp/pulseaudio.socket auth-group=audio auth-anonymous=1" >> /etc/xrdp/pulse/default.pa && \
    echo "load-module module-filter-apply" >> /etc/xrdp/pulse/default.pa && \
    # Add bash configuration
    echo "# Please Use Vncpasswd to set the password,Then run the command below" >> /home/matrix0523/.bashrc && \
    echo "# vncserver :0 -geometry 1920x1080 -depth 24 -interface 127.0.0.1 -PasswordFile=/home/matrix0523/.vnc/passwd -xstartup startxfce4 -verbose" >> /home/matrix0523/.bashrc

WORKDIR /home/matrix0523
LABEL maintainer="SunshineCloudSoft"
# 清理临时文件
USER matrix0523
WORKDIR /home/matrix0523
# 暴露 MySQL 和 Redis 端口
EXPOSE 3306 6379 3389 22
EXPOSE 3306/udp 6379/udp 3389/udp 22/udp
ENTRYPOINT ["/bin/bash", "-c"]
# CMD ["sudo /usr/local/share/ssh-init.sh && sudo /usr/local/share/docker-init.sh bash -c 'sudo service supervisor start && sudo service dbus restart && sudo service xrdp start && bash'"]