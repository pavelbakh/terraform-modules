output "layer_arn" {
  description = "ARN of the lambda layer"
  value = aws_lambda_layer_version.this.layer_arn
}

output "layer_version" {
  value = aws_lambda_layer_version.this.version
}