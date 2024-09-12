#!/bin/bash

set -e

echo "stop old deployments"
nomad job stop -purge vector || true
# commenting this out because the token doesn't have permission yet
# nomad system gc

echo "build binary"
make build

echo "copying bin to PATH"
sudo cp ./bin/nomad-vector-logger.bin /usr/local/bin/

echo "deploying on nomad"
nomad run dev/deployment.nomad
