.PHONY: build-fastapi build-envoy build clean-image

build-fastapi:
	docker login
	docker build -t nakanoi/fastapi:latest fastapi
	docker push nakanoi/fastapi:latest

build-envoy:
	docker login
	docker build -t nakanoi/envoy:latest envoy
	docker push nakanoi/envoy:latest

build: build-fastapi build-envoy

clean-image:
	docker rmi nakanoi/fastapi:latest
	docker rmi nakanoi/envoy:latest

