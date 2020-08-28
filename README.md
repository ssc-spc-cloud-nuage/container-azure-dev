# Purpose
Azure dev container.

# Build
```bash
docker login 

docker build -t sscspccloudnuage/azure-dev:1.0.0 .
docker build -t sscspccloudnuage/azure-dev:latest .

docker push sscspccloudnuage/azure-dev:1.0.0
docker push sscspccloudnuage/azure-dev:latest
```

# Using
When you run the image as a local dev container, have it run as your user, so that you are the owner of any files that get created:

```bash
export UID && docker run -it -v $HOME:/home/user -u=$UID:$UID --hostname azure-dev azure-dev:1.0.0
```

You can also pick the shell that you run with by passing either `bash` (default) or `pwsh`:

```bash
# Run using PowerShell as the shell
export UID && docker run -it -v $HOME:/home/user -u=$UID:$UID --hostname azure-dev azure-dev:1.0.0 pwsh
```