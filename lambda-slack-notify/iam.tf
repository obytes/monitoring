data "aws_iam_policy_document" "role" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }

  statement {
    actions = [
      "lambda:InvokeFunction",
    ]

    resources = [
      "${aws_lambda_function.function.arn}"
    ]
  }

  statement {
    actions = [
      "sns:Publish",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt"
    ]

    resources = [
      "${var.kms_arn}"
    ]
  }
}

resource "aws_iam_policy" "policy" {
  name   = "${local.iam_policy_name}"
  path   = "${var.path}"
  policy = "${data.aws_iam_policy_document.policy.json}"
}

resource "aws_iam_role" "role" {
  name               = "${local.iam_role_name}"
  assume_role_policy = "${data.aws_iam_policy_document.role.json}"
  description        = "${var.description}"
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  policy_arn = "${aws_iam_policy.policy.arn}"
  role       = "${aws_iam_role.role.name}"
}
