variable "cluster_name" {
  type = string
}

variable "namespace" {
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

variable "root_app_manifest" {
  type = any
}
