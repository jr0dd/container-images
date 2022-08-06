FROM docker.io/golang:1.18.4 as builder

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG VERSION

ENV CGO_ENABLED=0 \
    GOPATH=/go \
    GOBIN=/go/bin \
    GO111MODULE=on

WORKDIR /build

# hadolint ignore=DL4006
RUN \
  export GOOS \
  && GOOS=$(echo ${TARGETPLATFORM} | cut -d / -f1) \
  && export GOARCH \
  && GOARCH=$(echo ${TARGETPLATFORM} | cut -d / -f2) \
  && export GOARM \
  && GOARM=$(echo ${TARGETPLATFORM} | cut -d / -f3 | cut -c2-) \
  && git clone https://github.com/coredns/coredns.git --branch v${VERSION} --depth 1 --single-branch . \
  && sed -i '/^kubernetes:kubernetes/a k8s_gateway:github.com/ori-edge/k8s_gateway' plugin.cfg

RUN \
  go get github.com/ori-edge/k8s_gateway \
  && go generate \
  && go mod tidy \
  && go build -ldflags "-s -w -X github.com/coredns/coredns/coremain.GitCommit=$(git describe --always)" -o coredns

FROM debian:stable-slim

RUN \
  apt-get update \
  && apt-get -uy upgrade \
  && apt-get -y install ca-certificates \
  && update-ca-certificates

FROM scratch

COPY --from=0 /etc/ssl/certs /etc/ssl/certs
COPY --from=builder /build/coredns .

EXPOSE 53 53/udp

ENTRYPOINT ["/coredns", "-conf", "/config/Corefile"]

LABEL \
  org.opencontainers.image.title="CoreDNS" \
  org.opencontainers.image.source="https://github.com/coredns/coredns" \
  org.opencontainers.image.version="${VERSION}"
