# gitpod-ubuntu-20.04
Vanilla GitPod  Ubuntu 20.04 image, with a few system dependencies enabled and GUI support via [noVNC](https://github.com/novnc/noVNC).

The VNC support is inspired from the https://github.com/robotology/icub-gazebo-grasping-sandbox .

## Instructions  
Click on the following badge to open the GitPod image:

[![Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/from-referrer)

## How to customize this structure in a new repo

If you want to use this structure in a new repo, this are the step for taking the files from this repo and customizing it:
1. Copy the file `.gitpod.yml` and the directories `dockerfiles` and `.github/workflows` in the new repo.
1. In `.gitpod.yml` file, change the line `image: ghcr.io/traversaro/gitpod-ubuntu-20.04:latest` to `image: ghcr.io/<organization>/<repo>:latest`.
1. In `.github/workflows/publish-docker.yml` file, change the line `name: traversaro/gitpod-ubuntu-20.04` to `name: <organization>/<repo>`.
1. Modify `dockerfiles/Dockerfile`. In particular, modify the lines that start with `LABEL` to describe your repo, and add the necessary installation step for your software as `RUN` lines. For more info, check the [reference documentation on Dockerfiles](https://docs.docker.com/engine/reference/builder/).
