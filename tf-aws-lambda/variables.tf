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

variable "filename" {
  type        = string
  default     = null
  description = "The path to the function's deployment package within the local filesystem. Exactly one of filename or s3_bucket must be specified."
}

variable "s3_bucket" {
  type        = string
  default     = null
  description = <<EOF
  The S3 bucket location containing the function's deployment package. Exactly one of filename or s3_bucket must be specified.
  This bucket must reside in the same AWS region where you are creating the Lambda function.
  EOF
}

variable "s3_key" {
  type        = string
  default     = null
  description = "The S3 key of an object containing the function's deployment package. Only if s3_bucket is specified."
}

variable "s3_object_version" {
  type        = string
  default     = null
  description = "The object version containing the function's deployment package. Only if s3_bucket is specified."
}

variable "function_name" {
  type        = string
  description = "Unique name for the Lambda Function."
}

variable "description" {
  type        = string
  default     = null
  description = "Description of what the Lambda Function does."
}

variable "architectures" {
  type        = list(string)
  default     = null
  description = <<EOF
    Instruction set architecture for the Lambda function. Valid values are ["x86_64"] and ["arm64"].
    Default is ["x86_64"].
  EOF
}

variable "handler" {
  type        = string
  default     = null
  description = "The function entrypoint in your code."
}

variable "memory_size" {
  type        = number
  default     = 128
  description = "Amount of memory in MB the Lambda Function can use at runtime."
}

variable "ephemeral_storage_size" {
  type        = number
  default     = null
  description = <<EOF
  The size of the Lambda function Ephemeral storage (/tmp) represented in MB.
  The minimum supported ephemeral_storage value defaults to 512MB and the maximum supported value is 10240MB.
  EOF
}

variable "reserved_concurrent_executions" {
  type        = number
  default     = -1
  description = "The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations."
}

variable "runtime" {
  type        = string
  default     = null
  description = "The runtime environment for the Lambda function you are uploading."
}

variable "timeout" {
  type        = number
  default     = 3
  description = "The amount of time the Lambda Function has to run in seconds."
}

variable "layers" {
  type        = list(string)
  default     = []
  description = "List of Lambda Layer Version ARNs (maximum of 5) to attach to the Lambda Function."
}

variable "cloudwatch_logs_retention_in_days" {
  type        = number
  default     = null
  description = <<EOF
  Specifies the number of days you want to retain log events in the specified log group. Possible values are:
  1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the
  log group are always retained and never expire.
  EOF
}

variable "lambda_environment" {
  type = object({
    variables = map(string)
  })
  default     = null
  description = "Map of environment variables that are accessible from the function code during execution. If provided at least one key must be present."
}

variable "inline_iam_policy" {
  type        = string
  description = "Inline policy document (JSON) to attach to the lambda role"
  default     = null
}