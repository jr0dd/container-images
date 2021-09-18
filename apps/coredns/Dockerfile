FROM docker.io/golang:1.17.0-alpine as builder

ARG TARGETPLATFORM

ARG VERSION

ENV CGO_ENABLED=0 \
    GOPATH=/go \
    GOBIN=/go/bin \
    GO111MODULE=on

COPY ./apps/coredns/plugin.cfg /plugin.cfg

WORKDIR /go/src/coredns

# hadolint ignore=DL4006
RUN \
  export GOOS \
  && GOOS=$(echo ${TARGETPLATFORM} | cut -d / -f1) \
  && export GOARCH \
  && GOARCH=$(echo ${TARGETPLATFORM} | cut -d / -f2) \
  && export GOARM \
  && GOARM=$(echo ${TARGETPLATFORM} | cut -d / -f3 | cut -c2-) \
  && apk --no-cache --no-progress add ca-certificates git \
  && update-ca-certificates \
  && git clone https://github.com/coredns/coredns.git . \
  && git checkout v${VERSION}

RUN \
  go get github.com/ori-edge/k8s_gateway \
  && go generate \
  && go mod tidy \
  && go build -ldflags "-s -w -X github.com/coredns/coredns/coremain.GitCommit=$(git describe --always)" -o coredns

COPY --from=builder /go/src/coredns/coredns /coredns
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

COPY ./apps/coredns/Corefile /config/Corefile

EXPOSE 53 53/udp

CMD ["/coredns", "-conf", "/config/Corefile"]

LABEL "maintainer"="j_r0dd <jr0dd@@users.noreply.github.com>"
LABEL org.opencontainers.image.source https://github.com/jr0dd/container-images
