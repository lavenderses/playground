# Envoy sandbox with

## Startup

```shell
$ d compose up
```

## Restart

```shell
$ d compose restart envoy
```

## Attack

```shell
$ vegeta attack -duration=60s -targets=attack.txt -rate=40 | tee results.bin | vegeta report
```

## Cleanup

```shell
$ d compose down
$ d rmi envoy-web envoy-envoy
```

## Startup k8s

```shell
# to use local image
# https://stackoverflow.com/questions/40144138/pull-a-local-image-to-run-a-pod-in-kubernetes
$ minikube start --insecure-registry
$ eval $(minikube docker-env)
```

## Startup each app

See each README in sub directories.

- [Fast API](./fastapi/README.md)
- [envoy](./envoy/README.md)
