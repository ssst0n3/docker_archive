FROM ubuntu:22.04
COPY start.sh /start.sh
RUN apt-get update && apt-get install -y qemu-system-x86 && rm -rf /var/lib/apt/lists/*
CMD [ "/start.sh" ]