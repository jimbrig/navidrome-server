ARG TARGETPLATFORM
ARG VERSION
FROM ghcr.io/navidrome/navidrome:${VERSION} as source

FROM ghcr.io/ajgon/alpine:latest

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

ENV ND_DATAFOLDER=/data \
  ND_MUSICFOLDER=/music \
  ND_CONFIGFILE=/config/navidrome/navidrome.toml \
  ND_LOGLEVEL=info \
  ND_PORT=4533 \
  ND_SCANINTERVAL=1m \
  ND_SESSIONTIMEOUT=30m \
  ND_TRANSCODINGCACHESIZE=100MB

#hadolint ignore=DL3018
RUN apk --no-cache add ffmpeg taglib

COPY --from=source /app/navidrome /usr/bin/navidrome
USER 65000:65000

EXPOSE 4533
VOLUME ["/music", "/music"]

