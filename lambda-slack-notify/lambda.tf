resource "aws_lambda_permission" "sns_notify_slack" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.function.function_name}"
  principal     = "sns.amazonaws.com"
  source_arn    = "${aws_sns_topic.slack.arn}"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/sources/main.py"
  output_path = "${path.module}/sources/${local.prefix}/.zip/main.zip"
}

resource "aws_lambda_function" "function" {
  filename = "${data.archive_file.lambda_zip.0.output_path}"

  function_name = "${local.prefix}"

  role             = "${aws_iam_role.role.arn}"
  handler          = "${var.handler}"
  source_code_hash = "${data.archive_file.lambda_zip.0.output_base64sha256}"
  runtime          = "${var.runtime}"
  timeout          = "${var.timeout}"
  kms_key_arn      = "${var.kms_arn}"

  environment {
    variables = {
      SLACK_WEBHOOK_URL = "${var.slack_webhook_url}"
      SLACK_CHANNEL     = "${var.slack_channel}"
      SLACK_USERNAME    = "${var.slack_username}"
      SLACK_EMOJI       = "${var.slack_emoji}"
    }
  }

  lifecycle {
    ignore_changes = [
      "last_modified",
    ]
  }
}
