#!/bin/bash

# Docker check
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Installing..."
    
    # Update packages
    sudo apt update
    sudo apt install -y docker.io
    sudo systemctl enable docker
    sudo systemctl start docker

    echo "Docker has been installed."
else
    echo "Docker is already installed."
fi

# stupid bug on Ubuntu 24.04
OS=$(lsb_release -si 2>/dev/null || echo "Unknown")
VERSION=$(lsb_release -sr 2>/dev/null || echo "Unknown")

if [[ "$OS" == "Ubuntu" && "$VERSION" == "24.04.1" ]]; then
    echo "Detected Ubuntu 24.04.1. Adjusting AppArmor settings."
    sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0
elif [[ "$OS" == "Unknown" || "$VERSION" == "Unknown" ]]; then
    echo "Warning: Unable to fully detect OS. Please ensure compatibility manually."
fi

# Argument check
if [ -z "$1" ]; then
    TARGET_DIR="${PWD}"  # default
else
    TARGET_DIR="$1"      # provided
fi

# start
docker run --rm -v "${TARGET_DIR}:/path" zricethezav/gitleaks:latest detect --source=/path -v
