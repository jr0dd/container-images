FROM ghcr.io/jr0dd/ubuntu-jammy:rolling@sha256:517dad3f9910d8861969c4e6cca6856c67c7a8d24f2599bac421823d894e7591

ARG VERSION

ARG TARGETPLATFORM

USER root

WORKDIR /app

ENV \
  HOME=/config

RUN \
  apt-get -qq update \
  && \
  apt-get install -y \
    fontconfig \
    gconf-service \
    git \
    gnupg \
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
    xdg-utils

RUN \
  curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
  && apt-get update \
  && apt-get install -y \
    fonts-freefont-ttf \
    google-chrome-stable

COPY ./apps/puppeteer/node /app

RUN \
  curl -sL https://deb.nodesource.com/setup_18.x | bash - \
  && \
  apt-get install -y \
    nodejs \
  && npm install npm@latest \
  && npm install --omit=dev --no-audit \
  && npm install puppeteer@${VERSION} \
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

EXPOSE 4000

COPY ./apps/puppeteer/shim /shim
COPY ./apps/puppeteer/entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]

LABEL \
  org.opencontainers.image.title="Puppeteer" \
  org.opencontainers.image.source="https://github.com/puppeteer/puppeteer" \
  org.opencontainers.image.version="${VERSION}"
