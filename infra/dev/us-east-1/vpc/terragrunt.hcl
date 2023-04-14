include "root" {
  path = find_in_parent_folders()
}

locals {
  base_source = "${dirname(find_in_parent_folders())}/..//terraform/vpc"
}

terraform {
  source = local.base_source
}