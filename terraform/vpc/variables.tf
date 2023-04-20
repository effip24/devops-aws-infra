variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_private_subnets" {
  type = list(string)
}

variable "vpc_public_subnets" {
  type = list(string)
}

variable "vpc_enable_nat" {
  type = bool
}

variable "vpc_single_nat" {
  type = bool
}

variable "vpc_enable_dns_hostname" {
  type = bool
}
