output "arn" {
  description = "ARN of the lambda function"
  value       = aws_lambda_function.this[0].arn
}

output "invoke_arn" {
  description = "Invoke ARN of the lambda function"
  value       = aws_lambda_function.this[0].invoke_arn
}

output "function_name" {
  description = "Lambda function name"
  value       = aws_lambda_function.this[0].function_name
}

output "role_name" {
  description = "Lambda IAM role name"
  value       = aws_iam_role.this[0].name
}

output "role_arn" {
  description = "Lambda IAM role ARN"
  value       = aws_iam_role.this[0].arn
}
