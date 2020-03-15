#
# This is the alpine linux work with mongodb docker images dockerfile
# @author tekintian
# @url http://github.com/tekintian/alpine-mongodb
#
FROM tekintian/alpine:3.9

LABEL maintainer="TekinTian <tekintian@gmail.com>"

ENV TERM=linux

COPY entrypoint.sh /

RUN apk add --no-cache bash mongodb && \
    mkdir -p /data/db && \
    chown -R mongodb /data/db && \
    chmod +x /entrypoint.sh 

VOLUME /data/db
EXPOSE 27017

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "mongod", "--bind_ip", "0.0.0.0" ]