.PHONY: build-fastapi build clean-image

build-fastapi:
	docker login
	docker build -t nakanoi/fastapi:latest fastapi
	docker push nakanoi/fastapi:latest

build: build-fastapi

clean-image:
	docker rmi nakanoi/fastapi:latest

