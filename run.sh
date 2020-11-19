#!/bin/bash

FILE_NAME=$1

arm-linux-gnueabihf-gcc $FILE_NAME -static -ggdb3

sleep 2

qemu-arm -g 12345 a.out &

sleep 1

gdb-multiarch -q --nh -ex 'set architecture arm' -ex 'file a.out' -ex 'target remote localhost:12345'
