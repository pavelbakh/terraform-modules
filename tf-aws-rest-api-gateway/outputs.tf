output "arn" {
  description = "The ARN of the REST API"
  value       = aws_api_gateway_rest_api.this.arn
}

output "stage_arn" {
  description = "The ARN of the gateway stage"
  value       = aws_api_gateway_stage.this.arn
}

output "api_url" {
  description = "The URL to invoke the REST API"
  value       = aws_api_gateway_stage.this.invoke_url
}
