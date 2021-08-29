data "archive_file" "init" {
  type        = "zip"
  source_file = "ec2-stop.py"
  output_path = "ec2-stop.zip"
}

resource "aws_lambda_function" "ec2-start-stop" {
  filename      = "ec2-stop.zip"
  function_name = "demo"
  role          = aws_iam_role.lambda_role.arn
  handler       = "demo.lambda_handler"

  runtime = "python3.8"

  
}
data "archive_file" "init1" {
  type        = "zip"
  source_file = "ec2-start.py"
  output_path = "ec2-start.zip"
}

resource "aws_lambda_function" "ec2-start-stop1" {
  filename      = "ec2-start.zip"
  function_name = "ec2-start"
  role          = aws_iam_role.lambda_role.arn
  handler       = "ec2-start.lambda_handler"

  runtime = "python3.8"

  
}