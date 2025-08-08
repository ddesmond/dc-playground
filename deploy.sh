#!/bin/bash

# deploy playground
nvidia-ctk runtime configure --runtime=docker --set-as-default
systemctl restart docker
mkdir -p /data

docker pull linuxserver/webtop:ubuntu-xfce

docker run -d \
  --name=webtop \
  --security-opt seccomp=unconfined \
  -e PUID=0 \
  -e PGID=0 \
  -e TZ=Etc/UTC \
  -e SUBFOLDER=/  \
  -e TITLE=Webtop  \
  -e DRINODE=/dev/dri/renderD128 \
  -p 3000:3000 \
  -p 3001:3001 \
  -v /data:/config \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --shm-size="21gb"  \
  --privileged \
  --gpus all \
  --runtime nvidia \
  --device /dev/dri:/dev/dri \
  --restart unless-stopped \
  linuxserver/webtop:ubuntu-xfce