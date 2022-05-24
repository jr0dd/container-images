FROM ghcr.io/jr0dd/ubuntu:latest

ARG VERSION

ARG TARGETPLATFORM

ARG SOPS_VERSION=3.7.3

USER root

WORKDIR /app

RUN \
  --mount=type=secret,id=github_token \
  export TOKEN=$(cat /run/secrets/github_token) \
  && apt-get -qq update \
  && \
  curl -sL https://deb.nodesource.com/setup_17.x | bash - \
  && \
  apt-get install -y \
    git \
    nodejs \
  && git config --global --add safe.directory /app \
  && git clone https://jr0dd:${TOKEN}@github.com/jr0dd/wyoa-bot.git /app \
  && git checkout v${VERSION} \
  && npm install -g npm@latest \
  && npm install --omit=dev \
  && \
  curl -sL https://github.com/mozilla/sops/releases/download/v${SOPS_VERSION}/sops_${SOPS_VERSION}_amd64.deb -o sops_${SOPS_VERSION}_amd64.deb \
  && dpkg -i sops_${SOPS_VERSION}_amd64.deb \
  && \
  apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && apt-get autoremove -y \
  && apt-get clean \
  && chown -R k8s:k8s /app \
  && chmod -R 755 /app \
  && printf "umask %d" "${UMASK}" >> /etc/bash.bashrc \
  && update-ca-certificates \
  && \
  rm -rf \
    /app/*deb \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/cache/apt/* \
    /var/tmp/*

USER k8s

EXPOSE 3000

COPY ./apps/wyoa-bot/shim /shim
COPY ./apps/wyoa-bot/entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]

LABEL "maintainer"="j_r0dd <jr0dd@@users.noreply.github.com>"
LABEL org.opencontainers.image.source https://github.com/jr0dd/container-images
