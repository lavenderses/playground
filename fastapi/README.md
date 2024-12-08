# Runs simple API with Fast API

## Application Overview

### Configuration

- Runs simple HTTP server with port `:8080`.

### GET /{milli_seconds}

Sleep with thread blocking for milli seconds specified in path variable `{milli_seconds}`.

## Runs

```shell
$ make build-fastapi
$ kubectl apply -f manifest/fastapi.yaml
```

