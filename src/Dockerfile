FROM docker.io/debian:trixie-slim

USER root

RUN set -exu \
  && apt-get -yq update \
  && apt-get -yq install \
    curl

RUN set -exu \
  && curl -s -o /usr/share/keyrings/proxmox-archive-keyring.gpg https://enterprise.proxmox.com/debian/proxmox-archive-keyring-trixie.gpg

COPY ./proxmox.sources /etc/apt/sources.list.d/

RUN set -exu \
  && apt-get -yq update \
  && apt-get -yq install \
    proxmox-backup-client \
  && apt-get -yq clean

ENTRYPOINT ["proxmox-backup-client"]
