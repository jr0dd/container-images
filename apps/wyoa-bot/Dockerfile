FROM ghcr.io/jr0dd/ubuntu:latest

ARG VERSION

ARG TARGETPLATFORM

USER root

WORKDIR /app

RUN \
  apt-get -qq update \
  && \
  apt-get install -y \
    npm \
    gnupg \
    git \
    chromium-browser \
    gconf-service \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libc6 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libgcc1 \
    libgconf-2-4 \
    libgdk-pixbuf2.0-0 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libstdc++6 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    fonts-liberation \
    libnss3 \
    lsb-release \
    xdg-utils \
    wget

RUN \
  --mount=type=secret,id=github_token \
  export TOKEN=$(cat /run/secrets/github_token) \
  && curl -sL https://deb.nodesource.com/setup_17.x | bash - \
  && \
  apt-get install -y \
    nodejs \
  && git clone https://jr0dd:${TOKEN}@github.com/jr0dd/wyoa-bot.git /app \
  && git checkout v${VERSION} \
  && npm install \
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
