import logging

from fastapi import FastAPI, Header
from prometheus_fastapi_instrumentator import Instrumentator
from time import sleep
from typing import Annotated

app = FastAPI()
log = logging.getLogger("uvicorn.app")
Instrumentator(
    excluded_handlers=["/metrics"],
).instrument(app).expose(app=app, endpoint="/metrics")


class EndpointFilter(logging.Filter):
    def filter(self, record: logging.LogRecord) -> bool:
        return record.args and len(record.args) >= 3 and record.args[2] != "/0"


# ignore healthcheck
logging.getLogger("uvicorn.access").addFilter(EndpointFilter())


@app.get("/{sleep_millis}")
def read_root(
    sleep_millis: int,
    host: Annotated[str | None, Header()] = None,
    forwarded: Annotated[str | None, Header()] = None,
    x_forwarded_for: Annotated[str | None, Header()] = None,
):
    if sleep_millis == 0:
        return "OK"

    sleep(sleep_millis * 0.001)
    log.info(
        """\nhost:              {}\npath           : {}\nforwarded      : {}\nx-forwarded-for: {}""".format(
            host, sleep_millis, forwarded, x_forwarded_for
        )
    )
    return {"sleep_millis": sleep_millis}
