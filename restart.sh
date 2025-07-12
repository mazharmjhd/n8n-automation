#!/bin/bash
set -e

COMPOSE_DIR="/home/azhar/n8n"

cd "$COMPOSE_DIR"

docker compose down
#docker compose up -d --build
export COMPOSE_BAKE=true
docker compose up -d --build

