FROM alpine:latest
# FROM 027749810177.dkr.ecr.us-east-1.amazonaws.com/dsp-env:v1

WORKDIR /dsp_vector

# 安装必要的工具
RUN apk update && apk add --no-cache ca-certificates wget

# 设置环境变量
ENV VECTOR_VERSION=0.28.2

# 下载和解压 Vector
RUN wget https://packages.timber.io/vector/$VECTOR_VERSION/vector-$VECTOR_VERSION-x86_64-unknown-linux-musl.tar.gz 
RUN tar -xzf vector-$VECTOR_VERSION-x86_64-unknown-linux-musl.tar.gz -C ./vector
RUN  rm -rf vector-$VECTOR_VERSION-x86_64-unknown-linux-musl.tar.gz

# 验证安装
RUN ./vector/bin/vector --version

# 设置时区
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 复制 Vector 配置文件
COPY vector.toml /etc/vector/vector.toml

# 启动 Vector
CMD ["vector", "--config", "/etc/vector/vector.toml"]