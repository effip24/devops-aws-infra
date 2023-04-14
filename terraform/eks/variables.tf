variable "eks_cluster_name" {
  type = string
}

variable "eks_cluster_version" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vpc_private_subnets" {
  type = any
}

variable "cluster_endpoint_public_access" {
  type = bool
}

variable "eks_managed_node_group_defaults" {
  type = any  
}

variable "manage_aws_auth_configmap" {
  type = bool
}

variable "aws_auth_roles" {
  type = any
}

variable "eks_managed_node_groups" {
  type = any
}