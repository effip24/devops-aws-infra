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
resource "aws_iam_policy" "eks_admin_policy" {
  name = "eks-admin-policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "eks:*",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "ec2:*",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "elasticloadbalancing:*",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "autoscaling:*",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "cloudwatch:*",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "iam:*",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "logs:*",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "s3:*",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "secretsmanager:*",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "sns:*",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "cloudformation:*",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "route53:*",
        "Resource" : "*"
      }
    ]
    }
  )
}
resource "aws_iam_group" "eks_admin_group" {
  name = "eks-admin-group"
}
resource "aws_iam_policy_attachment" "eks_admin_assume_role_policy_attachment" {
  name       = "eks-admin-assume-role-policy-attachment"
  policy_arn = aws_iam_policy.eks_admin_policy.arn
  groups     = [aws_iam_group.eks_admin_group.name]
}
resource "aws_iam_policy_attachment" "eks_admin__policy_attachment" {
  name       = "eks-admin-admin-policy-attachment"
  policy_arn = aws_iam_policy.eks_admin_assume_role_policy.arn
  groups     = [aws_iam_group.eks_admin_group.name]
}

# Developer role, policy and group ----------
resource "aws_iam_role" "eks_developer_role" {
  name        = "eks-developer-role"
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
resource "aws_iam_policy" "eks_developer_assume_role_policy" {
  name = "eks-developer-assume-role-policy"
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
          aws_iam_role.eks_developer_role.arn
        ]
      }
    ]
  })
}
resource "aws_iam_policy" "eks_developer_policy" {
  name = "eks-developer-policy"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "EksClusterAccess",
          "Effect" : "Allow",
          "Action" : [
            "eks:DescribeCluster"
          ],
          "Resource" : "*"
        }
      ]
    }

  )
}
resource "aws_iam_group" "eks_developer_group" {
  name = "eks-developer-group"
}
resource "aws_iam_policy_attachment" "eks_developer_assume_role_policy_attachment" {
  name       = "eks-developer-assume-role-policy-attachment"
  policy_arn = aws_iam_policy.eks_developer_assume_role_policy.arn
  groups     = [aws_iam_group.eks_developer_group.name]
}
resource "aws_iam_policy_attachment" "eks_developer_policy_attachment" {
  name       = "eks-developer-policy-attachment"
  policy_arn = aws_iam_policy.eks_developer_policy.arn
  groups     = [aws_iam_group.eks_developer_group.name]
}
