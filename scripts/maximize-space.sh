#!/bin/sh

device=`mount | grep "/rom" | awk '{print $1}'`
device=${device:0:12}

firstsector=$(( `echo -e "p\nq\n" | fdisk $device | grep 'p2' | awk '{print $3}'` + 1 ))

echo -e "n\np\n3\n$firstsector\n\nw\n" | fdisk $device

echo "y" | mkfs.ext4 ${device}p3
