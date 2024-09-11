variable "namespace" {
  type        = string
  default     = null
  description = "The organization name, e.g. 'devoteam'"
}

variable "environment" {
  type        = string
  default     = null
  description = "The stage name 'prod', 'staging', 'dev', 'test'"
}

variable "project" {
  type        = string
  default     = null
  description = "The project name, e.g. 'genai'."
}

variable "component" {
  type        = string
  default     = null
  description = "The component name, e.g. 'api'."
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter between ID elements."
}

variable "label_case" {
  type        = string
  default     = "lower"
  description = "Letter case of label elements"

  validation {
    condition     = var.label_case == null ? true : contains(["lower", "upper"], var.label_case)
    error_message = "Allowed values: `lower`, `upper`."
  }
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional custom tags (e.g. `{'Billing': 'Department_1'}`)."
}

variable "bucket_name" {
  type        = string
  default     = ""
  description = "Bucket name."
}

variable "include_prefix" {
  type        = bool
  default     = false
  description = "Include generated full qualified prefix in the bucket name."
}

variable "include_account_id" {
  type        = bool
  default     = true
  description = "Include AWS account ID in the bucket name."
}

variable "versioning_enabled" {
  type        = bool
  default     = false
  description = "Enable controlling versioning objects into an S3 bucket"
}

variable "sse_algorithm" {
  type        = string
  default     = "AES256"
  description = "The server-side encryption algorithm to use. Valid values are `AES256` and `aws:kms`"
}

variable "kms_master_key_arn" {
  type        = string
  default     = ""
  description = "The AWS KMS master key ARN used for the `SSE-KMS` encryption. This can only be used when you set the value of `sse_algorithm` as `aws:kms`. The default aws/s3 AWS KMS master key is used if this element is absent while the `sse_algorithm` is `aws:kms`"
}

variable "allow_encrypted_uploads_only" {
  type        = bool
  default     = false
  description = "Set to `true` to prevent uploads of unencrypted objects to S3 bucket"
}

variable "allow_ssl_requests_only" {
  type        = bool
  default     = false
  description = "Set to `true` to require requests to use Secure Socket Layer (HTTPS/SSL). This will explicitly deny access to HTTP requests"
}

variable "minimum_tls_version" {
  type        = string
  default     = null
  description = "Set the minimum TLS version for in-transit traffic"
}

variable "block_public_acls" {
  type        = bool
  default     = true
  description = "Set to `false` to disable the blocking of new public access lists on the bucket"
}

variable "block_public_policy" {
  type        = bool
  default     = true
  description = "Set to `false` to disable the blocking of new public policies on the bucket"
}

variable "ignore_public_acls" {
  type        = bool
  default     = true
  description = "Set to `false` to disable the ignoring of public access lists on the bucket"
}

variable "restrict_public_buckets" {
  type        = bool
  default     = true
  description = "Set to `false` to disable the restricting of making the bucket public"
}

variable "bucket_key_enabled" {
  type        = bool
  default     = false
  description = "Whether or not to use Amazon S3 Bucket Keys for SSE-KMS."
}
