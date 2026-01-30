FROM docker.io/debian:trixie-slim

USER root

RUN set -exu \
  && mkdir -pv /usr/share/keyrings/

ADD --chmod=644 --chown=root:root https://enterprise.proxmox.com/debian/proxmox-archive-keyring-trixie.gpg /usr/share/keyrings/proxmox-archive-keyring.gpg 

COPY ./proxmox.sources /etc/apt/sources.list.d/

RUN set -exu \
  && export DEBIAN_FRONTEND=noninteractive \
  && apt-get -yq update \
  && apt-get -yq install \
    ca-certificates \
    cron \
    proxmox-backup-client \
  && apt-get -yq clean

COPY backup.sh /backup.sh

ENTRYPOINT ["proxmox-backup-client"]
