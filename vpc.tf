module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.project_name}-${terraform.workspace}"
  cidr = "${var.vpc_cidr}"

  enable_dns_hostnames = true
  enable_nat_gateway = true
  single_nat_gateway = true

  azs             = "${var.availability_zones}"
  private_subnets = "${var.private_subnets}"
  public_subnets  = "${var.public_subnets}"

  tags = "${var.common_tags}"
}