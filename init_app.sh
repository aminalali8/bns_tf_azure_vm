#!/bin/bash

# Update package lists
sudo apt update

# Function to check if a package is installed
is_package_installed() {
    dpkg -s "$1" &> /dev/null
    return $?
}

# Install git if not installed
if ! is_package_installed git; then
    sudo apt install -y git
fi

# Install required packages if not installed
for package in apt-transport-https ca-certificates curl software-properties-common; do
    if ! is_package_installed "$package"; then
        sudo apt install -y "$package"
    fi
done

# Add Docker repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
yes | sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update package lists again
sudo apt update

# Install Docker and related packages if not installed
for package in docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose; do
    if ! is_package_installed "$package"; then
        sudo apt-get install -y "$package"
    fi
done

# Create or update the app directory
APP_DIR="app"
REPO_URL="https://github.com/aminalali8/demo-books.git"

if [ -d "$APP_DIR/.git" ]; then
    # If the directory exists and is a git repository, pull the latest changes
    echo "Updating existing repository in $APP_DIR"
    cd "$APP_DIR"
    git pull
else
    # If the directory does not exist as a git repository, clone afresh
    echo "Cloning repository into $APP_DIR"
    rm -rf "$APP_DIR"  # Remove the directory if it exists
    git clone "$REPO_URL" "$APP_DIR"
    cd "$APP_DIR"
fi

# Start Docker Compose
sudo docker-compose down
sudo docker-compose up --build -d
