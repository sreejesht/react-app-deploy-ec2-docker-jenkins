#!/bin/bash

# -----------------------------------------------------------------------------
# Script Name : install_pkgs.sh
# Description : Installs Docker, Java (OpenJDK 11), and Jenkins on a Debian-based system
# Author      : Sreejesh T
# -----------------------------------------------------------------------------

set -e  # Exit immediately if a command exits with a non-zero status

echo "Starting package installation..."

# Update package index
echo "Updating package index..."
sudo apt-get update -y

# Install Java (OpenJDK 11)
echo "Installing OpenJDK 11..."
sudo apt-get install -y openjdk-11-jre

# Install Docker
echo "Installing Docker..."
sudo apt-get install -y docker.io

# Install Jenkins
echo "Setting up Jenkins repository and key..."
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "Adding Jenkins repository to sources list..."
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "Updating package index with Jenkins repository..."
sudo apt-get update -y

echo "Installing Jenkins..."
sudo apt-get install -y jenkins

# Verify installations
echo "Verifying installations..."
echo "Java version:"
java --version

echo "Jenkins version:"
jenkins --version || echo "Jenkins is installed but not yet started."

echo "Docker version:"
docker --version

echo "Package installation completed successfully."

