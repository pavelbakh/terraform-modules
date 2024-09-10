# Terraform module tf-aws-lambda

This module deploys an AWS Lambda function from a Zip file uploaded to AWS S3 bucket. Additionally, it creates an IAM role for the Lambda function, which attaches policies to allow for CloudWatch Logs.

## Usage

1. The zipped function is uploaded to S3 bucket.

```
module "lambda" {
  source  = "git::https://github.com/devoteam/terraform-modules.git//tf-aws-lambda"

  namespace         = "devoteam"
  environment       = "prod"
  project           = "genai"
  component         = "api"

  s3_bucket         = "genai_production"
  s3_key            = "lambda.zip"
  s3_object_version = "1.0"
  function_name     = "ingest_data"
  handler           = "ingest_data.handler"
  runtime           = "python3.12"
  layers            = "lambda_layer"
}
```

2. The zipped function is located within the local filesystem.


```
module "lambda" {
  source  = "git::https://github.com/devoteam/terraform-modules.git//tf-aws-lambda"

  namespace         = "devoteam"
  environment       = "prod"
  project           = "genai"
  component         = "api"

  filename          = "lambda.zip"
  function_name     = "ingest_data"
  handler           = "ingest_data.handler"
  runtime           = "python3.12"
  layers            = "lambda_layer"
}
```