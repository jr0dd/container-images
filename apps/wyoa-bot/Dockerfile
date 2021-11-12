FROM node:latest

ARG VERSION

ARG TARGETPLATFORM

WORKDIR /app

RUN \
  git clone https://github.com/jr0dd/wyoa-bot.git /app \
  && git checkout v${VERSION} \
  && npm install

COPY ./apps/wyoa-bot/entrypoint.sh /entrypoint.sh

CMD ["bash", "/entrypoint.sh"]

LABEL "maintainer"="j_r0dd <jr0dd@@users.noreply.github.com>"
LABEL org.opencontainers.image.source https://github.com/jr0dd/container-images
