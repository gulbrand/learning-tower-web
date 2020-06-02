docker_proxy_hostname = localhost

help:
	echo "make docker-build-dev-image to get a dev image"

docker-cargo-build-release:
	docker run -it -v "$(PWD)":/home/rust/src ekidd/rust-musl-builder cargo build --release

docker-image-build:
	docker build -t gulbrand/learning-tower-web .

docker-image-tag:
	docker image tag gulbrand/learning-tower-web $(docker_proxy_hostname):5000/gulbrand/learning-tower-web:0.2.0

docker-image-push:
	docker push $(docker_proxy_hostname):5000/gulbrand/learning-tower-web:0.2.0

docker-inspect:
	docker run -it -v "$(PWD)":/home/rust/src ekidd/rust-musl-builder /bin/sh

docker-run-image: docker-image-build
	docker run -it -p8000:8000 gulbrand/learning-tower-web

docker-build-dev-image:
	docker build . -t gulbrand/learning-tower-web-dev -f dev/Dockerfile

docker-build-web-client-image:
	docker build . -t gulbrand/learning-tower-web-client -f web-client-Dockerfile

docker-image-tag-web-client:
	docker image tag gulbrand/learning-tower-web-client $(docker_proxy_hostname):5000/gulbrand/learning-tower-web-client:0.4.0

docker-image-push-web-client:
	docker push $(docker_proxy_hostname):5000/gulbrand/learning-tower-web-client:0.4.0

docker-start-dev-container:
	docker run -it -p8000:8000 -v "$(PWD):/home/tower-web-dev-workspace" gulbrand/learning-tower-web-dev

minikube-start:
	minikube start --cache-images 

minikube-set-hyperkit-as-default:
	minikube config set driver docker
#	minikube config set driver hyperkit

minikube-dashboard:
	minikube dashboard

kubectl-show-pods:
	kubectl get pods -A

deploy:
	kubectl create deployment learning-tower-web --image=$(docker_proxy_hostname):5000/gulbrand/learning-tower-web
	kubectl expose deployment learning-tower-web --type=ClusterIP --port=8000 --target-port=8000

point-shell-at-minikube-docker:
	eval $(minikube -p minikube docker-env)

start-docker-local-registry:
	docker run -d -p 5000:5000 --restart always --name registry registry:2

connect-to-kube-pod:
	kubectl exec -it pod-name -- /bin/bash

start-service-tunnel:
	minikube service learning-tower-web --url

launch-curl-pod-and-connect:
	kubectl run curl --image=radial/busyboxplus:curl -i --tty

