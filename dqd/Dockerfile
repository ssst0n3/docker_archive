FROM ubuntu:22.04 AS basic
COPY start.sh /start.sh
RUN apt-get update && apt-get install -y qemu-system-x86 && apt-get clean
CMD [ "/start.sh" ]

FROM basic
COPY vm.qcow2 /