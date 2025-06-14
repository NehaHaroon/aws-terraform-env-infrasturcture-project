#!/bin/bash
# Install Docker
yum update -y && yum install -y docker
yum install -y python3-pip
systemctl enable --now docker
usermod -aG docker ec2-user

# Run Metabase
docker run -d --name metabase -p 3000:3000 metabase/metabase