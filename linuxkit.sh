#!/bin/bash
linuxkit run qemu -mem 2048M -disk "file=disk.qcow2,size=10G,format=qcow2" docker.qcow2
