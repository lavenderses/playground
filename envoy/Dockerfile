FROM envoyproxy/envoy:v1.25.3

ENV TZ 'Asia/Tokyo'

COPY envoy.yaml /etc/envoy/envoy.yaml

RUN chmod go+r /etc/envoy/envoy.yaml

