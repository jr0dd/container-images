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
    libxrandr2 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libx11-xcb1 \
    libxcb-dri3-0 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libcups2 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0 \
    libxtst6 \
    libnss3 \
    libxss1 \
    libasound2 \
    wget

RUN \
  --mount=type=secret,id=github_token \
  export TOKEN=$(cat /run/secrets/github_token) \
  && curl -sL https://deb.nodesource.com/setup_17.x | bash - \
  && \
  apt-get install -y \
    nodejs \
  && git clone https://jr0dd:${TOKEN}@github.com/jr0dd/whalestream-bot.git /app \
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
    Poppins* \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/cache/apt/* \
    /var/tmp/*

COPY ./apps/whalestream-bot/shim/fonts /app/fonts

RUN \
  mkdir -p /usr/share/fonts/truetype/google-fonts \
  && install -m644 /app/fonts/*ttf /usr/share/fonts/truetype/google-fonts/ \
  && fc-cache -f

USER k8s

EXPOSE 3000

COPY ./apps/whalestream-bot/shim /shim
COPY ./apps/whalestream-bot/entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]

LABEL "maintainer"="j_r0dd <jr0dd@@users.noreply.github.com>"
LABEL org.opencontainers.image.source https://github.com/jr0dd/container-images
