include "root" {
  path = find_in_parent_folders()
}

locals {
  base_source = "${dirname(find_in_parent_folders())}/..//terraform/vpc"
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  environment = local.account_vars.locals.environment 
  account_name = local.account_vars.locals.account_name
}

terraform {
  source = local.base_source
}

inputs = {
  vpc_name = "${local.account_name}-${local.environment}-vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  vpc_public_subnets = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  vpc_enable_nat = true
  vpc_single_nat = true
  vpc_enable_dns_hostname = true
}