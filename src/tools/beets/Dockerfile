ARG VERSION
FROM ghcr.io/ajgon/ubuntu:jammy-20230308

WORKDIR /app
ARG VERSION
ARG CHANNEL
ENV VERSION="${VERSION}"
ENV BEETSDIR=/config
ENV TMPDIR=/tmp

COPY jellyfin.sources /etc/apt/sources.list.d/jellyfin.sources
COPY jellyfin.gpg /etc/apt/keyrings/jellyfin.gpg
