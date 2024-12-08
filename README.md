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
