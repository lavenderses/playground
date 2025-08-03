# Runs monitoring platform with Prometheus and Grafana

## Application Overview

### Configuration

- Runs prometheus on port `:9090`.
- Runs Grafana dashoboard on port `:3000`.

## Service Discovery

Prometheus finds scrape target with pod service discovery.
See the [change](https://github.com/lavenderses/playground/compare/a940044364375ad73a1ba354bca2639e5f70eeee..0b4d55ab1de00e5774d01a1f7f6e4221d5afc4f5).

Add the following annotations to make the pod findable by Prometheus.

```yaml
annotations:
  lavenderses.prometheus.io/scrape: "true"
  # target port
  lavenderses.prometheus.io/port: "8080"
  # metrics target endpoint
  lavenderses.prometheus.io/path: /metrics
```

## Runs

```shell
$ kubectl apply -f monitoring/manifest.yaml
```

