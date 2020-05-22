FROM rust as builder
WORKDIR /usr/src/swagger-demo
COPY . .
RUN cargo install --path .

FROM debian
# RUN apt-get update && apt-get install -y extra-runtime-dependencies
COPY --from=builder /usr/local/cargo/bin/swagger-demo /usr/local/bin/swagger-demo

EXPOSE 8080

CMD ["/usr/local/bin/swagger-demo"]
