FROM ghcr.io/jr0dd/ubuntu:latest

ARG VERSION

ARG TARGETPLATFORM

USER root

WORKDIR /build

RUN \
  apt-get -qq update \
  && \
  apt-get install -y \
    autoconf \
    automake \
    g++ \
    gcc \
    git \
    libcurl4 \
    libqt5svg5-dev \
    libqt5xml5 \
    libtool \
    make \
    novnc \
    pkg-config \
    qtbase5-dev \
    zlib1g-dev \
    net-tools

ENV HOME=/config \
    XDG_CONFIG_HOME=/config \
    XDG_DATA_HOME=/config \
    LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/app/lib

RUN \
  git clone https://github.com/MediaArea/ZenLib.git \
  && cd ZenLib/Project/GNU/Library \
  && ./autogen.sh \
  && ./configure \
    --prefix=/app \
    --enable-shared \
  && make -j$(nproc) install

RUN \
  git clone https://github.com/MediaArea/MediaInfoLib.git \
  && cd MediaInfoLib/Project/GNU/Library \
  && ./autogen.sh \
  && ./configure \
    --prefix=/app \
    --enable-shared \
  && make -j$(nproc) install

RUN \
  git clone https://github.com/MediaArea/MediaInfo.git \
  && cd MediaInfo/Project/GNU/CLI \
  && ./autogen.sh \
  && ./configure \
    --prefix=/app \
    --enable-shared \
  && make -j$(nproc) install

RUN \
  cd MediaInfo/Project/QMake/GUI \
  && sed -i 's/usr/app/' MediaInfoQt.pro \
  && qmake \
     STATIC_LIBS=no \
     MediaInfoQt.pro \
  && make -j$(nproc) install \
  && strip -v \
    /app/bin/mediainfo* \
    /app/lib/*so*

COPY ./apps/mkvtoolnix/build /app/.

WORKDIR /app

RUN \
  apt-get remove -y \
    autoconf \
    automake \
    g++ \
    gcc \
    git \
    libtool \
    make \
    pkg-config \
    qtbase5-dev \
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
    /app/lib/pkgconfig \
    /app/include \
    /build

USER k8s

EXPOSE 5900

VOLUME ["/config"]
VOLUME ["/data"]

COPY ./apps/mediainfo/shim /shim
COPY ./apps/mediainfo/entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source https://github.com/jr0dd/container-images