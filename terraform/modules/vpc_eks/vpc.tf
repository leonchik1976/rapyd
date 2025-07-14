# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/5.21.0?tab=inputs
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  enable_dns_support = true
  enable_dns_hostnames = true
  map_public_ip_on_launch = true
  
  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = true
  
  create_database_subnet_group = false
  create_redshift_subnet_group = false
  
  azs             = ["${var.region}a", "${var.region}b"]
  private_subnets = var.private_subnets_cidr
  public_subnets  = var.public_subnets_cidr
  
  tags = {
    layer = var.layer
  }
}