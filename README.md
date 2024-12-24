# Envoy sandbox with

## Startup k8s

```shell
# to use local image
# https://stackoverflow.com/questions/40144138/pull-a-local-image-to-run-a-pod-in-kubernetes
$ minikube start --insecure-registry
$ eval $(minikube docker-env)
```

## Startup each app

See each README in sub directories.

- [Fast API](./fastapi)
- [Envoy](./envoy)
- [Monitoring](./monitoring)
- [Spring Boot App](./spring-app)

## Attack

```shell
$ vegeta attack -duration=60s -targets=attack.txt -rate=40 | tee results.bin | vegeta report
```

## Cleanup

```shell
$ minikube stop
$ minikube remove # to remove all resources
```

