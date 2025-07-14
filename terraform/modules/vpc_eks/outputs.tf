output "vpc_name" {
  value         = module.vpc.name
  description   = "VPC Name"
}

output "vpc_id" {
  value         = module.vpc.vpc_id
  description   = "VPC ID"
}

output "vpc_cidr" {
  value         = module.vpc.vpc_cidr_block
  description   = "VPC CIDR"
}

output "private_route_table_ids" {
  value         = module.vpc.private_route_table_ids
  description   = "Private Route Table IDs"
}

output "eks_cluster_primary_security_group_id" {
  value         = module.eks.cluster_primary_security_group_id
  description   = "Cluster security group that was created by Amazon EKS for the cluster"
}

output "eks_cluster_security_group_id" {
  value         = module.eks.cluster_security_group_id
  description   = "ID of the cluster security group"
}

output "node_security_group_id" {
  value       = module.eks.node_security_group_id
  description = "ID of the node shared security group"
}

output "eks_cluster_endpoint" {
  value         = module.eks.cluster_endpoint
  description   = "EKS Cluster Endpoint"
}