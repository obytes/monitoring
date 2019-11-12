resource "aws_cloudwatch_metric_alarm" "free_storage_space" {
  alarm_name          = "rds-free-storage-space"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "5"
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Minimum"
  threshold           = "1000000000"
  treat_missing_data  = "notBreaching"

  alarm_actions = [
    "${var.slack_sns_arn}",
  ]

  ok_actions = [
    "${var.slack_sns_arn}",
  ]

  insufficient_data_actions = []

  dimensions = "${var.dimensions_map}"
}
