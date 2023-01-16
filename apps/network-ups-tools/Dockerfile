FROM ghcr.io/jr0dd/ubuntu-jammy:rolling@sha256:5cdccf23f206ba485ac8a27c2db5c0bec21731e859dac8184ee3b9c483172277

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
