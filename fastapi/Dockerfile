FROM python:3.11.11

RUN mkdir -p /home/www/app
WORKDIR /home/www/app

RUN python3 -m pip install "fastapi[standard]" "prometheus_fastapi_instrumentator"
COPY main.py /home/www/app/main.py

# https://christina04.hatenablog.com/entry/fastapi-multiprocess-mode-prometheus
RUN mkdir -p /home/www/app/metrics
ENV prometheus_multiproc_dir="./metrics"

ENTRYPOINT python3 -m uvicorn --workers 40 --host 0.0.0.0 --port 8080 main:app

