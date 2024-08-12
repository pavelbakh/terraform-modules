# Terraform module tf-aws-lambda

This module deploys an AWS Lambda function from a Zip file uploaded to AWS S3 bucket. Additionally, it creates an IAM role for the Lambda function, which attaches policies to allow for CloudWatch Logs.

## Usage

```
module "lambda" {
  source  = "devoteam/terraform-modules/tf-aws-lambda"

  namespace         = "devoteam"
  environment       = "prod"
  project           = "genai"
  component         = "api"

  s3_bucket         = "genai_production"
  s3_key            = "lambda_1"
  s3_object_version = "1.0"
  function_name     = "ingest_data"
  handler           = "ingest_data.handler"
  runtime           = "python3.12"
  layers            = "lambda_layer_1"
}
```