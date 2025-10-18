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


build-argocd-install:
	kustomize build argocd-install/ \
		> argocd-install/build/result.yaml


install-argocd:
	kubectl apply -f argocd-install/build/result.yaml
	kubectl get pods -n argocd -o name | grep argocd-server
	# wait until ready
	ARGOCD_SERVER=$$(kubectl get pods -n argocd -o name | grep argocd-server); \
	kubectl wait \
	  --for=condition=Ready \
		-n argocd \
		--timeout=180s \
		$$ARGOCD_SERVER

show-argocd-password:
	kubectl -n argocd get secrets argocd-initial-admin-secret \
    -o jsonpath='{.data.password}' | base64 -d

install-argocd-with-build: build-argocd-install install-argocd show-argocd-password

build-root-app:
	kustomize build argocd-root-app/ \
		> argocd-root-app/build/result.yaml

install-root-app:
	kubectl apply -f argocd-root-app/build/result.yaml

install-root-app-with-build: build-root-app install-root-app

build-app-of-apps:
	kustomize build argocd-apps/ \
		> argocd-apps/build/result.yaml

