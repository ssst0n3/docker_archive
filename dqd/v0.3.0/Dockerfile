FROM alpine:3.21
RUN apk update && \
    apk add --no-cache \
        qemu-system-x86_64 \
        cloud-utils-localds && \
    rm -rf /var/cache/apk/*
COPY start.sh /start.sh
CMD [ "/start.sh" ]
