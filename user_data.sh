#!/bin/bash
set -eux

# Use noninteractive apt
export DEBIAN_FRONTEND=noninteractive

# Update packages
apt-get update -y
apt-get upgrade -y

# Install dependencies for Docker
apt-get install -y ca-certificates curl gnupg lsb-release apt-transport-https

# Add Docker's official GPG key and repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker engine
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io

# Enable and start docker
systemctl enable docker
systemctl start docker

# Create persistent directory for Strapi app / SQLite
mkdir -p /opt/strapi-data
chown -R ubuntu:ubuntu /opt/strapi-data
chmod -R 755 /opt/strapi-data

# Pull official Strapi image
docker pull strapi/strapi:latest

# Stop container if exists then run with volume mapped to persist SQLite and uploads
if docker ps -a --format '{{.Names}}' | grep -q '^strapi$'; then
  docker rm -f strapi || true
fi

docker run -d \
  --name strapi \
  --restart unless-stopped \
  -p 1337:1337 \
  -v /opt/strapi-data:/srv/app \
  strapi/strapi:latest

# Wait for a bit and log the container logs to a file for debugging
sleep 8
docker logs strapi --tail 50 >> /var/log/strapi_container.log || true
