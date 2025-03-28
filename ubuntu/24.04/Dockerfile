FROM ubuntu:24.04 AS build

# install common packages
RUN apt update && \
  DEBIAN_FRONTEND=noninteractive apt install -y xterm vim jq && \
  rm -rf /var/lib/apt/lists/*

# ssh
RUN apt update && \
  DEBIAN_FRONTEND=noninteractive apt install -y openssh-server && \
  rm -rf /var/lib/apt/lists/* && \
  echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# password
RUN echo root:root | chpasswd

# squash
FROM scratch AS release
COPY --from=build / /