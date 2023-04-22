# Admin role, policy and group ----------
resource "aws_iam_role" "eks_admin_role" {
  name        = "eks-admin-role"
  description = "Role for managing EKS clusters"
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "arn:aws:iam::${var.account_id}:root"
          },
          "Action" : "sts:AssumeRole"
        }
      ]
    }
  )
}
resource "aws_iam_policy" "eks_admin_assume_role_policy" {
  name = "eks-admin-assume-role-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Sid" : "123",
        "Effect" : "Allow",
        "Action" : [
          "sts:AssumeRole"
        ],
        "Resource" : [
          aws_iam_role.eks_admin_role.arn
        ]
      }
    ]
  })
}
resource "aws_iam_group" "eks_admin_group" {
  name = "eks-admin-group"
}
resource "aws_iam_role_policy_attachment" "eks_admin_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_admin_role.name
}
resource "aws_iam_policy_attachment" "eks_admin_assume_role_policy_attachment" {
  name       = "eks-admin-assume-role-policy-attachment"
  policy_arn = aws_iam_policy.eks_admin_assume_role_policy.arn
  groups     = [aws_iam_group.eks_admin_group.name]
}

# Developer Policy 