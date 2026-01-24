FROM docker.io/debian:trixie-slim

USER root
  
ADD https://enterprise.proxmox.com/debian/proxmox-archive-keyring-trixie.gpg /usr/share/keyrings/proxmox-archive-keyring.gpg 

COPY ./proxmox.sources /etc/apt/sources.list.d/

RUN set -exu \
  && export DEBIAN_FRONTEND=noninteractive \
  && apt-get -yq update \
  && apt-get -yq install \
    proxmox-backup-client \
  && apt-get -yq clean

ENTRYPOINT ["proxmox-backup-client"]
