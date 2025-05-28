#!/bin/bash
echo "Deploying React app container..."
docker stop react-app-container 2>/dev/null && docker rm react-app-container 2>/dev/null
docker run -d -p 80:80 --name react-app-container react-static-app
