#!/bin/bash
set -e
# Pull the Docker image from Docker Hub
docker pull lroquec/cicd-tests:latest

# Run the Docker image as a container
docker run --name myapp -d -p 5000:5000 lroquec/cicd-tests:latest
