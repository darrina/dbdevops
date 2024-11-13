#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if the runner is already configured
if [ ! -f .runner ]; then
  echo "Configuring the GitHub Actions runner..."

  # Configure the runner
  ./config.sh --url https://github.com/$GITHUB_REPO --token $GITHUB_TOKEN

  # Mark the runner as configured
  touch .runner
fi

# Enable docker in docker
if [ -f /var/run/docker.sock ]; then
    echo "Enabling host docker connection..."
    sudo chown runner:runner /var/run/docker.sock
fi

# Start the runner
echo "Starting the GitHub Actions runner..."
./run.sh

