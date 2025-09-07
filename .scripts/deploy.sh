#!/bin/bash
set -e

echo "Deployment started ..."

# Make sure NVM is available
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Reset and update code
echo "Fetching latest code..."
git fetch origin main
git reset --hard origin/main
echo "Code updated from remote!"

# Installing Dependencies
echo "Installing Dependencies..."
npm install --yes

# Creating a build with env variables
echo "Setting environment variables..."
export VITE_BASE_URL="https://jsonplaceholder.typicode.com/todos"
export VITE_NODE_ENV="production"

echo "Building application..."
npm run build

# Copying dist to /var/www/[project name]
echo "Copying dist to /var/www/app1"
sudo rm -rf /var/www/app1/*
sudo cp -r dist/* /var/www/app1

echo "Deployment Finished!"