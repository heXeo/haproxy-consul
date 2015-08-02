FROM alpine:3.2

RUN apk add --update \
    --repository http://dl-4.alpinelinux.org/alpine/edge/testing \
    --repository http://dl-4.alpinelinux.org/alpine/edge/main \
    haproxy s6 curl incron && \
  curl -sSL https://github.com/hashicorp/consul-template/releases/download/v0.10.0/consul-template_0.10.0_linux_amd64.tar.gz | tar -xz && \
  mv /consul-template_0.10.0_linux_amd64/consul-template /usr/local/bin/ && \
  apk del curl && \
  rm -rf /var/cache/apk/* \
    /usr/share/man /tmp/* \
    /consul-template_0.10.0_linux_amd64

COPY files/etc /etc

EXPOSE 80
EXPOSE 443
EXPOSE 1936

ENV CONSUL_HOST consul:8500

ENTRYPOINT [ "/usr/bin/s6-svscan", "/etc/s6" ]
CMD []
