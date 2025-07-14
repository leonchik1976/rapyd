variable "vpc_name" {
  type = string
}

variable "layer" {
  type = string
}

variable "region" {
  type      = string
}

variable "vpc_cidr" {
  type = string
}

variable "private_subnets_cidr" {
  type = list(string)
  validation {
    condition       = length(var.private_subnets_cidr) == 2
    error_message   = "Exactly 2 private subnets must be provided"
  }
}

variable "public_subnets_cidr" {
  type = list(string)
  validation {
    condition       = length(var.public_subnets_cidr) == 2
    error_message   = "Exactly 2 public subnets must be provided"
  }
}

variable "enable_nat_gateway" {
  type = bool
  default = true
}

variable "eks_name" {
  type = string
}

variable "eks_version" {
  type    = string
  default = "1.33"
}

variable "eks_access_ips" {
  type          = list(string)
  description   = "Restrict Access to EKS Cluster to specific IPs"
}

variable "instance_types" {
  type          = list(string)
  default       = [ "t3.medium" ]
  description   = "Instance Types"
}

variable "eks_iam_role_name" {
  type = string
  default = null
}

variable "enable_irsa" {
  type = bool
  default = false
}

variable "nodes_iam_role_name" {
  type = string
  default = null
}