FROM alpine:latest
# FROM 027749810177.dkr.ecr.us-east-1.amazonaws.com/dsp-env:v1

WORKDIR /dsp_vector

# 安装必要的工具
RUN apk update && apk add --no-cache ca-certificates wget

# 设置环境变量
ENV VECTOR_VERSION=0.28.2

# 下载 Vector
RUN wget https://packages.timber.io/vector/$VECTOR_VERSION/vector-$VECTOR_VERSION-x86_64-unknown-linux-musl.tar.gz 
# RUN wget https://packages.timber.io/vector/0.28.2/vector-0.28.2-x86_64-unknown-linux-musl.tar.gz

# 添加 Vector 文件到容器中
ADD vector-$VECTOR_VERSION-x86_64-unknown-linux-musl.tar.gz /tmp/
# ADD vector-0.28.2-x86_64-unknown-linux-musl.tar.gz /tmp/

# 解压文件
RUN tar -xzf /tmp/vector-$VECTOR_VERSION-x86_64-unknown-linux-musl.tar.gz -C /usr/local/bin --strip-components=1
# RUN tar -xzf /tmp/vector-0.28.2-x86_64-unknown-linux-musl.tar.gz -C /usr/local/bin --strip-components=1   

# 清理临时文件
RUN rm /tmp/vector-$VECTOR_VERSION-x86_64-unknown-linux-musl.tar.gz
# RUN rm /tmp/vector-0.28.2-x86_64-unknown-linux-musl.tar.gz

#tar -xzf vector-0.28.2-x86_64-unknown-linux-musl.tar.gz -C ./vector
RUN tar -xzf vector-$VECTOR_VERSION-x86_64-unknown-linux-musl.tar.gz 
RUN  rm -rf vector-$VECTOR_VERSION-x86_64-unknown-linux-musl.tar.gz

# 验证安装
RUN ./vector/bin/vector --version

# 设置时区
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 复制 Vector 配置文件
COPY vector.toml /etc/vector/vector.toml

# 启动 Vector
CMD ["vector", "--config", "/etc/vector/vector.toml"]