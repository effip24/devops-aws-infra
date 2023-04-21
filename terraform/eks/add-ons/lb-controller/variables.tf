variable "eks_cluster_name" {
  type = string
}

variable "oidc_provider_arn" {
  type = any
}

variable "eks_cluster_endpoint" {
  type = any
}

variable "eks_cluster_certificate_authority_data" {
  type = any
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
