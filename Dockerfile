FROM ubuntu:20.04
COPY start_vm.sh /start_vm.sh

RUN sed -i "s@http://.*.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list
RUN apt-get update && apt-get install -y qemu-system-x86 && apt-get clean

CMD [ "/start_vm.sh" ]
