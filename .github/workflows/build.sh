#!/bin/sh -e

run() { printf '%s\n' "$*"; "$@"; }

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

for f in x11 wayland no-x11-wayland; do
    run cargo build \
        --no-default-features \
        --features="$f" \
        --target x86_64-unknown-linux-musl

    run mkdir -p "$f"
    run cp target/*/eww "$f"
done
