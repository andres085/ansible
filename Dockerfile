FROM ubuntu:latest
WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
ARG TAGS=""
ARG USERNAME=andres
ARG USER_UID=1001
ARG USER_GID=1001

# Install required packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common curl git build-essential sudo && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y ansible && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

# Create user with unique UID/GID to avoid conflicts
RUN groupadd -g ${USER_GID} ${USERNAME} && \
    useradd -u ${USER_UID} -g ${USER_GID} -s /bin/bash -m ${USERNAME} && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} && \
    chmod 0440 /etc/sudoers.d/${USERNAME}

# Copy playbook files
COPY . /usr/local/bin/

# Now that the user exists, set permissions
RUN if [ -d "/usr/local/bin/.ssh" ]; then \
        chmod -R 700 /usr/local/bin/.ssh && \
        chown -R ${USERNAME}:${USERNAME} /usr/local/bin/.ssh; \
    fi && \
    chown -R ${USERNAME}:${USERNAME} /usr/local/bin

USER ${USERNAME}
ENV USER=${USERNAME}
ENV HOME=/home/${USERNAME}

CMD ["sh", "-c", "ansible-playbook $TAGS local.yml"]
