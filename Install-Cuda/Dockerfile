FROM sunshinecloud007/sunshinecloud-universal-desktop:step3

# 设置环境变量
ENV DEBIAN_FRONTEND=noninteractive
ENV CUDA_VERSION=12.6
ENV CUDNN_VERSION=9.3.0.75

# 更新系统并安装基础工具和编译器
RUN apt-get update && apt-get install -y \
    wget \
    gnupg2 \
    ca-certificates \
    build-essential \
    gcc \
    g++ \
    gfortran \
    cmake \
    make \
    git \
    && rm -rf /var/lib/apt/lists/*

# 添加 NVIDIA CUDA 仓库
RUN wget -O /tmp/cuda-keyring.deb \
    https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.0-1_all.deb \
    && dpkg -i /tmp/cuda-keyring.deb \
    && rm /tmp/cuda-keyring.deb

# 安装 CUDA 运行时库和开发工具
RUN apt-get update && apt-get install -y \
    cuda-libraries-12-6 \
    cuda-compiler-12-6 \
    cuda-nvcc-12-6 \
    cuda-cudart-dev-12-6 \
    cuda-nvtx-12-6 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 安装 cuDNN 运行时和开发库
RUN apt-get update && apt-get install -y \
    libcudnn9-cuda-12=${CUDNN_VERSION}-1 \
    libcudnn9-dev-cuda-12=${CUDNN_VERSION}-1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 设置 CUDA 环境变量
ENV PATH=/usr/local/cuda-12.6/bin:${PATH}
ENV LD_LIBRARY_PATH=/usr/local/cuda-12.6/lib64:${LD_LIBRARY_PATH}
ENV CUDA_HOME=/usr/local/cuda-12.6
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility

# 设置工作目录
WORKDIR /workspace

# 验证编译器安装
RUN gcc --version && \
    g++ --version && \
    nvcc --version

CMD ["/bin/bash"]
