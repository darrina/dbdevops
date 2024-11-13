# Use the official Ubuntu 22.04 image as the base image
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
        curl \
        docker.io \
        git \
        jq \
        iproute2 \
        libicu70 \
        libkrb5-3 \
        libssl3 \
        libunwind8 \
        net-tools \
        tzdata \
        zip \
        unzip \
        software-properties-common && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN add-apt-repository universe && \
    apt-get update && \
    apt-get install -y \
        sudo

# Add a non-root user to run the runner
RUN useradd -m runner && \
    echo "runner ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Create a directory for the GitHub Actions runner
RUN mkdir /actions-runner && chown runner:runner /actions-runner
WORKDIR /actions-runner

# Switch to the runner user
USER runner

# Download the latest GitHub Actions runner package
RUN curl -o actions-runner-linux-x64-2.320.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.320.0/actions-runner-linux-x64-2.320.0.tar.gz

# Extract the runner package
RUN tar xzf actions-runner-linux-x64-2.320.0.tar.gz

# Entry point to start the runner
COPY --chown=runner:runner entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

ENTRYPOINT ["/actions-runner/entrypoint.sh"]

