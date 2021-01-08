#!/bin/sh
qemu-system-x86_64 -boot menu=on -drive file=/home/tom/Downloads/qemu-x86_64.qcow2,format=qcow2 -vga virtio -m 2G -enable-kvm -smp 4 -device e1000,netdev=net0 -netdev user,id=net0,hostfwd=tcp::6666-:22
