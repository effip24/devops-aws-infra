include "root" {
  path = find_in_parent_folders()
}

locals {
  base_source = "${dirname(find_in_parent_folders())}/..//terraform/eks"
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  environment = local.account_vars.locals.environment
  account_id = local.account_vars.locals.aws_account_id
}

dependencies {
  paths = ["../vpc"]
}

dependency "vpc" {
  config_path = "../vpc"
}

terraform {
  source = local.base_source
}

inputs = {
  eks_cluster_name = "${local.environment}-eks-test"
  eks_cluster_version = "1.24"
  account_id = local.account_id
  vpc_id = dependency.vpc.outputs.vpc_id
  vpc_private_subnets = dependency.vpc.outputs.vpc_private_subnets
  cluster_endpoint_public_access = true
  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }
  eks_managed_node_groups = {
    one = {
      name = "${local.environment}node-group-1"
      instance_types = ["t2.micro"]
      min_size     = 1
      max_size     = 10
      desired_size = 7
    }
  }
  create_aws_auth_configmap = true
  manage_aws_auth_configmap = true
  eks_admin_role_name = "eks-admin-role"
  tags = {
    Environment = local.environment
    Terraform   = "true"
  }
}