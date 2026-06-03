resource "aws_iam_user" "terraform_user" {
  name = "terraform-user"
}
resource "aws_iam_group" "devops_group" {
  name = "devops-group"
}
resource "aws_iam_policy" "custom_policy" {
  name = "terraform-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action   = "*"
      Effect   = "Allow"
      Resource = "*"
    }]
  })
}
resource "aws_iam_group_policy_attachment" "attach_policy" {
  group      = aws_iam_group.devops_group.name
  policy_arn = aws_iam_policy.custom_policy.arn
}
resource "aws_iam_user_group_membership" "group_membership" {
  user = aws_iam_user.terraform_user.name

  groups = [
    aws_iam_group.devops_group.name
  ]
}
##IAM Role
resource "aws_iam_role" "terraform_role" {
  name = "terraform-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "ec2.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })
}

# Attach Policy to Role

resource "aws_iam_role_policy_attachment" "role_policy_attach" {
  role       = aws_iam_role.terraform_role.name
  policy_arn = aws_iam_policy.custom_policy.arn
}