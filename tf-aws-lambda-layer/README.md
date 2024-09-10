# Terraform module tf-aws-lambda-layer

This module define an AWS Lambda function layer as a Zip file uploaded to AWS S3 bucket.

## Usage

1. The zipped layer code is uploaded to S3 bucket.

```
module "lambda-layer" {
  source  = "git::https://github.com/devoteam/terraform-modules.git//tf-aws-lambda-layer"

  namespace             = "devoteam"
  environment           = "prod"
  project               = "genai"
  component             = "api"

  s3_bucket             = "genai_production"
  s3_key                = "lambda_layer.zip"
  s3_object_version     = "1.0"
  layer_name            = "ingest_data"
  compatible_runtimes   = ["python3.12"]
}
```


1. The zipped layer code is located within the local filesystem.

```
module "lambda-layer" {
  source  = "git::https://github.com/devoteam/terraform-modules.git//tf-aws-lambda-layer"

  namespace             = "devoteam"
  environment           = "prod"
  project               = "genai"
  component             = "api"

  filename              = "lambda_layer.zip"
  layer_name            = "ingest_data"
  compatible_runtimes   = ["python3.12"]
}
```