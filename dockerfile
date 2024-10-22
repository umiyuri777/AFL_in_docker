# ベースイメージとして最新のUbuntuを使用
FROM ubuntu:latest

# 環境変数の設定
ENV DEBIAN_FRONTEND=noninteractive

# 必要なパッケージをインストール
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    gcc \
    llvm \
    git \
    wget \
    libtool \
    automake \
    autoconf \
    bison \
    flex \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# AFLのリポジトリをクローン
RUN git clone https://github.com/google/AFL.git /opt/AFL

# LLVMモード用にコンパイル
WORKDIR /opt/AFL
RUN make AFL_NO_X86=1 && make install 
    # mkdir /tmp/afl-ramdisk && chmod 777 /tmp/afl-ramdisk \
    # mount -t tmpfs -o size=512M tmpfs /tmp/afl-ramdisk \
    # cp test-instr.c /tmp/afl-ramdisk/ \
    # cd /tmp/afl-ramdisk

# afl用にコンパイル
RUN afl-gcc -O3 test-instr.c && \
    mkdir test_in && \
    echo -n 'hoge' > test_in/hello

# コンテナのデフォルトコマンドを設定（変更可能）
CMD ["bash"]
