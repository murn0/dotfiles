#!/usr/bin/env bash
set -e
echo "Starting docker-entrypoint.sh"

# OSの判定
if [[ "$(cat /etc/os-release)" == *"Ubuntu"* || "$(cat /etc/os-release)" == *"Debian"* ]]; then
    # UbuntuまたはDebianの場合
    apt update
    apt -y install --no-install-recommends make
elif [[ "$(cat /etc/os-release)" == *"Alpine"* ]]; then
    # Alpineの場合
    apk update
    apk add make
else
    echo "Unsupported OS."
    exit 1
fi