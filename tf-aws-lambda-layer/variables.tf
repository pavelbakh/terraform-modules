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

variable "s3_bucket" {
  type        = string
  description = <<EOF
  The S3 bucket location containing the function's deployment package. Conflicts with filename and image_uri.
  This bucket must reside in the same AWS region where you are creating the Lambda function.
  EOF
  default     = null
}

variable "s3_key" {
  type        = string
  description = "The S3 key of an object containing the function's deployment package. Conflicts with filename and image_uri."
  default     = null
}

variable "s3_object_version" {
  type        = string
  description = "The object version containing the function's deployment package. Conflicts with filename and image_uri."
  default     = null
}

variable "layer_name" {
  type        = string
  description = "Layer name"
  default     = null
}

variable "description" {
  type        = string
  description = "Description of the Lambda layer."
  default     = null
}

variable "compatible_architectures" {
  type        = list(string)
  description = "List of Architectures this layer is compatible with. Currently x86_64 and arm64 can be specified."
  default     = null
}

variable "compatible_runtimes" {
  type        = list(string)
  description = "List of Runtimes this layer is compatible with. Up to 15 runtimes can be specified."
  default     = null
}
