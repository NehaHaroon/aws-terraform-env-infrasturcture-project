#!/bin/bash
# Install updates
yum update -y
# Install Docker, Nginx, Node.js 20
amazon-linux-extras enable nginx1
yum install -y nginx docker
curl -fsSL https://rpm.nodesource.com/setup_20.x | bash -
yum install -y nodejs
systemctl enable --now docker
usermod -aG docker ec2-user

# Start Nginx
systemctl enable --now nginx

# Pull and run app container
docker run -d --name app -p 80:3000 <your-dockerhub>/app:latest