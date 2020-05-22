
docker-cargo-build-release:
	docker run -it -v "$(PWD)":/home/rust/src ekidd/rust-musl-builder cargo build --release

docker-image-build:
	docker build -t gulbrand/learning-tower-web . 

docker-inspect:
	docker run -it -v "$(PWD)":/home/rust/src ekidd/rust-musl-builder /bin/sh

docker-run-image: docker-image-build
	docker run -it -p8000:8000 gulbrand/learning-tower-web

docker-build-dev-image:
	docker build . -t gulbrand/learning-tower-web-dev -f dev/Dockerfile

docker-start-dev-container:
	docker run -it -p8000:8000 -v "$(PWD):/home/tower-web-dev-workspace" gulbrand/learning-tower-web-dev
