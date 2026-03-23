FROM debian:bookworm-slim

# Mise à jour de Debian + outils de base
RUN apt-get update && apt-get install -y \
    live-build \
    curl \
    git \
    vim \
    sudo \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build