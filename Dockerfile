FROM alpine:3.6

ENV VER=4.40.1
ENV PORT=8080
ENV DOMAIN=
ENV UUID=91cb66ba-a373-43a0-8169-33d4eeaeb857
ENV PROTO=vless

RUN apk add --no-cache curl; cd /root && mkdir /v2ray \
  && curl -OsL https://github.com/xiaokaixuan/v2ray-heroku/releases/download/v$VER/v2ray-linux-64.zip \
  && unzip v2ray-linux-64.zip -d /v2ray \
  && cd /v2ray && chmod a+x v2ray v2ctl \
  && rm -rf /root/v2ray-linux-64.zip

COPY entrypoint.sh /root/
RUN chmod a+x /root/entrypoint.sh

CMD exec /root/entrypoint.sh

