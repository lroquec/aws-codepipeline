#!/bin/bash
set -e

# Stop the running container (if any)
docker ps -a -q | xargs -r docker stop
docker ps -a -q | xargs -r docker rm
echo "done"
