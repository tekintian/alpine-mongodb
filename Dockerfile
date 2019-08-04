#
# This is the alpine linux work with mongodb docker images dockerfile
# @author tekintian
# @url http://github.com/tekintian/alpine-php
# @phpVersion  http://php.net/downloads.php
#
FROM tekintian/alpine:3.9

LABEL maintainer="TekinTian <tekintian@gmail.com>"

ENV TERM=linux

RUN apk add --no-cache bash mongodb

RUN mkdir -p /data/db && \
    chown -R mongodb /data/db

VOLUME /data/db
EXPOSE 27017

CMD [ "mongod", "--bind_ip", "0.0.0.0"]