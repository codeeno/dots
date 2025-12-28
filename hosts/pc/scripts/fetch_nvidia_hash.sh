#!/bin/bash

INSTALLED_DRIVER_VERSION=$(nvidia-smi --query-gpu=driver_version --format=csv,noheader)
if [ -z "$INSTALLED_DRIVER_VERSION" ]; then
  echo "Failed to get Nvidia driver version."
  exit 1
fi

echo "Installed Nvidia driver version: $INSTALLED_DRIVER_VERSION"

OUTPUT=$(nix store prefetch-file \
  "https://download.nvidia.com/XFree86/Linux-x86_64/${INSTALLED_DRIVER_VERSION}/NVIDIA-Linux-x86_64-${INSTALLED_DRIVER_VERSION}.run" --json)

if [ $? -ne 0 ]; then
  echo "Failed to prefetch file."
  exit 1
fi

HASH=$(echo "$OUTPUT" | jq -r .hash)
if [ -z "$HASH" ]; then
  echo "Failed to parse hash from output."
  exit 1
fi

printf "Put these into your Nix config:\n"
echo "Version: $INSTALLED_DRIVER_VERSION"
echo "Sha256: $HASH"
