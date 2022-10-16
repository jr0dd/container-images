FROM golang:1.19 as builder

ARG VERSION

ARG TARGETPLATFORM

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

FROM ghcr.io/jr0dd/ubuntu-jammy:rolling@sha256:3c7a5362f0289cbd0f409da636c2fa91b3ddf335f5f25d2ef1eb0945e27ec5a6

ARG VERSION

ARG TARGETPLATFORM

USER root

WORKDIR /app

COPY --from=builder /bin/ticker .

RUN \
  apt-get -qq update \
  && \
  apt-get install -y \
    jq \
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

EXPOSE 8080

COPY ./apps/discord-stock-ticker/shim /shim
COPY ./apps/discord-stock-ticker/entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]

LABEL \
  org.opencontainers.image.title="discord-stock-ticker" \
  org.opencontainers.image.source="https://github.com/rssnyder/discord-stock-ticker" \
  org.opencontainers.image.version="${VERSION}"
