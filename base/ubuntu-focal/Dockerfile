ARG VERSION

FROM ubuntu:${VERSION}

ARG VERSION
ARG TARGETPLATFORM
ENV TARGETPLATFORM=${TARGETPLATFORM:-linux/amd64}

# renovate: datasource=github-releases depName=yelp/dumb-init
ARG DUMBINIT_VERSION=1.2.5

USER root

# DEBIAN_FRONTEND: https://askubuntu.com/questions/972516/debian-frontend-environment-variable
# APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE: http://stackoverflow.com/questions/48162574/ddg#4946262
ENV \
  VERSION="${VERSION}" \
  DEBCONF_NONINTERACTIVE_SEEN=true \
  DEBIAN_FRONTEND="noninteractive" \
  APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn \
  UMASK=0002

RUN \
  adduser k8s \
  --uid 568 \
  --group \
  --system \
  --disabled-password \
  --no-create-home \
  && \
  mkdir -p /config \
  && chown -R k8s:k8s /config \
  && chmod -R 775 /config

WORKDIR /app

RUN \
  set -eux \
  && echo 'APT::Install-Recommends "false";' >/etc/apt/apt.conf.d/00recommends \
  && echo 'APT::Install-Suggests "false";' >>/etc/apt/apt.conf.d/00recommends \
  && echo 'APT::Get::Install-Recommends "false";' >>/etc/apt/apt.conf.d/00recommends \
  && echo 'APT::Get::Install-Suggests "false";' >>/etc/apt/apt.conf.d/00recommends \
  && \
  apt-get -qq update \
  && \
  apt-get install -y \
    bash \
    ca-certificates \
    curl \
    dnsutils \
    jq \
    locales \
    tzdata \
    vim-tiny \
  && \
  curl -sL https://github.com/Yelp/dumb-init/releases/download/v${DUMBINIT_VERSION}/dumb-init_${DUMBINIT_VERSION}_amd64.deb -o /tmp/dumb-init.deb\
  && dpkg -i /tmp/dumb-init.deb \
  && \
  localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
  && \
  ln -sf /usr/bin/vim.tiny /usr/local/bin/vi \
  && ln -sf /usr/bin/vim.tiny /usr/local/bin/vim \
  && ln -sf /usr/bin/vim.tiny /usr/local/bin/nano \
  && ln -sf /usr/bin/vim.tiny /usr/local/bin/emacs \
  && chown -R k8s:k8s /app \
  && \
  echo "/bin/bash /shim/greeting.sh\n" >> /etc/bash.bashrc \
  && \
  apt-get remove -y jq \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && apt-get autoremove -y \
  && apt-get clean \
  && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/cache/apt/* \
    /var/tmp/*

ENV LANG en_US.UTF-8

USER k8s

VOLUME [ "/config" ]

COPY ./base/ubuntu-focal/shim /shim
ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]

LABEL \
  org.opencontainers.image.base.name="ghcr.io/jr0dd/ubuntu-focal" \
  org.opencontainers.image.base.version="${VERSION}" \
  org.opencontainers.image.authors="j_r0dd <jr0dd@@users.noreply.github.com>"
