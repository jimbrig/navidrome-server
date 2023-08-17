# Docker and Docker Compose Configuration for Navidrome

Docker images are available for the linux/amd64, linux/arm/v6, linux/arm/v7 and linux/arm64 platforms. They include everything needed to run Navidrome.

## Docker Compose

Create a `docker-compose.yml` file with the following content (or simply add the `navidrome` service to an existing `docker-compose.yml` file):

```yaml
services:
  navidrome:
    image: deluan/navidrome:latest
    user: 1000:1000 # should be owner of volumes
    ports:
      - "4533:4533"
    restart: unless-stopped
    environment:
      ND_SCANSCHEDULE: 1h
      ND_LOGLEVEL: info
      ND_SESSIONTIMEOUT: 24h
      ND_BASEURL: ""
    volumes:
      - "/path/to/data:/data"
      - "/path/to/your/music/folder:/music:ro"
```

Start the container with:

```bash
docker-compose up -d
```

Note that environment variables are used to configure Navidrome. You can find a list of all available variables in the [Configuration](./configuration.md) section of this documentation for Navidrome.

## Docker

Run [Navidrome](https://www.navidrome.org/) in a Docker container:

```bash
docker run -d \
  --name navidrome \
  --restart unless-stopped \
  --user $(id -u):$(id -g) \
  -v /path/to/music:/music \
  -v /path/to/data:/data \
  -p 4533:4533 \
  -e ND_LOGLEVEL=info \
  deluan/navidrome:latest
```

The command above will launch Navidrome in a docker container with the following configuration:

-  The base docker image used is [`deluan/navidrome`](https://hub.docker.com/r/deluan/navidrome).
-   The container will be named `navidrome`.
-   The container will restart automatically unless stopped.
-   The container will run as the current user, so that the files created in the mounted volumes will have the correct permissions.
-   The music files will be mounted from `/path/to/music` on the host to `/music` in the container.
-   The database files will be mounted from `/path/to/data` on the host to `/data` in the container.
-   The web interface will be available on port `4533` on the host.
-   The log level will be set to `info`.
