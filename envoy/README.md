# Runs Envoy proxy

## Application Overview

### Configuration

- Runs admin port on `:9901`
- Runs HTTP proxy to Fast API app on `:10001`

## Runs

```shell
$ make build-envoy
$ kubectl apply -f envoy/manifest.yaml
```

