# syntax=docker/dockerfile:1-labs
# FROM kindest/node:v1.32.2
# FROM kindest/base:v20250214-acbabc1a


#ARG BASE_IMAGE=ubuntu:24.04
#ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_ubuntu-24.04_v0.1.0
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_containerd-v2.0.2_v0.1.0
FROM $BASE_IMAGE AS base
# RUN --security=insecure ["/sbin/init"]
RUN apt update && apt install -y systemd && rm /sbin/init && ln -s "$(which systemd)" /sbin/init
RUN --security=insecure \
    ["/sbin/init", "--log-target=kmsg"]
