FROM golang:1.14 as builder

ARG VERSION=2.1.0
ARG TARGETPLATFORM=linux/amd64

ENV CGO_ENABLED=0 \
    GOPATH=/go \
    GOBIN=/go/bin

WORKDIR /build

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN \
  export GOOS \
  && GOOS=$(echo ${TARGETPLATFORM} | cut -d / -f1) \
  && export GOARCH \
  && GOARCH=$(echo ${TARGETPLATFORM} | cut -d / -f2) \
  && export GOARM \
  && GOARM=$(echo ${TARGETPLATFORM} | cut -d / -f3 | cut -c2-) \
  && git clone https://github.com/rssnyder/discord-stock-ticker.git . \
  && git checkout v${VERSION} \
  && go build -o /bin/ticker


FROM ghcr.io/jr0dd/ubuntu:latest

ARG TARGETPLATFORM=linux/amd64

USER root

RUN \
  adduser stonks \
  --uid 568 \
  --group \
  --system \
  --disabled-password \
  --no-create-home

WORKDIR /app

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /bin/ticker .

RUN \
  apt-get -qq update \
  && \
  apt-get install -y \
    cl-base64 \
  && \
  apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && apt-get autoremove -y \
  && apt-get clean \
  && chown -R stonks:stonks /app \
  && chmod -R 755 /app \
  && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/cache/apt/* \
    /var/tmp/* \
  && printf "umask %d" "${UMASK}" >> /etc/bash.bashrc

USER stonks

EXPOSE 8080

COPY ./shim /shim
COPY ./entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source https://github.com/jr0dd/container-images
