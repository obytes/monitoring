resource "aws_cloudwatch_log_group" "lambda_slack_notify" {
  name              = "/aws/lambda/${local.prefix}"
  retention_in_days = 30
}
