variable "eks_cluster_name" {
  type = string
}
variable "oidc_provider_arn" {
  type = any
}
variable "environment" {
  type = string
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

variable "kapenter_created" {
  type = bool
}

variable "external_dns_created" {
  type = bool
}

variable "lb_controller_created" {
  type = bool
}

variable "external_dns_domain_filter" {
  type = string
}
