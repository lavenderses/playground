# curl

```shell
curl -v -H 'Host: envoy.lavenderses.io' "http://$(minikube ip)/123"
*   Trying 192.168.49.2:80...
* Connected to 192.168.49.2 (192.168.49.2) port 80 (#0)
> GET /123 HTTP/1.1
> Host: envoy.lavenderses.io
> User-Agent: curl/7.81.0
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Date: Sat, 21 Dec 2024 14:30:40 GMT
< Content-Type: application/json
< Content-Length: 20
< Connection: keep-alive
< x-envoy-upstream-service-time: 431
< 
* Connection #0 to host 192.168.49.2 left intact
{"sleep_millis":123}%
```

# Log

## ingress-nginx

```
$ kubectl logs -n ingress-nginx ingress-nginx-controller-bc57996ff-dcwml 
```

```
192.168.49.1 - - [21/Dec/2024:14:30:40 +0000] "GET /123 HTTP/1.1" 200 20 "-" "curl/7.81.0" 87 0.433 [default-envoy-10001] [] 10.244.0.21:10001 20 0.433 200 7fd47759fc2ecb060fc52190bab4998a
```

## Envoy

``` shell
$ kubectl logs envoy-5b7bc54445-k5tbb | tail -n 10 > logs/k8s-envoy-fastapi.log
```

```
[2024-12-21 14:29:24.631][1][warning][main] [source/server/server.cc:794] there is no configured limit to the number of allowed active connections. Set a limit via the runtime key overload.global_downstream_max_connections
===
timestamp      : 2024-12-21T14:30:39.573Z
request        : GET /123 HTTP/1.1 200
duration       : 432
upstream       : 431
x-forwarded-for: 192.168.49.1
authority      : fastapi.default.svc.cluster.local:8080
upstream host  : 10.105.151.87:8080
===
```

## Fast API

```shell
$ kubectl logs fastapi-7d5c55cb9f-clbdr | tail -n 10 >> logs/k8s-envoy-fastapi.log
```

```
$ 
INFO:     Application startup complete.
INFO:     Started server process [47]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
INFO:     
host:              fastapi.default.svc.cluster.local:8080
path           : 123
forwarded      : None
x-forwarded-for: 192.168.49.1
INFO:     10.244.0.21:38824 - "GET /123 HTTP/1.1" 200 OK
```

# Pods

## Envoy

```shell
$ kubectl describe pods envoy-5b7bc54445-k5tbb | pbcopy 
```

```yaml
Name:             envoy-5b7bc54445-k5tbb
Namespace:        default
Priority:         0
Service Account:  default
Node:             minikube/192.168.49.2
Start Time:       Sat, 21 Dec 2024 23:29:11 +0900
Labels:           app=envoy
                  pod-template-hash=5b7bc54445
Annotations:      <none>
Status:           Running
IP:               10.244.0.21
IPs:
  IP:           10.244.0.21
Controlled By:  ReplicaSet/envoy-5b7bc54445
Containers:
  envoy:
    Container ID:   docker://14eaff8efc7276e90593f57d9ced9ee50d478c23ff3a09d5f3a772286afad895
    Image:          envoyproxy/envoy:v1.25.3
    Image ID:       docker-pullable://envoyproxy/envoy@sha256:d3e82313a0cf2eb26aed2b059f986ca74de11124cf4dbe8d10a3a0142fe04650
    Ports:          9901/TCP, 10001/TCP
    Host Ports:     0/TCP, 0/TCP
    State:          Running
      Started:      Sat, 21 Dec 2024 23:29:24 +0900
    Ready:          True
    Restart Count:  0
    Environment:
      TZ:  Asia/Tokyo
    Mounts:
      /etc/envoy/ from envoy-config-volume (ro)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-7hlrz (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  envoy-config-volume:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      envoy-config
    Optional:  false
  kube-api-access-7hlrz:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  7m48s  default-scheduler  Successfully assigned default/envoy-5b7bc54445-k5tbb to minikube
  Normal  Pulling    7m48s  kubelet            Pulling image "envoyproxy/envoy:v1.25.3"
  Normal  Pulled     7m36s  kubelet            Successfully pulled image "envoyproxy/envoy:v1.25.3" in 11.849s (11.849s including waiting). Image size: 144116372 bytes.
  Normal  Created    7m36s  kubelet            Created container envoy
  Normal  Started    7m36s  kubelet            Started container envoy
```

## Fast API

```shell
$ kubectl describe pods fastapi-7d5c55cb9f-clbdr | pbcopy
```

```yaml
Name:             fastapi-7d5c55cb9f-clbdr
Namespace:        default
Priority:         0
Service Account:  default
Node:             minikube/192.168.49.2
Start Time:       Sat, 21 Dec 2024 16:40:22 +0900
Labels:           app=fastapi
                  pod-template-hash=7d5c55cb9f
Annotations:      <none>
Status:           Running
IP:               10.244.0.8
IPs:
  IP:           10.244.0.8
Controlled By:  ReplicaSet/fastapi-7d5c55cb9f
Containers:
  fastapi:
    Container ID:   docker://adcab87a1e1454436eb49eec5a5a4ec4ef1bbf9341934080f25ba385b3e19f13
    Image:          nakanoi/fastapi:latest
    Image ID:       docker-pullable://nakanoi/fastapi@sha256:adcbc5891455666684460176b39e4f7e51fea7f895bd955afe4641515571f38a
    Port:           8080/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Sat, 21 Dec 2024 16:40:27 +0900
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-2v8dm (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  kube-api-access-2v8dm:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>
```

# Service

```shell
$ kubectl get svc
```

```
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)              AGE
envoy        ClusterIP   10.109.92.132   <none>        9901/TCP,10001/TCP   36m
fastapi      ClusterIP   10.105.151.87   <none>        8080/TCP             7h25m
kubernetes   ClusterIP   10.96.0.1       <none>        443/TCP              12d
```

