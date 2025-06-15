##  aws-terraform-env-infrasturcture-project
# 
# # Project: Scalable, Secure, Containerized AWS Environment with Terraform
# # 
# # Overview
# # 
# # This repository automates the provisioning of a full-stack AWS infrastructure using Terraform, deploys Dockerized frontend and backend services on EC2 Auto Scaling Group instances, manages private RDS databases, configures an HTTPS Application Load Balancer, and deploys a BI tool (Metabase) with live dashboard capabilities.
# # 
# # Architecture Diagram
#        │
#     Internet
#        ▼
#   ┌───────────┐      ┌────────────────┐
#   │ Route 53   │◄────▶│ Application    │
#   │ neha.sky98 │ DNS  │ Load Balancer  │
#   └───────────┘      └───┬────────────┘
#                          │
#             ┌────────────┴────────────┐
#             │ EC2 Auto Scaling Group   │
#             │ (Docker: frontend + API) │
#             └────────────┬────────────┘
#                          │
#          ┌───────────────┴───────────────┐         ┌────────────┐
#          │        Private Subnets        │         │  BI EC2    │
#          │ ┌────────┐   ┌──────────────┐ │         │(Metabase)  │
#          │ │ RDS    │   │ RDS          │ │         │ Docker:    │
#          │ │ MySQL  │   │ PostgreSQL   │ │         │ Metabase   │
#          │ └────────┘   └──────────────┘ │         └────────────┘
#          └───────────────────────────────┘               │
#                                                          ▼
#                                                     Route 53 Alias
#                                                     bi.sky98.store
# Repository Structure
# terraform/                # Terraform configuration files
# ├── main.tf               # Provider, VPC, subnets, locals
# ├── variables.tf          # Input variables
# ├── ec2.tf                # Launch Template, ASG, BI EC2 instance
# ├── rds.tf                # RDS subnet group and instances
# ├── alb.tf                # Application Load Balancer & listeners
# ├── target_group.tf       # ALB target group & health checks
# ├── security_groups.tf    # SGs for EC2, RDS, ALB
# ├── route53.tf            # DNS records for app domain
# ├── certificate.tf        # (optional) ACM cert request & validation
# ├── outputs.tf            # Key outputs (endpoints, ARNs)
# ├── userdata.sh           # Bootstrap script for app EC2
# └── bi_userdata.sh        # Bootstrap for BI EC2 (Metabase)
# devops-project-webapp/    # Sample full-stack web application
# ├── Dockerfile.backend    # Multi-stage build for Node.js API
# 
# └── Dockerfile.frontend   # Multi-stage build for React (or HTML)
# Prerequisites
# 
# AWS account with:
# 
# Route 53 Hosted Zone for sky98.store
# 
# IAM permissions for EC2, RDS, ALB, Route 53, ACM, VPC
# 
# AWS CLI configured (aws configure) targeting us-east-2
# 
# Terraform CLI v1.5+
# 
# SSH keypair named testkey in AWS (downloaded as testkey.pem)
# 
# 1. Clone & Navigate
# git clone https://github.com/NehaHaroon/devops-project-webapp.git
# 
# cd devops-project-webapp/terraform
# 2. Configure Variables
# 
# Create a terraform.tfvars (optional) to override defaults:
# region               = "us-east-2"
# 
# ami_id               = "ami-0dc3a08bd93f84a35"
# instance_type        = "t2.micro"
# key_name             = "testkey"
# db_username          = "neha"
# db_password          = "Abc75000"
# acm_certificate_arn  = "arn:aws:acm:us-east-2:...:certificate/..."
# 3. Initialize & Plan
# terraform init
# 
# terraform validate
# terraform plan -out=tfplan
# 4. Apply
# terraform apply "tfplan"
# 
# 5. Verify
# 
# Outputs:
# terraform output asg_name
# 
# terraform output mysql_endpoint
# terraform output postgres_endpoint
# terraform output alb_dns_name
# App:Open https://neha.sky98.store (or your ALB DNS) in browser.
# 
# SSH Tunnel (for DB):
# ssh -i ~/.ssh/testkey.pem -L 3306:${mysql_endpoint}:3306 -L 5432:${postgres_endpoint}:5432 ec2-user@<App_EC2_IP>
# 
# Fixing user data: edit userdata.sh and then:
# terraform apply -target=aws_launch_template.app_template
# 
# terraform apply -target=aws_autoscaling_group.app_asg
# Cleanup
# 
# To destroy all resources:
# terraform destroy -auto-approve
# 
# Happy Infrastructure as Code!
# 