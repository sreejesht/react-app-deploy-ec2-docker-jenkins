#!/bin/bash
echo "🚀 Deploying React app container..."

# Stop and remove existing container if it exists
docker stop react-app
docker rm react-app
# Run new container on devops-net with port 80 exposed
docker run -d --name react-app   --network devops-net   -p 80:80   react-static-app

# Confirm deployment
echo "✅ react-app container deployed and running on http://localhost:80"

