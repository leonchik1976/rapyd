module "backend" {
  source = "../modules/vpc_eks"

  region = "us-east-1"

  vpc_name  = "vpc-backend"
  layer     = "backend"
  
  eks_iam_role_name   = "eks-backend-eks-cluster-role"
  nodes_iam_role_name = "eks-backend-eks-node-role"
  
  vpc_cidr              = "10.2.0.0/16"
  public_subnets_cidr   = ["10.2.1.0/24", "10.2.2.0/24"]
  private_subnets_cidr  = ["10.2.101.0/24", "10.2.102.0/24"]

  eks_name          = "eks-backend"
  eks_access_ips    = ["0.0.0.0/0"]             ### For GitHub action, in production, self-hosted running should be used
}