output "layer_arn" {
  description = "ARN of the lambda layer"
  value = aws_lambda_layer_version.layer.arn
}