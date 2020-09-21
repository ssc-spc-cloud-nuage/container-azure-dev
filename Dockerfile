#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------

# Pick any base image, but if you select node, skip installing node. 😊
FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu-18.04
# FROM ubuntu:18.04

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Terraform and tflint versions
ARG TERRAFORM_VERSION=0.12.29
ARG TFLINT_VERSION=0.19.1

# This Dockerfile adds a non-root user with sudo access. Use the "remoteUser"
# property in devcontainer.json to use it. On Linux, the container user's GID/UIDs
# will be updated to match your local UID/GID (when using the dockerFile property).
# See https://aka.ms/vscode-remote/containers/non-root-user for details.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
# [Option] Install Powershell 7
ARG INSTALL_POWERSHELL="false"

COPY library-scripts/*.sh /tmp/library-scripts/

# Configure apt and install packages
RUN apt-get update \
    && /bin/bash /tmp/library-scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" \
    && bash /tmp/library-scripts/azcli-debian.sh \
    # Terraform, tflint
    && bash /tmp/library-scripts/terraform-debian.sh "${TERRAFORM_VERSION}" "${TFLINT_VERSION}" \
    #
    # Install graphviz
    #
    && apt-get install -y graphviz \
    #
    # Install tmux
    #
    && apt-get install -y tmux \
    #
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

    # Powershell 7
RUN if [ "${INSTALL_POWERSHELL}" = "true" ]; then bash /tmp/library-scripts/powershell-debian.sh; fi \
    #
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Switch back to dialog for any ad-hoc use of apt-get
USER $USERNAME
WORKDIR /home/$USERNAME
ENV DEBIAN_FRONTEND=dialog