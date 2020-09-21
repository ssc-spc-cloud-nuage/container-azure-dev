#!/usr/bin/env bash
#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------

# Syntax: ./terraform-debian.sh <terraform version> [tflint version]

TERRAFORM_VERSION=$1
# TFLINT_VERSION=${2:-"none"}

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run a root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# Install update, software-properties-common if missing
if ! dpkg -s wget software-properties-common > /dev/null 2>&1; then
    export DEBIAN_FRONTEND=noninteractive
    if [ ! -d "/var/lib/apt/lists" ] || [ "$(ls /var/lib/apt/lists/ | wc -l)" = "0" ]; then
        apt-get update
    fi
    apt-get -y install --no-install-recommends wget software-properties-common
fi

# Install powershell 7
echo "Installing Powershell..."
# Download the Microsoft repository GPG keys
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb \
# Register the Microsoft repository GPG keys
dpkg -i packages-microsoft-prod.deb
# Update the list of products
apt-get update
# Enable the "universe" repositories
add-apt-repository universe
# Install PowerShell
apt-get install -y powershell
rm packages-microsoft-prod.deb
echo "Done!"