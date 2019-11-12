variable "prefix" {}

variable "kms_arn" {}

# slack
variable "slack_webhook_url" {}

variable "slack_channel" {}
variable "slack_username" {}

variable "slack_emoji" {
  default = ""
}

# lambda
variable "runtime" {
  default = "python3.6"
}

variable "timeout" {
  default = 30
}

variable "handler" {
  default = "main.handler"
}

variable "description" {
  default = ""
}

variable "path" {
  default = "/"
}
