# Description: This module creates an AWS Lambda function.
locals {
  fully_qualified_name = "${module.name.id}-${var.function_name}"
  partition   = data.aws_partition.this[0].partition
}

module "name" {
  source      = "git::https://github.com/devoteam/terraform-modules.git//modules/tf-label"
  namespace   = var.namespace
  environment = var.environment
  project     = var.project
  component   = var.component
  label_case  = var.label_case
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${local.fully_qualified_name}"
  retention_in_days = var.cloudwatch_logs_retention_in_days
  tags              = module.name.tags 
}


resource "aws_iam_role" "this" {
  name                 = local.fully_qualified_name
  assume_role_policy   = join("", data.aws_iam_policy_document.assume_role_policy[*].json)

  tags = module.name.tags
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = "lambda.amazonaws.com"
    }
  }
}

resource "aws_iam_role_policy_attachment" "cloudwatch_logs" {
  policy_arn = "arn:${local.partition}:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.this[0].name
}

resource "aws_lambda_function" "this" {
  function_name                  = local.fully_qualified_name
  handler                        = var.handler
  s3_bucket                      = var.s3_bucket
  s3_key                         = var.s3_key
  s3_object_version              = var.s3_object_version
  architectures                  = var.architectures
  description                    = var.description
  layers                         = var.layers
  memory_size                    = var.memory_size
  reserved_concurrent_executions = var.reserved_concurrent_executions
  role                           = aws_iam_role.this[0].arn
  runtime                        = var.runtime
  tags                           = name.tags
  timeout                        = var.timeout

  dynamic "ephemeral_storage" {
    for_each = var.ephemeral_storage_size != null ? [var.ephemeral_storage_size] : []
    content {
      size = var.ephemeral_storage_size
    }
  }
}

data "aws_partition" "this" {
  count = 1
}


