locals {
  account_vars      = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars       = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  aws_region      = local.region_vars.locals.aws_region
  environment     = local.account_vars.locals.environment
  state_bucket    = local.account_vars.locals.state_bucket
  dynamodb_table  = local.account_vars.locals.dynamodb_table
}

remote_state {
  backend   = "s3"
  generate  = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config    = {
    bucket         = "${local.state_bucket}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "${local.aws_region}"
    encrypt        = true
    dynamodb_table = "${local.dynamodb_table}"
  }
}


inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
  local.account_vars.locals,
)