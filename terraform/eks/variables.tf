variable "eks_cluster_name" {
  type = string
}

variable "account_id" {
  type = string
}

variable "region" {
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

variable "create_aws_auth_configmap" {
  type = bool
}

variable "manage_aws_auth_configmap" {
  type = bool
}

variable "eks_managed_node_groups" {
  type = any
}

variable "tags" {
  type = any
}

variable "eks_admin_role_name" {
  type = string
}

variable "node_security_group_tags" {
  type = any
}

variable "domain" {
  type = string
}

variable "is_domain_private_zone" {
  type    = bool
  default = false
}

variable "karpenter_chart_repo" {
  type = string
}

variable "karpenter_chart_name" {
  type = string
}

variable "karpenter_chart_version" {
  type = string
}

variable "external_dns_chart_repo" {
  type = string
}

variable "external_dns_chart_name" {
  type = string
}

variable "external_dns_chart_version" {
  type = string
}

variable "external_dns_provider" {
  type = string
}

variable "external_dns_source" {
  type = string
}

variable "lb_controller_chart_repo" {
  type = string
}

variable "lb_controller_chart_name" {
  type = string
}

variable "lb_controller_chart_version" {
  type = string
}
