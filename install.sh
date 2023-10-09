#!/bin/bash

install_docker() {
    # Check if Docker is already installed
    if ! [ -x "$(command -v docker)" ]; then
        # Install Docker
        echo "Installing Docker..."
        sudo apt update
        sudo apt install -y docker.io
        sudo systemctl enable docker
        sudo systemctl start docker
        echo "Docker has been installed."
    else
        echo "Docker is already installed."
    fi
}

install_docker_compose() {
    # Check if Docker Compose is already installed
    if ! [ -x "$(command -v docker-compose)" ]; then
        # Install Docker Compose
        echo "Installing Docker Compose..."
        sudo apt install -y docker-compose
        echo "Docker Compose has been installed."
    else
        echo "Docker Compose is already installed."
    fi
}

install_nginx_portainer() {
    # Check if Portainer is installed and running
    if sudo docker ps | grep -q "portainer/portainer-ce"; then
        echo "Portainer-CE is already running."
    else
        # Install Portainer
        echo "Installing Portainer-CE..."
        sudo docker volume create portainer_data
        sudo docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
        echo "Portainer-CE has been installed and is running."
    fi

    # Check if NGINX Stack is deployed
    if ! sudo docker stack ls | grep -q "nginx_stack"; then
        # Deploy NGINX Stack
        echo "Deploying NGINX Stack..."
        cat <<EOF > ~/nginx-stack.yml
version: '3'
services:
  nginx:
    image: nginx:latest
    container_name: nginx
    ports:
      - "80:80"
    volumes:
      - ./nginx-config:/etc/nginx/conf.d
    networks:
      - nginx_network
networks:
  nginx_network:
    driver: overlay
EOF
        sudo docker stack deploy -c ~/nginx-stack.yml nginx_stack
        echo "NGINX Stack has been deployed."
    fi
}

# Main script
echo "Installing Docker, Docker Compose, NGINX, and Portainer on Ubuntu 20.04 or higher..."
install_docker
install_docker_compose
install_nginx_portainer
echo "Installation completed."
