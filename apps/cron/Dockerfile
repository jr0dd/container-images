FROM ghcr.io/jr0dd/ubuntu

ARG TARGETPLATFORM

ARG VERSION

USER root

WORKDIR /app

COPY ./apps/cron/build /build

RUN \
  set -eux \
  && \
  apt-get -qq update \
  && \
  apt-get install -y \
    cl-base64 \
    cron \
    jq \
    sudo \
  && \
  apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && apt-get autoremove -y \
  && apt-get clean \
  && chown -R k8s:k8s /app \
  && chmod -R 755 /app \
  && touch /var/log/cron.log \
  && mv /build/sudoers /etc/sudoers.d/k8s \
  && chown root:root /etc/sudoers.d/* \
  && chmod 644 /etc/sudoers.d/* \
  && update-ca-certificates \
  && printf "umask %d" "${UMASK}" >> /etc/bash.bashrc \
  && \
  rm -rf \
    /tini.asc \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/cache/apt/* \
    /var/tmp/* \
    /build

USER k8s

COPY ./apps/cron/shim /shim
COPY ./apps/cron/entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
ENTRYPOINT [ "/usr/bin/tini", "--" ]

LABEL org.opencontainers.image.source https://github.com/jr0dd/container-images