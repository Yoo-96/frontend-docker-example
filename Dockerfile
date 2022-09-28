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
