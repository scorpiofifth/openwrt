#!/bin/bash

ADDRESS="https://github.com/scorpiofifth/openwrt/releases/download/docker"

wget -nv "$ADDRESS/memos.tar" -O files/root/docker/memos.tar

wget -nv "$ADDRESS/alist.tar" -O files/root/docker/alist-ffmpeg.tar

wget -nv "$ADDRESS/librespeed.tar" -O files/root/docker/librespeed.tar

wget -nv "$ADDRESS/it-tools.tar" -O files/root/docker/it-tools.tar

wget -nv "$ADDRESS/perlite.tar" -O files/root/docker/perlite.tar
