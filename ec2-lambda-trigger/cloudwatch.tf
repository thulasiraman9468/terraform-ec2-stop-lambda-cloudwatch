resource "aws_cloudwatch_event_rule" "ec2-stop" {
    name        = "ec2-rule"
    description = "Trigger EC2 stop every 5 min"
    schedule_expression = "rate(3 minutes)"
    
}

resource "aws_cloudwatch_event_target" "lambda-func" {
  target_id = "lambda"
  rule      = aws_cloudwatch_event_rule.ec2-stop.name
  arn       = aws_lambda_function.ec2-start-stop.arn
  input     = "{\"type\":\"stop\", \"id\":\"ec2-instance-id\"}"
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ec2-start-stop.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ec2-stop.arn
}
resource "aws_cloudwatch_event_rule" "ec2-start" {
    name        = "ec2-rule1"
    description = "Trigger EC2 start every 1 min"
    schedule_expression = "rate(8 minutes)"
}

resource "aws_cloudwatch_event_target" "lambda-func1" {
  target_id = "lambda"
  rule      = aws_cloudwatch_event_rule.ec2-start.name
  arn       = aws_lambda_function.ec2-start-stop1.arn
  input     = "{\"type\":\"start\", \"id\":\"ec2-instance-id\"}"
}

resource "aws_lambda_permission" "allow_cloudwatch1" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ec2-start-stop1.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ec2-start.arn
}