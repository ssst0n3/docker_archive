FROM ubuntu:22.04 AS basic
COPY start.sh /start.sh
RUN apt-get update && apt-get install -y qemu-system-x86 && rm -rf /var/lib/apt/lists/*
CMD [ "/start.sh" ]

FROM basic AS build
COPY vm.qcow2 /

# squash
FROM scratch AS release
COPY --from=build / /