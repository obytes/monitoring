# Monitoring

Source code for: 
- https://www.obytes.com/blog/monitoring-cloudwatch-key-metrics-using-slack-and-manage-them-using-terraform
- https://www.obytes.com/blog/monitoring-codepipeline-deployments

[lambda-slack-notify](lambda-slack-notify): Module to create a Lambda function for posting messages to Slack and a SNS topic subscribed to the Lambda.

[cloudwatch-alarms](cloudwatch-alarms): CloudWatch alarms for application key metrics.

[cloudwatch-event-rule](cloudwatch-event-rule): CloudWatch event rule to report CodePipeline statuses to Slack.