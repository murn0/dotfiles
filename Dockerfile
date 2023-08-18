ARG DOCKER_IMAGE_NAME
FROM ${DOCKER_IMAGE_NAME}

COPY install-scripts/docker-entrypoint.sh /tmp/docker-entrypoint.sh
RUN <<EOF
    set -e
    chmod +x /tmp/docker-entrypoint.sh
    /bin/bash /tmp/docker-entrypoint.sh
EOF

ARG USERNAME=user
ARG GROUPNAME=user
ARG UID=1000
ARG GID=1000
RUN <<EOF
    set -e
    groupadd -g $GID $GROUPNAME
    useradd -m -s /bin/bash -u $UID -g $GID $USERNAME
EOF
USER $USERNAME
WORKDIR /home/$USERNAME/