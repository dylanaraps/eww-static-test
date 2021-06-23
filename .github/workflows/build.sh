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
run export RUSTFLAGS="-Crelocation-model=static -Ctarget-feature=+crt-static"
run export CARGO_TERM_COLOR=always
run export CARGO_INCREMENTAL=0

cd /eww

for f in x11 wayland no-x11-wayland; do
    run cargo build \
        --release \
        --no-default-features \
        --features="$f" \
        --target=x86_64-unknown-linux-musl

    run mkdir -p "$f"
    run cp target/x86_64-unknown-linux-musl/release/eww "$f"
done
