module "gateway" {
  source = "../modules/vpc_eks"

  region = "us-east-1"

  vpc_name  = "vpc-gateway"
  layer     = "gateway"

  eks_iam_role_name   = "eks-gateway-eks-cluster-role"
  nodes_iam_role_name = "eks-gateway-eks-node-role"
  
  vpc_cidr              = "10.1.0.0/16"
  public_subnets_cidr   = ["10.1.1.0/24", "10.1.2.0/24"]
  private_subnets_cidr  = ["10.1.101.0/24", "10.1.102.0/24"]

  eks_name          = "eks-gateway"
  eks_access_ips    = ["0.0.0.0/0"]             ### For GitHub action, in production, self-hosted running should be used
}