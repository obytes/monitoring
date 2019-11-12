resource "aws_sns_topic" "slack" {
  name = "${local.prefix}-slack-topic"
}

resource "aws_sns_topic_subscription" "sns_notify_slack" {
  topic_arn = "${aws_sns_topic.slack.arn}"
  protocol  = "lambda"
  endpoint  = "${aws_lambda_function.function.arn}"
}

resource "aws_sns_topic_policy" "slack_policy" {
  arn = "${aws_sns_topic.slack.arn}"

  policy = "${data.aws_iam_policy_document.sns-topic-policy.json}"
}

data "aws_iam_policy_document" "sns-topic-policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        "${data.aws_caller_identity.current.account_id}",
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      "${aws_sns_topic.slack.arn}",
    ]

    sid = "__default_statement_ID"
  }

  statement {
    actions = [
      "SNS:Publish"
    ]


    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [
      "${aws_sns_topic.slack.arn}",
    ]

    sid = "AWSEvents_capture-aws-codepipeline-state_SendToSNS"
  }
}
