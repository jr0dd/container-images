FROM ghcr.io/jr0dd/ubuntu:latest

ARG VERSION

ARG TARGETPLATFORM

USER root

WORKDIR /app

ENV NODE_ENV=production

RUN \
  apt-get -qq update \
  && \
  apt-get install -y \
    npm \
    git \
    gnupg \
    ca-certificates \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libc6 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libgbm1 \
    libgcc1 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
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
    lsb-release \
    wget \
    xdg-utils

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
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
  && apt-get update \
  && apt-get install -y google-chrome-stable \
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

COPY ./apps/wyoa-bot/shim/fonts /app/fonts

RUN \
  mkdir -p /usr/share/fonts/truetype/google-fonts \
  && install -m644 /app/fonts/*ttf /usr/share/fonts/truetype/google-fonts/ \
  && fc-cache -fv

USER k8s

EXPOSE 3000

COPY ./apps/wyoa-bot/shim /shim
COPY ./apps/wyoa-bot/entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]

LABEL "maintainer"="j_r0dd <jr0dd@@users.noreply.github.com>"
LABEL org.opencontainers.image.source https://github.com/jr0dd/container-images
