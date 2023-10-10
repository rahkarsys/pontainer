#!/bin/bash

install_docker_compose() {
    # Check if Docker Compose is installed
    if ! command -v docker-compose &>/dev/null; then
        read -rp "Docker-Compose is not installed. Would you like to install it? (y/n): " answer
        if [[ "$answer" =~ ^[Yy]$ ]]; then
            # Install Docker Compose
            sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
            sudo chmod +x /usr/local/bin/docker-compose
        else
            echo "Docker Compose is required for this script. Exiting."
            exit 1
        fi
    else
        echo "Docker Compose is already installed."
    fi
}

# Call the install_docker_compose function
install_docker_compose
