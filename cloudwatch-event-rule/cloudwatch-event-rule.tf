resource "aws_cloudwatch_event_rule" "pipe_state" {
  name        = "capture-aws-codepipeline-state"
  description = "Capture each AWS Codepipeline State"

  event_pattern = <<PATTERN
{
  "detail": {
    "state": [
      "STARTED",
      "FAILED",
      "SUCCEEDED"
    ]
  },
  "resources": [
    "arn:aws:codepipeline:<REGION>:<ACCOUNT_ID>:<PIPELINE_NAME>"
  ],
  "detail-type": [
    "CodePipeline Pipeline Execution State Change"
  ],
  "source": [
    "aws.codepipeline"
  ]
}
PATTERN
}

resource "aws_cloudwatch_event_target" "sns_pipe_state" {
  rule      = "${aws_cloudwatch_event_rule.pipe_state.name}"
  target_id = "SendToSNS"
  arn       = "${var.slack_sns_arn}"

  input_transformer {
    input_paths {
      pipeline = "$.detail.pipeline"
      state    = "$.detail.state"
    }

    input_template = "\"The pipeline *<pipeline>* has *<state>*.\""
  }
}
