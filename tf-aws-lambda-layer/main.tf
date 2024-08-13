# Description: This module creates a Lambda Layer.

locals {
  fully_qualified_name = "${module.name.id}-${var.layer_name}"
}

module "name" {
  source      = "git::https://github.com/devoteam/terraform-modules.git//tf-label"
  namespace   = var.namespace
  environment = var.environment
  project     = var.project
  component   = var.component
  label_case  = var.label_case
}

resource "aws_lambda_layer_version" "this" {
  layer_name          = fully_qualified_name
  s3_key              = var.s3_key
  s3_bucket           = var.s3_bucket
  s3_object_version   = var.s3_object_version

  compatible_architectures = var.compatible_architectures
  compatible_runtimes = var.compatible_runtimes

  description = var.description
}
