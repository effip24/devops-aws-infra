variable "eks_cluster_name" {
  type = string
}

variable "oidc_provider_arn" {
  type = any
}

variable "karpenter_chart_repo" {
  type = string
}

variable "aws_ecrpublic_authorization_token_username" {
  type = any
}

variable "aws_ecrpublic_authorization_token_password" {
  type = any
}

variable "karpenter_chart_name" {
  type = string
}

variable "karpenter_chart_version" {
  type = string
}

variable "eks_cluster_endpoint" {
  type = any
}

variable "karpenter_tags" {
  type = any
}