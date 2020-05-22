
docker-cargo-build-release:
	docker run -it -v "$(PWD)":/home/rust/src ekidd/rust-musl-builder cargo build --release

docker-image-build:
	docker build -t gulbrand/learning-tower-web . 

docker-inspect:
	docker run -it -v "$(PWD)":/home/rust/src ekidd/rust-musl-builder /bin/sh

docker-run-image: docker-image-build
	docker run -it -p8000:8000 gulbrand/learning-tower-web