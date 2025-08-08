ARG HOSTNAME=your-gpu-my-shell
ARG FLAG=flag{test}
ARG BASE_IMAGE=ssst0n3/docker_archive:ctr_cve-2025-23266_mitigation
ARG VERSION_IMAGE=0.1.0

FROM golang:1.23.0 AS ctf-server
COPY ctf-server /go/src/ctf-server
WORKDIR /go/src/ctf-server
RUN go mod tidy && \
    GOOS=linux GOARCH=amd64 go build -o /go/bin/ctf-server main.go

FROM ${BASE_IMAGE}_v${VERSION_IMAGE} AS service
COPY --from=ctf-server /go/bin/ctf-server /usr/local/bin/ctf-server
COPY ctf-server.service /usr/local/lib/systemd/system/
RUN systemctl enable ctf-server.service

FROM service AS network
ARG HOSTNAME
RUN apt update && \
    apt install -y netcat-traditional && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
RUN echo ${HOSTNAME} > /etc/hostname

FROM network AS flag
ARG FLAG
RUN echo ${FLAG} > /flag && \
    chmod 400 /flag && \
    chown root:root /flag
