#!/bin/bash

set -e
./pre_requisites.sh

case "$1" in 
    "github")
        tag=$(date +"%g%m.%d%H")
        azuredev="sscspccloudnuage/azuredev:${tag}"
        ;;
    "dev")
        tag=$(date +"%g%m.%d%H%M")
        azuredev="sscspccloudnuage/azuredevdev:${tag}"
        ;;
    *)
        tag=$(date +"%g%m.%d%H%M")
        azuredev="sscspccloudnuage/azuredevdev:${tag}"
        ;;
esac

echo "Creating version ${azuredev}"

# Build the azuredev base image
docker-compose build --build-arg versionazuredev=${azuredev}
# docker build -t azuredev .

case "$1" in 
    "github")
        docker tag container-azure-dev_azuredev ${azuredev}
        docker tag container-azure-dev_azuredev sscspccloudnuage/azuredev:latest

        docker push sscspccloudnuage/azuredev:${tag}
        docker push sscspccloudnuage/azuredev:latest

        echo "Version sscspccloudnuage/azuredev:${tag} created."
        echo "Version sscspccloudnuage/azuredev:latest created."
        ;;
    "dev")
        docker tag container-azure-dev_azuredev sscspccloudnuage/azuredevdev:${tag}
        docker tag container-azure-dev_azuredev sscspccloudnuage/azuredevdev:latest

        docker push sscspccloudnuage/azuredevdev:${tag}
        docker push sscspccloudnuage/azuredevdev:latest
        echo "Version sscspccloudnuage/azuredevdev:${tag} created."
        echo "Version sscspccloudnuage/azuredevdev:latest created."
        ;;
    *)    
        docker tag container-azure-dev_azuredev sscspccloudnuage/azuredev:${tag}
        docker tag container-azure-dev_azuredev sscspccloudnuage/azuredev:latest
        echo "Local version created"
        echo "Version sscspccloudnuage/azuredev:${tag} created."
        echo "Version sscspccloudnuage/azuredev:latest created."
        ;;
esac
