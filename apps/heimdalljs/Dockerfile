FROM ghcr.io/jr0dd/ubuntu:latest

ARG VERSION

ARG TARGETPLATFORM

ARG RELEASE
ENV \
  HOME="/app/heimdall" \
  NODE_ENV="production"

USER root

WORKDIR /app/heimdall

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN \
  apt-get -qq update \
  && \
  apt-get install -y \
    jq \
    nodejs \
    npm \
  && \
  export RELEASE=$(curl -o- \
  -fsSL "https://api.github.com/repos/linuxserver/heimdalljs/commits/master" | \
  jq -r .sha) \
  && curl -o- -fsSL "https://github.com/linuxserver/heimdalljs/archive/${RELEASE}.tar.gz" | \
  tar xzvf - --strip-components=1 \
  && npm set audit=false \
  && npm set fund=false \
  && NODE_ENV="development" npm install \
  && cp -v .env.example .env \
  && npm run build \
  && npm prune --production \
  && \
  apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && apt-get autoremove -y \
  && apt-get clean \
  && printf "umask %d" "${UMASK}" >> /etc/bash.bashrc \
  && update-ca-certificates \
  && chown -R k8s:k8s /app /config \
  && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/cache/apt/* \
    /var/tmp/*

USER k8s

EXPOSE 3000

COPY ./apps/heimdalljs/shim /shim
COPY ./apps/heimdalljs/entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source https://github.com/jr0dd/container-images
