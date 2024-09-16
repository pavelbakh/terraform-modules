# Description: This module creates an AWS DynamoDB table.
terraform {
  required_version = ">= 0.13.0"
}

locals {
  fully_qualified_name = "${module.name.id}-${var.table_name}"
  attributes = concat(
    [
      {
        name = var.hash_key
        type = var.hash_key_type
      }
    ],
    var.dynamodb_attributes
  )
  attributes_final = length(var.range_key) == 0 ? local.attributes : concat(
    local.attributes,
    [
      {
        name = var.range_key
        type = var.range_key_type
      }
    ]
  )
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

resource "aws_dynamodb_table" "default" {
  name                        = local.fully_qualified_name
  billing_mode                = var.billing_mode
  read_capacity               = var.billing_mode == "PAY_PER_REQUEST" ? null : var.read_capacity
  write_capacity              = var.billing_mode == "PAY_PER_REQUEST" ? null : var.write_capacity
  hash_key                    = var.hash_key
  range_key                   = var.range_key
  stream_enabled              = var.enable_streams
  stream_view_type            = var.enable_streams ? var.stream_view_type : ""
  table_class                 = var.table_class

  lifecycle {
    ignore_changes = [
      read_capacity,
      write_capacity
    ]
  }
  
  server_side_encryption {
    enabled     = var.enable_encryption
    kms_key_arn = var.server_side_encryption_kms_key_arn
  }

  dynamic "attribute" {
    for_each = local.attributes_final
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_index_map
    content {
      hash_key           = global_secondary_index.value.hash_key
      name               = global_secondary_index.value.name
      non_key_attributes = lookup(global_secondary_index.value, "non_key_attributes", null)
      projection_type    = global_secondary_index.value.projection_type
      range_key          = lookup(global_secondary_index.value, "range_key", null)
      read_capacity      = lookup(global_secondary_index.value, "read_capacity", null)
      write_capacity     = lookup(global_secondary_index.value, "write_capacity", null)
    }
  }

  dynamic "local_secondary_index" {
    for_each = var.local_secondary_index_map
    content {
      name               = local_secondary_index.value.name
      non_key_attributes = lookup(local_secondary_index.value, "non_key_attributes", null)
      projection_type    = local_secondary_index.value.projection_type
      range_key          = local_secondary_index.value.range_key
    }
  }

  ttl {
    enabled        = var.ttl_attribute != "" ? var.ttl_enabled : false
    attribute_name = var.ttl_attribute
  }

  tags = module.name.tags
}