# Purpose
Azure dev container.

# Build
```bash
docker login registry.gitlab.com

docker build -t registry.gitlab.com/dto-btn/docker/azure-dev:1.0.2 .
docker push registry.gitlab.com/dto-btn/docker/azure-dev:1.0.2 registry.gitlab.com/dto-btn/docker/azure-dev:latest
```

# Using
When you run the image as a local dev container, have it run as your user, so that you are the owner of any files that get created:

```bash
export UID && docker run -it -v $HOME:/home/user -u=$UID:$UID --hostname azure-dev registry.gitlab.com/dto-btn/docker/azure-dev:1.0.3
```

You can also pick the shell that you run with by passing either `bash` (default) or `pwsh`:

```bash
# Run using PowerShell as the shell
export UID && docker run -it -v $HOME:/home/user -u=$UID:$UID --hostname azure-dev registry.gitlab.com/dto-btn/docker/azure-dev:1.0.3 pwsh
```