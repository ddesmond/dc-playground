#!/bin/bash

# deploy yum yum playground
nvidia-ctk runtime configure --runtime=docker --set-as-default
systemctl restart docker
mkdir -p /data

docker pull linuxserver/webtop:ubuntu-xfce

docker run -d \
  --name=yumyum \
  --security-opt seccomp=unconfined \
  -e CUSTOM_USER=yumyum \
  -e CUSTOM_PASSWORD=xxx \
  -e DISABLE_IPV6=true \
  -e PUID=0 \
  -e PGID=0 \
  -e TZ=Etc/UTC \
  -e SUBFOLDER=/  \
  -e TITLE=deploy.sh  \
  -p 6999:3000 \
  -p 7000:3001 \
  -v /data:/config \
  --shm-size="21gb"  \
  --privileged \
  --gpus all \
  --runtime nvidia \
  --restart unless-stopped \
  linuxserver/webtop:ubuntu-xfce