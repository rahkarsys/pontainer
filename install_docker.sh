#!/bin/bash

install_docker() {
    # Check if Docker is already installed and active
    if ! systemctl is-active docker &>/dev/null; then
        read -rp "Docker-CE is not installed. Would you like to install it? (y/n): " answer
        if [[ "$answer" =~ ^[Yy]$ ]]; then
            # Install Docker
            curl -fsSL https://get.docker.com | sh
            sudo systemctl start docker
            sudo systemctl enable docker
        else
            echo "Docker is required for this script. Exiting."
            exit 1
        fi
    else
        echo "Docker is already installed and running."
    fi
}

# Call the install_docker function
install_docker
