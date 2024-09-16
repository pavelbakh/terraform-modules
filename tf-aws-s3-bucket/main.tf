# Description: This module is used to create a S3 bucket.
terraform {
  required_version = ">= 0.13.0"
}

data "aws_partition" "current" {}

locals {
  partition   = join("", data.aws_partition.current[*].partition)

  full_name   = var.bucket_name != "" && !var.include_prefix ? var.bucket_name : "${module.name.id}-${var.bucket_name}"
  bucket_name = var.include_account_id ? "${local.partition}-${local.full_name}" : local.full_name
  bucket_id   = join("", aws_s3_bucket.this[*].id)
  bucket_arn  = "arn:${local.partition}:s3:::${local.bucket_id}"
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

resource "aws_s3_bucket" "this" {
  bucket  = local.bucket_name

  tags    = module.name.tags
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = local.bucket_id

  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = local.bucket_id

  rule {
    bucket_key_enabled = var.bucket_key_enabled

    apply_server_side_encryption_by_default {
      sse_algorithm     = var.sse_algorithm
      kms_master_key_id = var.kms_master_key_arn
    }
  }
}

data "aws_iam_policy_document" "bucket_policy" {
  dynamic "statement" {
    for_each = var.allow_encrypted_uploads_only ? [1] : []

    content {
      sid       = "DenyIncorrectEncryptionHeader"
      effect    = "Deny"
      actions   = ["s3:PutObject"]
      resources = ["${local.bucket_arn}/*"]

      principals {
        identifiers = ["*"]
        type        = "*"
      }

      condition {
        test     = "StringNotEquals"
        values   = [var.sse_algorithm]
        variable = "s3:x-amz-server-side-encryption"
      }
    }
  }

  dynamic "statement" {
    for_each = var.allow_encrypted_uploads_only ? [1] : []

    content {
      sid       = "DenyUnEncryptedObjectUploads"
      effect    = "Deny"
      actions   = ["s3:PutObject"]
      resources = ["${local.bucket_arn}/*"]

      principals {
        identifiers = ["*"]
        type        = "*"
      }

      condition {
        test     = "Null"
        values   = ["true"]
        variable = "s3:x-amz-server-side-encryption"
      }
    }
  }

  dynamic "statement" {
    for_each = var.allow_ssl_requests_only ? [1] : []

    content {
      sid       = "ForceSSLOnlyAccess"
      effect    = "Deny"
      actions   = ["s3:*"]
      resources = [local.bucket_arn, "${local.bucket_arn}/*"]

      principals {
        identifiers = ["*"]
        type        = "*"
      }

      condition {
        test     = "Bool"
        values   = ["false"]
        variable = "aws:SecureTransport"
      }
    }
  }

  dynamic "statement" {
    for_each = var.minimum_tls_version != null ? toset([var.minimum_tls_version]) : toset([])

    content {
      sid       = "EnforceTLSVersion"
      effect    = "Deny"
      actions   = ["s3:*"]
      resources = [local.bucket_arn, "${local.bucket_arn}/*"]

      principals {
        identifiers = ["*"]
        type        = "*"
      }

      condition {
        test     = "NumericLessThan"
        values   = [statement.value]
        variable = "s3:TlsVersion"
      }
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  count = (
    var.allow_ssl_requests_only ||
    var.allow_encrypted_uploads_only
  ) ? 1 : 0

  bucket     = local.bucket_id
  policy     = one(data.aws_iam_policy_document.bucket_policy[*].json)
  depends_on = [aws_s3_bucket_public_access_block.this]
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = local.bucket_id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}
