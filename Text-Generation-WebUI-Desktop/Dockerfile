FROM sunshinecloud007/sunshinecloud-universal-desktop
# 容器运行时的用户名
USER matrix0523
ENV MAMBA_ROOT_PREFIX=/opt/micromamba
ENV TORCH_GPU_SKIP_VERIFICATION=true
ENV FORCE_REINSTALL=true
ENV INSTALL_CUDA_VERSION=cu126
WORKDIR /app
RUN git clone https://github.com/oobabooga/text-generation-webui.git /app/text-generation-webui
WORKDIR /SunshineCloud/SunshineCloud-Universal-Utils/
RUN git pull --rebase
# 设置相关目录权限和Git安全目录
RUN sudo git config --global --add safe.directory /app/text-generation-webui && \
    sudo git config --global --add safe.directory "*" && \
    git config --global --add safe.directory /app/text-generation-webui && \
    git config --global --add safe.directory "*" 
# 设置text-generation-webui的micromamba依赖
WORKDIR /app/text-generation-webui
COPY environments/text-generation-webui.yml /tmp/environments/text-generation-webui.yml 
RUN micromamba config set channel_priority disabled && micromamba env update -n base -f /tmp/environments/text-generation-webui.yml 
SHELL ["micromamba", "run", "-n", "base", "/usr/bin/bash", "-c"]
RUN pip install uv --no-cache-dir
# RUN uv pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126 --no-cache-dir --system
RUN bash /SunshineCloud/SunshineCloud-Universal-Utils/Torch-Install-GPU/Torch-Install-GPU.sh
RUN uv pip install -r requirements/full/requirements.txt --no-cache-dir --system
# 容器其他设置
RUN sudo mkdir -p /run/systemd
ADD config/* /etc/supervisor/conf.d/
RUN sudo chmod -R 755 /app && \
    sudo chown -R matrix0523:matrix0523 /app
STOPSIGNAL SIGRTMIN+3
ENTRYPOINT ["/usr/bin/bash", "-c"]
CMD ["/usr/local/bin/docker-entrypoint.sh"]