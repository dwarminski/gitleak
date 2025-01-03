#!/bin/bash

# Stupid bug on Ubuntu 24.04
OS=$(lsb_release -si 2>/dev/null || echo "Unknown")
VERSION=$(lsb_release -sr 2>/dev/null || echo "Unknown")

if [[ "$OS" == "Ubuntu" && "$VERSION" == "24.04" ]]; then
    sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0
fi

# Argument check
if [ -z "$1" ]; then
    TARGET_DIR="${PWD}"  # default
else
    TARGET_DIR="$1"      # provided
fi

# Start
docker run --rm -v "${TARGET_DIR}:/path" zricethezav/gitleaks:latest detect --source=/path -v
