FROM builder:ED0C6428 as builder


FROM alpine:latest

ENV TZ=Asia/Shanghai

COPY --from=builder /v2ray-linux-amd64 /usr/bin/v2ray

RUN set -ex && \
    apk --no-cache add ca-certificates && \
    mkdir /var/log/v2ray/ &&\
    mkdir /etc/v2ray/ &&\
    chmod +x /usr/bin/v2ray/v2ray && \
    touch /etc/v2ray/config.json

ENV PATH /usr/bin/v2ray:$PATH

CMD ["/usr/bin/v2ray/v2ray", "-config=/etc/v2ray/config.json"]
