resource "aws_iam_user" "terraform_user" {
  name = "${var.project_name}-${var.environment}-user"

  tags = var.common_tags
}

resource "aws_iam_group" "devops_group" {
  name = "${var.project_name}-${var.environment}-group"
}

resource "aws_iam_policy" "ec2_policy" {
  name   = "${var.project_name}-${var.environment}-policy"
  policy = file("${path.module}/policies/ec2-policy.json")

  tags = var.common_tags
}

resource "aws_iam_group_policy_attachment" "group_policy" {
  group      = aws_iam_group.devops_group.name
  policy_arn = aws_iam_policy.ec2_policy.arn
}

resource "aws_iam_user_group_membership" "membership" {
  user = aws_iam_user.terraform_user.name

  groups = [
    aws_iam_group.devops_group.name
  ]
}

resource "aws_iam_role" "ec2_role" {
  name = "${var.project_name}-${var.environment}-ec2-role"

  assume_role_policy = file(
    "${path.module}/policies/assume-role-policy.json"
  )

  tags = var.common_tags
}

resource "aws_iam_role_policy_attachment" "role_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_policy.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.project_name}-${var.environment}-profile"
  role = aws_iam_role.ec2_role.name
}