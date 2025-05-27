#!/bin/bash

# -----------------------------------------------------------------------------
# Script Name : install_and_configure_git.sh
# Description : Installs Git and configures global username/email
# Author      : Sreejesh T
# -----------------------------------------------------------------------------

set -e

echo " Updating package index..."
sudo apt update

echo " Installing Git..."
sudo apt install -y git

echo " Git installed successfully:"
git --version

echo " Configuring Git global settings..."
git config --global user.name "Sreejesh T"
git config --global user.email "sreejesh.t@gmail.com"

echo " Verifying Git configuration..."
git config --global --list

echo " Git setup completed successfully for user: Sreejesh T"

