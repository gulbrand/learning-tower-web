# -*- mode: dockerfile -*-
#
# My attempt to get a rust-musl-builder working

ARG BASE_IMAGE=ekidd/rust-musl-builder:latest

FROM ${BASE_IMAGE} as builder

ADD --chown=rust:rust . ./

RUN cargo build --release

FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=builder \
    /home/rust/src/target/x86_64-unknown-linux-musl/release/learning-tower-web \
    /usr/local/bin

EXPOSE 8000

CMD ["/usr/local/bin/learning-tower-web"]
