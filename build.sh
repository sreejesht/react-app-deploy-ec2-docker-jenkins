#!/bin/bash
echo "Building Docker image for React app..."
docker build -t react-static-app ./devops-build
