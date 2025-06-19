FROM jenkins/ssh-agent:alpine-jdk21

USER root

# Install required packages
RUN apk add --no-cache \
    curl \
    wget \
    unzip \
    bash \
    git \
    docker \
    docker-compose \
    ca-certificates

# Install Terraform manually (more reliable on Alpine)
RUN wget https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_amd64.zip && \
    unzip terraform_1.5.7_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform_1.5.7_linux_amd64.zip

# Add jenkins user to existing docker group
RUN adduser jenkins docker

# Fix permissions for /etc/environment
RUN touch /etc/environment && \
    chown jenkins:jenkins /etc/environment && \
    chmod 644 /etc/environment

# Verify installations (run as root)
RUN terraform --version