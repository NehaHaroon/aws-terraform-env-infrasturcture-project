#!/bin/bash
# Install Nginx, Docker, Node.js 20
amazon-linux-extras install nginx1 -y
systemctl start nginx
systemctl enable nginx

# Docker
yum install -y docker
service docker start
usermod -a -G docker ec2-user

# Node.js 20
curl -fsSL https://rpm.nodesource.com/setup_20.x | bash -
 yum install -y nodejs

# Pull and run your frontend/backend containers
# Replace with your GitHub image tags

docker run -d --name backend -p 3001:3001 yourrepo/backend:latest
docker run -d --name frontend -p 80:80 yourrepo/frontend:latest