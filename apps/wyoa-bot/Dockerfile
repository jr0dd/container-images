FROM node:latest

WORKDIR /app

RUN \
  git clone https://github.com/jr0dd/wyoa-bot.git /app \
  && npm install package.json

COPY config.json /app

CMD ["node", "index.js"]

LABEL "maintainer"="j_r0dd <jr0dd@@users.noreply.github.com>"
LABEL org.opencontainers.image.source https://github.com/jr0dd/container-images