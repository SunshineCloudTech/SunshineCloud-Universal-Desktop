FROM sunshinecloud007/sunshinecloud-universal-desktop
# 容器运行时的用户名
USER matrix0523
ENV MAMBA_ROOT_PREFIX=/opt/micromamba
WORKDIR /app
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git /app/stable-diffusion-webui
# 设置相关目录权限和Git安全目录
RUN sudo git config --global --add safe.directory /app/stable-diffusion-webui && \
    sudo git config --global --add safe.directory "*" && \
    git config --global --add safe.directory /app/stable-diffusion-webui && \
    git config --global --add safe.directory "*" 

# 设置Stable Diffusion Web UI/ComfyUI/Forge & Fooocus的micromamba依赖
WORKDIR /app/stable-diffusion-webui
RUN sudo git clone https://github.com/huchenlei/sd-webui-api-payload-display.git extensions/sd-webui-api-payload-display/
RUN sudo git clone https://github.com/KohakuBlueleaf/a1111-sd-webui-lycoris.git extensions/a1111-sd-webui-lycoris/
RUN sudo git clone https://github.com/Tencent/LightDiffusionFlow.git extensions/LightDiffusionFlow/
RUN sudo git clone https://github.com/ilian6806/stable-diffusion-webui-state.git extensions/stable-diffusion-webui-state/
RUN sudo git clone https://github.com/aigc-apps/sd-webui-EasyPhoto.git extensions/sd-webui-EasyPhoto/
RUN sudo git clone https://github.com/continue-revolution/sd-webui-segment-anything.git extensions/sd-webui-segment-anything/
RUN sudo git clone https://github.com/continue-revolution/sd-webui-animatediff.git extensions/sd-webui-animatediff/
RUN sudo git clone https://github.com/DominikDoom/a1111-sd-webui-tagcomplete.git extensions/a1111-sd-webui-tagcomplete/
RUN sudo git clone https://github.com/kohya-ss/sd-webui-additional-networks.git extensions/sd-webui-additional-networks/
RUN sudo git clone https://github.com/Uminosachi/sd-webui-inpaint-anything.git extensions/sd-webui-inpaint-anything/
RUN sudo git clone https://github.com/journey-ad/sd-webui-bilingual-localization.git extensions/sd-webui-bilingual-localization/
RUN sudo git clone https://github.com/hanamizuki-ai/stable-diffusion-webui-localization-zh_Hans.git extensions/stable-diffusion-webui-localization-zh_Hans/
RUN sudo git clone https://github.com/Physton/sd-webui-prompt-all-in-one.git extensions/sd-webui-prompt-all-in-one/
COPY environments/stable-diffusion-webui.yml /tmp/environments/stable-diffusion-webui.yml
RUN micromamba config set channel_priority disabled && micromamba env update -n base -f /tmp/environments/stable-diffusion-webui.yml
SHELL ["micromamba", "run", "-n", "base", "/usr/bin/bash", "-c"]
RUN pip install uv --no-cache-dir
RUN uv pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126 --no-cache-dir --system
RUN uv pip install -r requirements_versions.txt --no-cache-dir --system
RUN uv pip install pyarrow==20.0.0 --no-cache-dir --system
# 容器其他设置
RUN sudo mkdir -p /run/systemd
ADD config/* /etc/supervisor/conf.d/
RUN sudo chmod -R 755 /app && \
    sudo chown -R matrix0523:matrix0523 /app
STOPSIGNAL SIGRTMIN+3
ENTRYPOINT [ "/usr/bin/bash", "-c" ]
CMD [ "sudo /usr/local/share/docker-init.sh bash -c 'sudo service supervisor start && sudo service dbus start && bash'" ]