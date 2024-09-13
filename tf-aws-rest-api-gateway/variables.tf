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

# See https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-swagger-extensions.html for additional 
# configuration information.
variable "openapi_config" {
  description = "The OpenAPI specification for the API"
  type        = any
  default     = {}
}

variable "endpoint_type" {
  type        = string
  description = "The type of the endpoint. One of - PUBLIC, PRIVATE, REGIONAL"
  default     = "REGIONAL"

  validation {
    condition     = contains(["EDGE", "REGIONAL", "PRIVATE"], var.endpoint_type)
    error_message = "Valid values for var: endpoint_type are (EDGE, REGIONAL, PRIVATE)."
  }
}

variable "logging_level" {
  type        = string
  description = "The logging level of the API. One of - OFF, INFO, ERROR"
  default     = "INFO"

  validation {
    condition     = contains(["OFF", "INFO", "ERROR"], var.logging_level)
    error_message = "Valid values for var: logging_level are (OFF, INFO, ERROR)."
  }
}

variable "metrics_enabled" {
  description = "A flag to indicate whether to enable metrics collection."
  type        = bool
  default     = false
}

variable "xray_tracing_enabled" {
  description = "A flag to indicate whether to enable X-Ray tracing."
  type        = bool
  default     = false
}

variable "data_trace_enabled" {
  description = "Whether data trace logging is enabled for this method, which effects the log entries pushed to Amazon CloudWatch Logs."
  type        = bool
  default     = false
}

# See https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-logging.html for details.
variable "access_log_format" {
  type        = string
  default     = <<EOF
  {
  "requestId":"$context.requestId", 
  "extendedRequestId":"$context.extendedRequestId",
  "ip": "$context.identity.sourceIp", 
  "caller":"$context.identity.caller", 
  "user":"$context.identity.user", 
  "requestTime":"$context.requestTime", 
  "httpMethod":"$context.httpMethod", 
  "resourcePath":"$context.resourcePath", 
  "status":"$context.status", 
  "protocol":"$context.protocol", 
  "responseLength":"$context.responseLength"
}
  EOF
  description = "The format of the access log file."
}

# See https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-resource-policies-examples.html for details
# Example: Deny API traffic based on source IP address or range
#{
#    "Version": "2012-10-17",
#    "Statement": [
#        {
#            "Effect": "Allow",
#            "Principal": "*",
#            "Action": "execute-api:Invoke",
#            "Resource": [
#                "execute-api:/*"
#            ]
#        },
#        {
#            "Effect": "Deny",
#            "Principal": "*",
#            "Action": "execute-api:Invoke",
#            "Resource": [
#               "execute-api:/*"
#            ],
#            "Condition" : {
#                "IpAddress": {
#                    "aws:SourceIp": ["192.0.2.0/24", "198.51.100.0/24" ]
#                }
#            }
#        }
#    ]
#}
variable "rest_api_policy" {
  type        = string
  default     = null
  description = "The IAM policy document for the API."
}

variable "stage_name" {
  type        = string
  default     = ""
  description = "The name of the stage"
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