# 使用基础镜像
FROM ubuntu:20.04

# 安装必要的工具和 Java
RUN apt-get update && apt-get install -y wget gnupg openjdk-11-jre-headless

# 安装 Kafka
#ENV KAFKA_VERSION=3.3.1
#ENV SCALA_VERSION=2.13

#RUN wget https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
#    tar -xzf kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
#    mv kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka && \
#    rm kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz


# 设置环境变量
ENV VECTOR_VERSION=0.28.2

# 安装 Vector
RUN wget https://packages.timber.io/vector/$VECTOR_VERSION/vector-$VECTOR_VERSION-x86_64-unknown-linux-musl.tar.gz  && \
tar -xzf vector-$VECTOR_VERSION-x86_64-unknown-linux-musl.tar.gz && \
mv vector-x86_64-unknown-linux-musl vector && \
rm vector-$VECTOR_VERSION-x86_64-unknown-linux-musl.tar.gz
# wget https://packages.timber.io/vector/0.28.2/vector-0.28.2-x86_64-unknown-linux-musl.tar.gz && \

# 创建 Vector 目录 解决vector data_dir挂载文件路径
RUN mkdir -p /var/lib/vector 
# 添加 Vector 配置文件
COPY vector.yaml /etc/vector/vector.yaml

# 暴露端口
EXPOSE 9000
#EXPOSE 9092 2181 9000

#RUN vector/bin/vector validate /etc/vector/vector.yaml

# 启动 Kafka、Zookeeper 和 Vector
CMD ["vector/bin/vector", "-c", "/etc/vector/vector.yaml"]
#CMD ["sh", "-c", "bin/zookeeper-server-start.sh config/zookeeper.properties & bin/kafka-server-start.sh config/server.properties & vector --config /etc/vector/vector.yaml"]
