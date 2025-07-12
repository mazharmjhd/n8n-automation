#!/bin/bash
set -e

if [ "$USER" != "azhar" ]; then
  exit 1
fi

USER_HOME="/home/azhar"
IMAGE_NAME="n8n-python"
CONTAINER_NAME="n8n-automation"
PORT=5544

N8N_DATA_PATH="$USER_HOME/n8n-data/n8n"
DOWNLOAD_DATA_PATH="$USER_HOME/n8n-data/downloads"

if [[ -z "$N8N_DATA_PATH" || -z "$DOWNLOAD_DATA_PATH" ]]; then
  exit 1
fi

docker build -t $IMAGE_NAME .

if docker ps -a --format '{{.Names}}' | grep -q "^$CONTAINER_NAME$"; then
  docker stop $CONTAINER_NAME
  docker rm $CONTAINER_NAME
fi

mkdir -p "$N8N_DATA_PATH"
mkdir -p "$DOWNLOAD_DATA_PATH"

docker run -d \
  --name $CONTAINER_NAME \
  -p $PORT:5678 \
  -v "$N8N_DATA_PATH":/home/node/.n8n \
  -v "$DOWNLOAD_DATA_PATH":/data \
  -e N8N_BASIC_AUTH_ACTIVE=true \
  -e N8N_BASIC_AUTH_USER=daltek@gmail.com \
  -e N8N_BASIC_AUTH_PASSWORD='d@lt3ch' \
  $IMAGE_NAME

