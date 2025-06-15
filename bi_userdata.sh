#!/bin/bash
# System update
yum update -y

# Install Docker
amazon-linux-extras install docker -y
systemctl start docker
systemctl enable docker

docker run -d --name metabase -p 3001:3000  metabase/metabase