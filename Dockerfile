FROM alpine
COPY qemu.sh /qemu.sh
# RUN sed -i "s@https://dl-cdn.alpinelinux.org/@https://repo.huaweicloud.com/@g" /etc/apk/repositories 
RUN apk add --no-cache qemu-system-x86_64

CMD ["/qemu.sh"]
