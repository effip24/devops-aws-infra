# eks mian vars -------------
variable "eks_cluster_name" {
  type = string
}

variable "account_id" {
  type = string
}

variable "eks_cluster_version" {
  type = string
}

variable "environment" {
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

variable "is_domain_private_zone" {
  type    = bool
  default = false
}

# karpenter main vars -------------
variable "create_karpenter" {
  type = bool
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

# external-dns main vars -------------
variable "create_external_dns" {
  type = bool
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

variable "external_dns_aws_region" {
  type = string
}

variable "external_dns_source" {
  type = string
}

variable "external_dns_domain_filter" {
  type = string
}

# load-balancer-controller main vars -------------
variable "create_load_balancer_controller" {
  type = bool
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

# argocd main vars -------------
variable "create_argocd" {
  type = bool
}

variable "argocd_namespace" {
  type = string
}

variable "argocd_repo" {
  type = string
}

variable "argocd_chart" {
  type = string
}

variable "argocd_version" {
  type = string
}

variable "argocd_root_app_name" {
  type = string
}

variable "argocd_root_app_repo" {
  type = string
}

variable "argocd_root_app_path" {
  type = string
}

variable "argocd_root_app_targetRevision" {
  type = string
}

variable "argocd__root_app_project" {
  type = string
}
