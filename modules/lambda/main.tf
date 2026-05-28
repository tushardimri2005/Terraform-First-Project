resource "aws_lambda_function" "lambda" {
  function_name = "terraform_lambda"

  role = aws_iam_role.lambda_role.arn
  handler = "lambda_function.lambda_handler"
  runtime = "python3.9"

  filename = "lambda.zip"
}