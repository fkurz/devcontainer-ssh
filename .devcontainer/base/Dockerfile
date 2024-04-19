FROM ubuntu:22.04

WORKDIR /home

COPY sshd_config /etc/ssh/sshd_config
COPY docker-entrypoint.sh docker-entrypoint.sh

RUN <<EOF
    chmod +x docker-entrypoint.sh && \
    mkdir -p /var/run/sshd && \
    apt-get update && \
    apt-get upgrade -y openssh-server && \
    useradd -rm -d /home/ssh-user -s /bin/bash -g root -G sudo -u 1000 ssh-user && \
    printf "ssh-user:password123" | chpasswd
EOF

EXPOSE 65432
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]