#!/bin/sh

run() { printf '%s\n' "$*"; "$@"; }

set -e 

run apk add --no-cache \
    rustup \
    build-base \
    gtk+3.0-dev \
    gtk-layer-shell-dev

run rustup-init -y \
    --default-toolchain nightly

run export PATH=$PATH:$HOME/.cargo/bin
run export RUSTFLAGS="-C target-feature=+crt-static -C link-self-contained=yes"
run export CARGO_TERM_COLOR=always

cd /eww

run cargo check \
    --no-default-features \
    --features=x11 \
    --target x86_64-unknown-linux-musl

run cargo check \
    --no-default-features \
    --features=wayland \
    --target x86_64-unknown-linux-musl

run cargo check \
    --no-default-features \
    --features=no-x11-wayland \
    --target x86_64-unknown-linux-musl
