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

variable "filename" {
  type        = string
  description = "The path to the function's deployment package within the local filesystem. Exactly one of filename or s3_bucket must be specified."
  default     = null
}

variable "s3_bucket" {
  type        = string
  description = <<EOF
  The S3 bucket location containing the function's deployment package. Exactly one of filename or s3_bucket must be specified.
  This bucket must reside in the same AWS region where you are creating the Lambda function.
  EOF
  default     = null
}

variable "s3_key" {
  type        = string
  description = "The S3 key of an object containing the function's deployment package. Only if s3_bucket is specified."
  default     = null
}

variable "s3_object_version" {
  type        = string
  description = "The object version containing the function's deployment package. Only if s3_bucket is specified."
  default     = null
}

variable "function_name" {
  type        = string
  description = "Unique name for the Lambda Function."
}

variable "description" {
  type        = string
  description = "Description of what the Lambda Function does."
  default     = null
}

variable "architectures" {
  type        = list(string)
  description = <<EOF
    Instruction set architecture for the Lambda function. Valid values are ["x86_64"] and ["arm64"].
    Default is ["x86_64"].
  EOF
  default     = null
}

variable "handler" {
  type        = string
  description = "The function entrypoint in your code."
  default     = null
}

variable "memory_size" {
  type        = number
  description = "Amount of memory in MB the Lambda Function can use at runtime."
  default     = 128
}

variable "ephemeral_storage_size" {
  type        = number
  description = <<EOF
  The size of the Lambda function Ephemeral storage (/tmp) represented in MB.
  The minimum supported ephemeral_storage value defaults to 512MB and the maximum supported value is 10240MB.
  EOF
  default     = null
}

variable "reserved_concurrent_executions" {
  type        = number
  description = "The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations."
  default     = -1
}

variable "runtime" {
  type        = string
  description = "The runtime environment for the Lambda function you are uploading."
  default     = null
}

variable "timeout" {
  type        = number
  description = "The amount of time the Lambda Function has to run in seconds."
  default     = 3
}

variable "layers" {
  type        = list(string)
  description = "List of Lambda Layer Version ARNs (maximum of 5) to attach to the Lambda Function."
  default     = []
}

variable "cloudwatch_logs_retention_in_days" {
  type        = number
  description = <<EOF
  Specifies the number of days you want to retain log events in the specified log group. Possible values are:
  1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the
  log group are always retained and never expire.
  EOF
  default     = null
}

variable "lambda_environment" {
  type = object({
    variables = map(string)
  })
  description = "Map of environment variables that are accessible from the function code during execution. If provided at least one key must be present."
  default     = null
}

variable "custom_iam_policy_arns" {
  type        = set(string)
  description = "ARNs of custom policies to be attached to the lambda role"
  default     = []
}