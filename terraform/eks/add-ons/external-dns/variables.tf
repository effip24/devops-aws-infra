variable "eks_cluster_name" {
  type = string
}
variable "oidc_provider_arn" {
  type = any
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

variable "is_domain_private_zone" {
  type = bool
}

variable "aws_route53_zone_id" {
  type = any
}
