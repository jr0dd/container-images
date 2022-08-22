FROM ghcr.io/jr0dd/ubuntu-jammy:rolling@sha256:be7d116ed69c6065d58ab6d23515220641575570e04d08182399e51c24bcaebb

USER root

# hadolint ignore=DL3008,DL3015,SC2086
RUN \
  apt-get -qq update \
  && apt-get -qq install -y --no-install-recommends \
    nut-server \
  && apt-get clean \
  && rm -rf \
    /tmp/* \
    /var/lib/apt/lists/ \
    /var/tmp/*

WORKDIR /config

EXPOSE 3493

COPY ./apps/network-ups-tools/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]
