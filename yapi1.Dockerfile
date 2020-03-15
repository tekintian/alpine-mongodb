#
# This is the alpine linux work with mongodb docker images dockerfile
# @author tekintian
# @url http://github.com/tekintian/alpine-mongodb
#
FROM tekintian/alpine:3.9

LABEL maintainer="TekinTian <tekintian@gmail.com>"

ENV TERM=linux

RUN set -ex; \
    apk add --no-cache bash mongodb nodejs npm git; \
	npm install -g yapi-cli --registry https://registry.npm.taobao.org; \
	npm install pm2 -g; \

RUN mkdir -p /data/db && \
    chown -R mongodb /data/db

VOLUME /data/db
EXPOSE 27017

CMD [ "mongod"]
# CMD [ "mongod", "--bind_ip", "0.0.0.0"]