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
  default     = null
  description = "Delimiter between ID elements."
}

variable "label_case" {
  type        = string
  default     = null
  description = "Letter case of label elements"

  validation {
    condition     = var.label_case == null ? true : contains(["lower", "upper"], var.label_case)
    error_message = "Allowed values: `lower`, `upper`."
  }
}

variable "table_name" {
  type        = string
  default     = null
  description = "Table name. If provided, the dynamodb table will be created with this name instead of generating the name from the variables"
}

variable "billing_mode" {
  type        = string
  default     = "PAY_PER_REQUEST"
  description = "DynamoDB Billing mode. Can be PROVISIONED or PAY_PER_REQUEST"
}

variable "read_capacity" {
  type        = number
  default     = 5
  description = "Number of read units for this table. If the billing_mode is PROVISIONED, this field is required."
}

variable "write_capacity" {
  type        = number
  default     = 5
  description = "Number of write units for this table. If the billing_mode is PROVISIONED, this field is required."
}

variable "enable_streams" {
  type        = bool
  default     = false
  description = "Enable DynamoDB streams"
}

variable "stream_view_type" {
  type        = string
  default     = ""
  description = "Valid values are KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES."
}

variable "enable_encryption" {
  type        = bool
  default     = true
  description = "Enable DynamoDB server-side encryption"
}

variable "server_side_encryption_kms_key_arn" {
  type        = string
  default     = null
  description = "The ARN of the CMK that should be used for the AWS KMS encryption. This attribute should only be specified if the key is different from the default DynamoDB CMK, alias/aws/dynamodb."
}

variable "hash_key" {
  type        = string
  description = "DynamoDB table Hash Key"
}

variable "hash_key_type" {
  type        = string
  default     = "S"
  description = "Hash Key type, which must be a scalar type: `S`, `N`, or `B` for (S)tring, (N)umber or (B)inary data"
}

variable "range_key" {
  type        = string
  default     = ""
  description = "DynamoDB table Range Key"
}

variable "range_key_type" {
  type        = string
  default     = "S"
  description = "Range Key type, which must be a scalar type: `S`, `N`, or `B` for (S)tring, (N)umber or (B)inary data"
}

variable "ttl_attribute" {
  type        = string
  default     = "Expires"
  description = "Name of the table attribute to store the TTL timestamp in. Required if enabled is true, must not be set otherwise."
}

variable "ttl_enabled" {
  type        = bool
  default     = false
  description = "Whether TTL is enabled. Default value is false."
}

variable "dynamodb_attributes" {
  type = list(object({
    name = string
    type = string
  }))
  default     = []
  description = "Additional DynamoDB attributes in the form of a list of mapped values"
}

variable "global_secondary_index_map" {
  type = list(object({
    hash_key           = string
    name               = string
    non_key_attributes = list(string)
    projection_type    = string
    range_key          = string
    read_capacity      = number
    write_capacity     = number
  }))
  default     = []
  description = "Additional global secondary indexes in the form of a list of mapped values"
}

variable "local_secondary_index_map" {
  type = list(object({
    name               = string
    non_key_attributes = list(string)
    projection_type    = string
    range_key          = string
  }))
  default     = []
  description = "Additional local secondary indexes in the form of a list of mapped values"
}

variable "table_class" {
  type        = string
  default     = "STANDARD"
  description = "Storage class of the table. Valid values are STANDARD and STANDARD_INFREQUENT_ACCESS. Default value is STANDARD."
}

