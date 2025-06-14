variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "Existing VPC ID (or leave blank to create new)"
  type        = string
  default     = ""
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "domain_name" {
  description = "Root domain for applications"
  type        = string
}

variable "app_domain" {
  description = "Subdomain for web app"
  type        = string
}

variable "bi_domain" {
  description = "Subdomain for BI tool"
  type        = string
}