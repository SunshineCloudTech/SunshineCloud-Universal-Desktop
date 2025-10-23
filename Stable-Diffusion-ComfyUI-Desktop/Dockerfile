FROM sunshinecloud007/sunshinecloud-universal-desktop
# 容器运行时的用户名
USER matrix0523
ENV MAMBA_ROOT_PREFIX=/opt/micromamba
ENV TORCH_GPU_SKIP_VERIFICATION=true
ENV FORCE_REINSTALL=true
ENV CUDA_VERSION=cu126
WORKDIR /app
RUN git clone https://github.com/comfyanonymous/ComfyUI.git /app/ComfyUI
WORKDIR /SunshineCloud/SunshineCloud-Universal-Utils/
RUN git pull --rebase
# 设置相关目录权限和Git安全目录
RUN sudo git config --global --add safe.directory /app/ComfyUI && \
    sudo git config --global --add safe.directory "*" && \
    git config --global --add safe.directory /app/ComfyUI && \
    git config --global --add safe.directory "*" 
# 设置ComfyUI的micromamba依赖
WORKDIR /app/ComfyUI
RUN sudo git clone --recursive https://github.com/AIGODLIKE/AIGODLIKE-ComfyUI-Translation.git custom_nodes/AIGODLIKE-ComfyUI-Translation/
RUN sudo git clone --recursive https://github.com/ltdrdata/ComfyUI-Manager.git custom_nodes/ComfyUI-Manager/
RUN sudo git clone --recursive https://github.com/ltdrdata/ComfyUI-Impact-Pack.git custom_nodes/ComfyUI-Impact-Pack/
RUN sudo git clone --recursive https://github.com/yolain/ComfyUI-Easy-Use.git custom_nodes/ComfyUI-Easy-Use/
RUN sudo git clone --recursive https://github.com/AIGODLIKE/AIGODLIKE-ComfyUI-Studio.git custom_nodes/AIGODLIKE-ComfyUI-Studio/
RUN sudo git clone --recursive https://github.com/Fannovel16/comfyui_controlnet_aux.git custom_nodes/comfyui_controlnet_aux/
RUN sudo git clone --recursive https://github.com/cubiq/ComfyUI_IPAdapter_plus.git custom_nodes/ComfyUI_IPAdapter_plus/
RUN sudo git clone --recursive https://github.com/Acly/comfyui-inpaint-nodes.git custom_nodes/comfyui-inpaint-nodes/
RUN sudo git clone --recursive https://github.com/Acly/comfyui-tooling-nodes.git custom_nodes/comfyui-tooling-nodes/
RUN sudo git clone --recursive https://github.com/heshengtao/comfyui_LLM_party.git custom_nodes/comfyui_LLM_party/
RUN sudo git clone --recursive https://github.com/crystian/ComfyUI-Crystools.git custom_nodes/ComfyUI-Crystools/
RUN sudo git clone --recursive https://github.com/stavsap/comfyui-ollama.git custom_nodes/comfyui-ollama/
COPY environments/ComfyUI.yml /tmp/environments/ComfyUI.yml 
RUN micromamba config set channel_priority disabled && micromamba env update -n base -f /tmp/environments/ComfyUI.yml 
SHELL ["micromamba", "run", "-n", "base", "/usr/bin/bash", "-c"]
RUN pip install uv --no-cache-dir
# RUN uv pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126 --no-cache-dir --system
RUN bash /SunshineCloud/SunshineCloud-Universal-Utils/Torch-Install-GPU/Torch-Install-GPU.sh
RUN uv pip install -r requirements.txt --no-cache-dir --system
# 容器其他设置
RUN sudo mkdir -p /run/systemd
ADD config/* /etc/supervisor/conf.d/
RUN sudo chmod -R 755 /app && \
    sudo chown -R matrix0523:matrix0523 /app
STOPSIGNAL SIGRTMIN+3
ENTRYPOINT ["/usr/bin/bash", "-c"]
CMD ["/usr/local/bin/docker-entrypoint.sh"]