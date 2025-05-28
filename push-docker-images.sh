#!/bin/bash

# Docker image and DockerHub user info
IMAGE_NAME="react-static-app"
DOCKERHUB_USER="sreedocker911"

# DockerHub login
echo "🔐 Logging into DockerHub..."
if ! docker login; then
    echo "❌ Docker login failed. Exiting..."
    exit 1
fi

# Push to Dev repository (Public)
echo "🚀 Tagging and pushing Dev image..."
docker tag $IMAGE_NAME $DOCKERHUB_USER/react-app-dev:latest
if docker push $DOCKERHUB_USER/react-app-dev:latest; then
    echo "✅ Dev image pushed successfully."
else
    echo "❌ Failed to push Dev image."
fi

# Push to Prod repository (Private)
echo "🚀 Tagging and pushing Prod image..."
docker tag $IMAGE_NAME $DOCKERHUB_USER/react-app-prod:latest
if docker push $DOCKERHUB_USER/react-app-prod:latest; then
    echo "✅ Prod image pushed successfully."
else
    echo "❌ Failed to push Prod image."
fi

