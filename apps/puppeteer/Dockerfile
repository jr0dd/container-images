FROM ghcr.io/jr0dd/ubuntu-jammy:rolling@sha256:0f8413ca712ebae3bd582a190ba8f397dd4bd85dc634b878761c9160572003d4

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
    git \
    gnupg \
    fonts-ipafont-gothic \
    fonts-wqy-zenhei \
    fonts-thai-tlwg \
    fonts-kacst \
    fonts-freefont-ttf \
    libxss1 \
    google-chrome-stable

COPY ./apps/puppeteer/node /app

RUN \
  curl -sL https://deb.nodesource.com/setup_18.x | bash - \
  && \
  apt-get install -y \
    nodejs \
  && npm install npm@latest \
  && npm install \
    puppeteer@${VERSION} \
    chalk@latest \
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

EXPOSE 9222

COPY ./apps/puppeteer/shim /shim
COPY ./apps/puppeteer/entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]

LABEL \
  org.opencontainers.image.title="Puppeteer" \
  org.opencontainers.image.source="https://github.com/puppeteer/puppeteer" \
  org.opencontainers.image.version="${VERSION}"
