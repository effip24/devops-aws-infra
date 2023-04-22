variable "eks_cluster_name" {
  type = string
}

variable "oidc_provider_arn" {
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
