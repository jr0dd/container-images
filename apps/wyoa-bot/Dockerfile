FROM node:latest

WORKDIR /app

RUN \
  git clone https://github.com/jr0dd/wyoa-bot.git /app \
  && npm install package.json

COPY ./apps/wyoa-bot/config.json /entrypoint.sh

CMD ["/entrypoint.sh"]

LABEL "maintainer"="j_r0dd <jr0dd@@users.noreply.github.com>"
LABEL org.opencontainers.image.source https://github.com/jr0dd/container-images