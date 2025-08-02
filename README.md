# Envoy sandbox with

## Startup k8s

with kind.
To enable ingress with extraPortMappings, do following command.

See.
- [kind – Ingress](https://kind.sigs.k8s.io/docs/user/ingress)

```shell
$ cat <<EOF | kind create cluster --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
EOF
```

## Startup each app

See each README in sub directories.

- [Fast API](./fastapi)
- [Envoy](./envoy)
- [Monitoring](./monitoring)
  - monitors application pods with Prometheus Service Discovery. See this [diff](https://github.com/lavenderses/playground/compare/a940044364375ad73a1ba354bca2639e5f70eeee..0b4d55ab1de00e5774d01a1f7f6e4221d5afc4f5).
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

