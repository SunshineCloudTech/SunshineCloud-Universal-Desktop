FROM sunshinecloud007/sunshinecloud-universal-desktop
# 容器运行时的用户名
USER matrix0523
ENV MAMBA_ROOT_PREFIX=/opt/micromamba
WORKDIR /app
RUN git clone https://github.com/lllyasviel/stable-diffusion-webui-forge.git /app/stable-diffusion-webui-forge
# 设置相关目录权限和Git安全目录
RUN sudo git config --global --add safe.directory /app/stable-diffusion-webui-forge && \
    sudo git config --global --add safe.directory "*" && \
    git config --global --add safe.directory /app/stable-diffusion-webui-forge && \
    git config --global --add safe.directory "*" 
# 设置Stable Diffusion WebUI Forge的micromamba依赖
WORKDIR /app/stable-diffusion-webui-forge
RUN sudo git clone https://github.com/ilian6806/stable-diffusion-webui-state.git extensions/stable-diffusion-webui-state/
RUN sudo git clone https://github.com/journey-ad/sd-webui-bilingual-localization.git extensions/sd-webui-bilingual-localization/
RUN sudo git clone https://github.com/hanamizuki-ai/stable-diffusion-webui-localization-zh_Hans.git extensions/stable-diffusion-webui-localization-zh_Hans/
RUN sudo git clone https://github.com/Physton/sd-webui-prompt-all-in-one.git extensions/sd-webui-prompt-all-in-one/
COPY environments/stable-diffusion-webui-forge.yml /tmp/environments/stable-diffusion-webui-forge.yml
RUN micromamba config set channel_priority disabled && micromamba env update -n base -f /tmp/environments/stable-diffusion-webui-forge.yml
SHELL ["micromamba", "run", "-n", "base", "/usr/bin/bash", "-c"]
RUN pip install uv --no-cache-dir
RUN uv pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126 --no-cache-dir --system
RUN uv pip install -r requirements_versions.txt --no-cache-dir --system
# 容器其他设置
RUN sudo mkdir -p /run/systemd
ADD config/* /etc/supervisor/conf.d/
RUN sudo chmod -R 755 /app && \
    sudo chown -R matrix0523:matrix0523 /app
STOPSIGNAL SIGRTMIN+3
ENTRYPOINT [ "/usr/bin/bash", "-c" ]
CMD [ "sudo /usr/local/share/docker-init.sh bash -c 'sudo service supervisor start && sudo service dbus start && bash'" ]