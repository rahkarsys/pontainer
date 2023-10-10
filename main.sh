#!/bin/bash

# Main script starts here
clear

echo "Let's determine your operating system."

PS3="Please select your OS: "
select os in "Ubuntu" "Exit"; do
    case $os in
        "Ubuntu")
            ./install_docker.sh
            ./install_docker_compose.sh
            echo "Ubuntu-specific installation completed."
            break
            ;;
        "Exit")
            echo "Exiting the script."
            exit 0
            ;;
        *)
            echo "Invalid selection. Please try again."
            ;;
    esac
done
