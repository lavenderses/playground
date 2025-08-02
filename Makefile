.PHONY: build-fastapi spring-app build clean-image

build-fastapi:
	docker login
	docker build -t nakanoi/fastapi:latest fastapi
	docker push nakanoi/fastapi:latest

build-spring-app:
	docker login
	cd spring-app; \
		./gradlew :app:jibDockerBuild
	docker push nakanoi/spring-app:latest

build: build-fastapi spring-app build-envoy

clean-image:
	docker rmi nakanoi/fastapi:latest
	docker rmi nakanoi/spring-app:latest

