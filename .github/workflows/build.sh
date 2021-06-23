#!/bin/sh

set -e 

apk add --no-cache \
    rustup \
    build-base \
    gtk+3.0-dev \
    gtk-layer-shell-dev

rustup-init -y \
    --default-toolchain nightly

export PATH=$PATH:$HOME/.cargo/bin

rustup target add x86_64-unknown-linux-musl

export RUSTFLAGS="-C target-feature=+crt-static -C link-self-contained=yes"

cargo check \
    --no-default-features \
    --features=x11 \
    --target x86_64-unknown-linux-musl

cargo check \
    --no-default-features \
    --features=wayland \
    --target x86_64-unknown-linux-musl

cargo check \
    --no-default-features \
    --features=no-x11-wayland \
    --target x86_64-unknown-linux-musl
