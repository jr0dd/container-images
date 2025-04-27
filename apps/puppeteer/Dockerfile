FROM ghcr.io/jr0dd/ubuntu-jammy:rolling@sha256:1fc54c7751037f0233943da6e8327b21d4678d96ae4d04371040efb6894c493a

ARG VERSION

ARG TARGETPLATFORM

USER root

WORKDIR /app

ENV \
  HOME=/config

RUN \
  apt -qq update \
  && apt install -y \
    git \
    gnupg

RUN \
  curl https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor >/usr/share/keyrings/chrome-keyring.gpg - \
  && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/chrome-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" \
    | tee /etc/apt/sources.list.d/google-chrome.list \
  && apt -qq update \
  && apt install -y \
    google-chrome-stable \
    fonts-ipafont-gothic \
    fonts-wqy-zenhei \
    fonts-thai-tlwg \
    fonts-kacst \
    fonts-freefont-ttf \
    libxss1

COPY ./apps/puppeteer/node /app

RUN \
  apt-get -qq update \
  && \
  curl -sL https://deb.nodesource.com/setup_20.x | bash - \
  && \
  apt-get install -y nodejs \
  && \
  apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && apt-get autoremove -y \
  && apt-get clean \
  && chown -R k8s:k8s /app \
  && chmod -R 775 /app \
  && printf "umask %d" "${UMASK}" >> /etc/bash.bashrc \
  && update-ca-certificates \
  && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/cache/apt/* \
    /var/tmp/*

USER k8s

WORKDIR /app

RUN \
  npm install --omit=dev --no-audit --no-fund \
  && npm install puppeteer@${VERSION}

EXPOSE 9222

COPY ./apps/puppeteer/shim /shim
COPY ./apps/puppeteer/entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]

LABEL \
  org.opencontainers.image.title="Puppeteer" \
  org.opencontainers.image.source="https://github.com/puppeteer/puppeteer" \
  org.opencontainers.image.version="${VERSION}"
