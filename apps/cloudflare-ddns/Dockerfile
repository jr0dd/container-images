ARG VERSION

ARG TARGETPLATFORM

FROM ghcr.io/jr0dd/cron:latest

USER root

WORKDIR /app

COPY ./apps/cloudflare-ddns/build /build

RUN \
  mv /build/cloudflare-ddns.sh /app \
  && chown -R k8s:k8s /app \
  && chmod -R 755 /app \
  && rm -rf /build

USER k8s

COPY ./apps/cloudflare-ddns/shim /shim
COPY ./apps/cloudflare-ddns/entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source https://github.com/jr0dd/container-images
