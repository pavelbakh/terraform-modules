# Description: This module is used to generate labels and tags for resources in Terraform.
terraform {
  required_version = ">= 0.13.0"
}

locals {
  create_log_group = var.logging_level != "OFF"
  stage_name       = var.stage_name != "" ? var.stage_name : var.environment
}

data "template_file" "this" {
  template = var.api_template

  vars = var.api_template_vars
}

module "name" {
  source      = "../tf-label"
  namespace   = var.namespace
  environment = var.environment
  project     = var.project
  component   = var.component
  label_case  = var.label_case
  tags        = var.tags
}

resource "aws_api_gateway_rest_api" "this" {
  name = module.name.id
  body = data.template_file.this.rendered
  tags = module.name.tags

  endpoint_configuration {
    types = [var.endpoint_type]
  }
}

resource "aws_api_gateway_rest_api_policy" "this" {
  count       = var.rest_api_policy != null ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.this.id

  policy = var.rest_api_policy
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.this.body))
  }

  lifecycle {
    create_before_destroy = true
  }
  depends_on = [aws_api_gateway_rest_api_policy.this]
}

resource "aws_api_gateway_stage" "this" {
  deployment_id        = aws_api_gateway_deployment.this.id
  rest_api_id          = aws_api_gateway_rest_api.this.id
  stage_name           = local.stage_name
  xray_tracing_enabled = var.xray_tracing_enabled
  tags                 = module.name.tags

  dynamic "access_log_settings" {
    for_each = local.create_log_group ? [1] : []

    content {
      destination_arn = aws_cloudwatch_log_group.this[0].arn
      format          = replace(var.access_log_format, "\n", "")
    }
  }
}

resource "aws_cloudwatch_log_group" "this" {
  count = local.create_log_group ? 1 : 0

  name              = "${aws_api_gateway_rest_api.this.id}/${local.stage_name}"
  retention_in_days = var.cloudwatch_logs_retention_in_days
}

resource "aws_api_gateway_method_settings" "all" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  stage_name  = aws_api_gateway_stage.this.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled    = var.metrics_enabled
    logging_level      = var.logging_level
    data_trace_enabled = var.data_trace_enabled
  }
}
