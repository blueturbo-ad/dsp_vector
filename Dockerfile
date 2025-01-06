FROM golang:1.23.4 AS builder
# FROM 027749810177.dkr.ecr.us-east-1.amazonaws.com/dsp-env:v1

WORKDIR /dsp_vector

# 安装必要的工具
RUN apk add --no-cache ca-certificates wget

# 下载并解压 Vector
RUN wget -qO- https://packages.timber.io/vector/0.28.X/vector-0.28.X-x86_64-unknown-linux-musl.tar.gz | tar xz -C /usr/local/bin

# 设置时区
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 复制 Vector 配置文件
COPY vector.toml /etc/vector/vector.toml

# 启动 Vector
CMD ["vector", "--config", "/etc/vector/vector.toml"]