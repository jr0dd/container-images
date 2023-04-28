FROM ghcr.io/jr0dd/ubuntu-jammy:rolling@sha256:56b8ede896366f3b29150ede8d70b7cb6f3b2b078504eba1cc8d0b59b00bf4d6

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
