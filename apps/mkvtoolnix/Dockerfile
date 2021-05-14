FROM ghcr.io/jr0dd/ubuntu:latest

ARG VERSION

ARG TARGETPLATFORM

USER root

WORKDIR /build

RUN \
  apt-get -qq update \
  && \
  apt-get install -y \
    attr \
    autoconf \
    automake \
    debhelper \
    docbook-xsl \
    g++ \
    gcc \
    git \
    libboost-date-time-dev \
    libboost-dev \
    libboost-filesystem-dev \
    libboost-math-dev \
    libboost-regex-dev \
    libboost-system-dev \
    libbz2-dev \
    libcmark-dev \
    libdvdread7 \
    libflac-dev \
    libfmt-dev \
    libgtest-dev \
    liblzo2-dev \
    libmagic-dev \
    libogg-dev \
    libpcre2-8-0 \
    libpcre2-dev \
    libqt5multimedia5 \
    libvorbis-dev \
    make \
    pkg-config \
    qtbase5-dev \
    qtbase5-dev-tools \
    qtmultimedia5-dev \
    rake \
    ruby \
    xsltproc \
    zlib1g-dev


ENV HOME=/config \
    XDG_CONFIG_HOME=/config \
    XDG_DATA_HOME=/config

RUN \
  git clone https://gitlab.com/mbunkus/mkvtoolnix.git \
  && cd mkvtoolnix \
  && git submodule init \
  && git submodule update \
  && find . -name "*.png" -exec convert -strip {} \; \
  && ./autogen.sh \
  && ./configure \
    --prefix=/app \
    --disable-update-check \
  && rake -j$(nproc) install \
  && \
  strip -v /app/bin/mkv*

COPY ./apps/mkvtoolnix/build /app/.

WORKDIR /app

RUN \
  apt-get remove -y \
    attr \
    autoconf \
    automake \
    debhelper \
    docbook-xsl \
    g++ \
    gcc \
    git \
    libboost-date-time-dev \
    libboost-dev \
    libboost-filesystem-dev \
    libboost-math-dev \
    libboost-regex-dev \
    libboost-system-dev \
    libbz2-dev \
    libcmark-dev \
    libdvdread7 \
    libflac-dev \
    libfmt-dev \
    libgtest-dev \
    liblzo2-dev \
    libmagic-dev \
    libogg-dev \
    libpcre2-8-0 \
    libpcre2-dev \
    libtool \
    libvorbis-dev \
    libqt5multimedia5 \
    make \
    novnc \
    pkg-config \
    qtbase5-dev-tools \
    qtmultimedia5-dev \
    rake \
    ruby \
    xsltproc \
    zlib1g-dev \
  && \
  apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && apt-get autoremove -y \
  && apt-get clean \
  && mkdir -p /data \
  && chown -R k8s:k8s /app /config /data \
  && chmod -R 755 /app \
  && printf "umask %d" "${UMASK}" >> /etc/bash.bashrc \
  && update-ca-certificates \
  && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/cache/apt/* \
    /var/tmp/* \
    /app/share \
    /build

USER k8s

EXPOSE 5900

VOLUME ["/config"]
VOLUME ["/data"]

COPY ./apps/mkvtoolnix/shim /shim
COPY ./apps/mkvtoolnix/entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source https://github.com/jr0dd/container-images