module "eks" {
  source                          = "terraform-aws-modules/eks/aws"
  version                         = "19.5.1"
  cluster_name                    = var.eks_cluster_name
  cluster_version                 = var.eks_cluster_version
  vpc_id                          = var.vpc_id
  subnet_ids                      = var.vpc_private_subnets
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  eks_managed_node_group_defaults = var.eks_managed_node_group_defaults
  eks_managed_node_groups         = var.eks_managed_node_groups
  manage_aws_auth_configmap       = var.manage_aws_auth_configmap

  aws_auth_roles = [
    {
      groups   = ["system:masters"]
      rolearn  = aws_iam_role.eks_admin_role.arn
      username = "eks-admin"
    },
  ]

  tags = var.tags
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}