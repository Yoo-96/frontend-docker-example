
# 如何使用Docker部署前端项目

# 简介

本文主要讲解 `macOS` 环境下，如何通过 `Docker` 进行前端项目的部署

## 示例代码

[仓库地址 - github](https://github.com/Yoo-96/frontend-docker-example)

## 安装 Docker

[macOS安装docker](https://yeasy.gitbook.io/docker_practice/install/mac)

## 编写 Dockerfile

### 添加 .dockerignore 文件

`.dockerignore` 语法与 `.gitignore` 语法一致，用于排除无关文件和目录。

```
node_modules
```

### 添加 nginx/nginx.default.conf 文件

```
server {
  listen 80;
  server_name  _;

  location / {
    root /usr/src/app/dist;
    try_files $uri $uri/ /index.html;
  }
}

```

### 添加 Dockerfile 文件

```dockerfile
# 安装 node 基础镜像
FROM node:14-alpine as builder

# 添加构建参数
ARG MODE
RUN echo ${MODE}

# 创建工作目录
RUN mkdir -p /usr/src/app

# 指定工作目录
WORKDIR /usr/src/app

# 复制项目文件到工作目录
COPY ./ ./

# 执行 npm 脚本
RUN npm config set registry https://registry.npm.taobao.org && \
yarn && \
yarn build:${MODE}

# 安装 nginx 基础镜像
FROM nginx:alpine

# 从编译阶段的中拷贝编译结果到当前镜像中
COPY --from=builder /usr/src/app /usr/src/app

# 替换 nginx 配置
RUN rm /etc/nginx/conf.d/default.conf
COPY ./nginx/nginx.default.conf /etc/nginx/conf.d/default.conf

# 对外暴露 80 端口
EXPOSE 80
```

## 部署项目

### 构建镜像

```bash
# 镜像名称: frontend-docker-example
# 版本号: v1.0"
# --build-arg MODE=test 传递arg变量

# 不带构建参数
docker build -t frontend-docker-example:v1.0 .

# 不带构建参数
docker build --build-arg MODE=test -t frontend-docker-example:v1.0 .

```

### 根据镜像运行容器

```bash
# -d: 表示在后台运行
# 8080: 宿主机端口
# 80: 为容器暴露的端口
# 本地通过 `http://localhost:8080`, 就可以访问了
docker run -d -p 8080:80 frontend-docker-example:v1.0
```

# 使用 Docker Compose 定义和运行容器

## 安装 Compose

## 添加 Compose 模板文件，`frontend-docker-example.yml`

```yaml
version: "3"
services:
  web:
    build:
      context: .
      dockerfile: Dockerfile
      args:
        MODE: test
    ports:
      - 8080:80
```

## 启动

```bash
# 启动/停止/停止并删除容器
# 启动: up, 停止: stop, 停止并删除: down
# -f: 指定使用的 Compose 模板文件
# --build: 每次启动容器前构建镜像
docker-compose -f frontend-docker-example.yml up --build
```

# Docker 常用命令

```bash
# 查看运行中的容器
docker ps

# 终止运行中的容器
docker stop ${CONTAINER_ID}

# 删除容器
docker rm ${CONTAINER_ID}

# 列出镜像
docker image ls

# 删除镜像
docker rmi ${IMAGE_ID}

# 进入容器
docker exec -it ${CONTAINER_NAME} bash

# 查看容器日志
docker logs ${CONTAINER_ID}
```

# Mac 清理 Docker 占用空间

```bash
# 再次查看空间占用
du -sh ~/Library/Containers/com.docker.docker/Data

# 删除所有停止运行的容器，所有单容器使用的虚拟网卡，所有无名称的镜像，所有构建过程的缓存内容
docker system prune

```

更多命令： [Mac 清理 Docker 占用空间](https://www.4wei.cn/archives/1002933)
