# https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/20.37.1
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.37.1"

  cluster_name    = var.eks_name
  cluster_version = var.eks_version

  iam_role_name             = var.eks_iam_role_name
  iam_role_use_name_prefix  = var.eks_iam_role_name == null

  create_kms_key               = false
  cluster_encryption_config    = {}
  enable_auto_mode_custom_tags = false
  
  control_plane_subnet_ids  = module.vpc.private_subnets
  subnet_ids                = module.vpc.private_subnets
  vpc_id                    = module.vpc.vpc_id

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access = true                         ### in production MUST be set to false! Set to true so i can access it from my computer
  cluster_endpoint_public_access_cidrs = var.eks_access_ips
  enable_cluster_creator_admin_permissions = true

  enable_irsa = var.enable_irsa
  
  # tags = {
  #   layer = var.layer
  # }
}

# https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest/submodules/eks-managed-node-group?tab=inputs
module "eks_managed_node_group" {
  source = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
  version = "20.37.1"
  
  name            = "general"
  cluster_name    = module.eks.cluster_name
  cluster_version = module.eks.cluster_version
  cluster_service_cidr = module.eks.cluster_service_cidr

  subnet_ids =  module.vpc.private_subnets
  
  cluster_primary_security_group_id = module.eks.cluster_primary_security_group_id
  vpc_security_group_ids            = [module.eks.node_security_group_id]

  iam_role_name = var.nodes_iam_role_name
  iam_role_use_name_prefix = var.nodes_iam_role_name == null
  
  min_size     = 1
  max_size     = 1
  desired_size = 1

  instance_types = var.instance_types
  capacity_type  = "ON_DEMAND"

  # tags = {
  #   layer = var.layer
  # }
}