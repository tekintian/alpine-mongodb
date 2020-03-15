#
# This is the alpine linux work with mongodb docker images dockerfile
# @author tekintian
# @url http://github.com/tekintian/alpine-mongodb
#
FROM node:12-alpine as builder

RUN set -ex; \
	sed -i -e 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apk/repositories; \
	apk update; \
	apk add --no-cache --virtual .build-deps git python make openssl tar gcc wget; \
	mkdir -p /api/vendors; \
	cd /tmp/; \
	wget -O yapi.tar.gz https://github.com/YMFE/yapi/archive/v1.8.5.tar.gz; \
	tar -zxvf yapi.tar.gz; \
	mv /tmp/yapi-1.8.5/* /api/vendors/; \
	cd /api/vendors; \
	npm install --production --registry https://registry.npm.taobao.org; \
	copy /api/vendors/config_example.json /api/vendors/config.json; \
# clear src
	rm -rf /var/cache/apk/*; \
	apk del --no-network .build-deps; \
	rm -rf /tmp/*

FROM node:12-alpine

MAINTAINER tekintian@gmail.com
ENV TZ="Asia/Shanghai" HOME="/"
WORKDIR ${HOME}
COPY --from=builder /api/vendors /api/vendors

EXPOSE 3000

ENTRYPOINT ["node"]