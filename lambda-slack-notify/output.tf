output "sns_arn" {
  value = "${aws_sns_topic.slack.arn}"
}

output "sns_name" {
  value = "${aws_sns_topic.slack.name}"
}
