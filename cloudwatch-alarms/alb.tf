resource "aws_cloudwatch_metric_alarm" "httpcode_elb_5xx_count" {
  alarm_name          = "alb-5XX"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "5"
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1"
  treat_missing_data  = "notBreaching"

  alarm_actions = [
    "${var.slack_sns_arn}",
  ]

  ok_actions = [
    "${var.slack_sns_arn}",
  ]

  insufficient_data_actions = []

  dimensions = {
    "LoadBalancerName" = "${var.dimensions_map["LoadBalancer"]}"
  }
}

resource "aws_cloudwatch_metric_alarm" "httpcode_target_5xx_count" {
  alarm_name          = "alb-target-5XX"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "5"
  metric_name         = "HTTPCode_Target_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1"
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

resource "aws_cloudwatch_metric_alarm" "elb_rejected_connections" {
  alarm_name          = "alb-rejected_connections"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "5"
  metric_name         = "RejectedConnectionCount"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1"
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

resource "aws_cloudwatch_metric_alarm" "unhealthy_host_count" {
  alarm_name          = "alb-unhealthy-target"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Average"
  threshold           = "0"
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
