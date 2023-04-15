data "aws_eks_cluster_auth" "eks_auth" {
  name = module.eks.cluster_name
}

data "aws_iam_policy_document" "inline_policy" {
  statement {
    effect = "Allow"
    actions = [
      "eks:Describe*",
      "eks:List*",
      "eks:Get*",
      "eks:Update*",
      "eks:Create*",
      "eks:Delete*",
      "eks:TagResource",
      "eks:UntagResource",
    ]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = [aws_iam_group.eks_admin_group.arn]
    }
  }
}