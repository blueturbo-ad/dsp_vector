# 使用最新的 Vector 官方镜像
FROM  timberio/vector:0.30.0

# 将本地的配置文件复制到镜像中
COPY vector.toml /etc/vector/vector.toml

# 设置容器启动时执行的命令
CMD ["vector", "-c", "/etc/vector/vector.toml"]