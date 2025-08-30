FROM docker.io/debian:trixie-slim

RUN set -exu \
  && apt-get -yq update \
  && apt-get -yq dist-upgrade \
  && apt-get -yq install \
    wget

COPY ./proxmox.sources /etc/apt/sources.list.d/

ADD https://enterprise.proxmox.com/debian/proxmox-archive-keyring-trixie.gpg /usr/share/keyrings/proxmox-archive-keyring.gpg

RUN set -exu \
  && apt-get -yq update \
  && apt-get -yq install \
    proxmox-backup-client \
  && apt-get -yq clean

ENTRYPOINT ["proxmox-backup-client"]
