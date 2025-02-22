# syntax=docker/dockerfile:1-labs
# FROM kindest/node:v1.32.2
# FROM kindest/base:v20250214-acbabc1a


ARG BASE_IMAGE=debian:bookworm-slim
FROM $BASE_IMAGE AS base
# RUN --security=insecure ["/sbin/init"]
RUN apt update && apt install -y systemd && ln -s "$(which systemd)" /sbin/init
RUN --security=insecure \
    ["/sbin/init", "--log-target=kmsg"]
