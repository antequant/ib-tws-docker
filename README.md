# ib-tws-docker
Trader Workstation in a Docker image

## Building

```sh
docker build . -t ibtwsdocker
```

## Running

```sh
docker run --rm -p 5900:5900 ibtwsdocker
```

This will expose port 5900 for VNC (with default password `1358`).
