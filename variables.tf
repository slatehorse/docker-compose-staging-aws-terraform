terraform {
  backend "s3" {
    region = "eu-west-2"
  }
}

provider "aws" {
  region = "eu-west-2" # EU (Ireland)
}

variable "project_name" {
  description = "The project name, to prefix resources. Dash-case, e.g. my-sample-project"
}

variable "common_tags" {
  type ="map"
  description = "Tags to apply to all AWS resources"
  default = {
    Terraform = "true"
  }
}

#
# VPC configuration
#

variable "vpc_cidr" {
  description = "The CIDR to use for the VPC."
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  type = "list"
  description = "The list of availability zones to use for the VPC. This must match your provider region."
  default = [
      "eu-west-2a",
      "eu-west-2b", 
      "eu-west-2c"
    ]
}

variable "private_subnets" {
  type = "list"
  description = "The list of private subnets to use for the VPC."
  default = [
      "10.0.1.0/24", 
      "10.0.2.0/24", 
      "10.0.3.0/24"
    ]
}

variable "public_subnets"  {
  type = "list"
  description = "The list of public subnets to use for the VPC."
  default = [
      "10.0.101.0/24", 
      "10.0.102.0/24", 
      "10.0.103.0/24"
    ]
}

#
# Bastion host
#
variable "bastion_host_instance_type" {
  description = "The AWS EC2 instance type for the bastion host"
  default = "t2.nano"
}

variable "bastion_host_ssh_public_keys" {
  description = "The map of public keys for users of the bastion host"
  default = {}
}

#
# Shared configuration
#
variable "route53_zone_id" {
  description = "The ID of your Route53 zone"
}

variable "route53_cname_ttl" {
  description = "The TTL for Route53 DNS records"
  default = "300"
}

variable "docker_compose_instance_type" {
  description = "The AWS EC2 instance type for the docker-compose host"
  default = "t2.medium"
}