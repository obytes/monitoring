locals {
  prefix           = "${var.prefix}-slack-notify"
  iam_policy_name  = "${local.prefix}-lambda-policy"
  iam_role_name    = "${local.prefix}-lambda-role"
  iam_profile_name = "${local.prefix}-lambda-profile"
}
