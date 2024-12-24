# Runs simple API with Spring Boot

## Application Overview

### Configuration

- Runs simple HTTP server with port `:7070`.

### GET /{milli_seconds}

Sleep **without** thread blocking for milli seconds specified in path variable `{milli_seconds}`.

## Runs

```shell
$ make build-spring-app
$ kubectl apply -f spirng-app/manifest.yaml
```

