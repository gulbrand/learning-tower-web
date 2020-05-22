# -*- mode: dockerfile -*-
#
# My attempt to get a rust-musl-builder working

ARG BASE_IMAGE=rust:buster

FROM ${BASE_IMAGE} as builder

EXPOSE 8000

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

CMD ["/bin/bash"]
