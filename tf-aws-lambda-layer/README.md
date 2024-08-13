# Terraform module tf-aws-lambda-layer

This module define an AWS Lambda function layer as a Zip file uploaded to AWS S3 bucket.

## Usage

```
module "lambda-layer" {
  source  = "devoteam/terraform-modules/tf-aws-lambda-layer"

  namespace             = "devoteam"
  environment           = "prod"
  project               = "genai"
  component             = "api"

  s3_bucket             = "genai_production"
  s3_key                = "lambda_layer_1"
  s3_object_version     = "1.0"
  layer_name            = "ingest_data"
  compatible_runtimes   = ["python3.12"]
}
```