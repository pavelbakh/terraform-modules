provider "aws" {
  region = "eu-central-1" # Replace with your desired AWS region
  profile = "default" # Replace with your desired AWS profile
}

module "lambda_function" {
  source  = "git::https://github.com/devoteam/terraform-modules.git//tf-aws-lambda"

  namespace         = "devoteam"
  environment       = "prod"
  project           = "genai"
  component         = "api"

  s3_bucket         = "862879453668-terraform-modules"
  s3_key            = "lambdas/lambda_function.zip"
  function_name     = "example_lambda_function"
  description        = "Example Lambda Function"
  handler           = "lambda_function.lambda_handler"
  runtime           = "python3.12"

  layers = [
    "${module.lambda_layer.layer_arn}:${module.lambda_layer.layer_version}"
  ]
}

module "lambda_layer" {
  source  = "git::https://github.com/devoteam/terraform-modules.git//tf-aws-lambda-layer"

  namespace         = "devoteam"
  environment       = "prod"
  project           = "genai"
  component         = "api"

  s3_bucket             = "862879453668-terraform-modules"
  s3_key                = "lambda-layers/numpy_layer.zip"
  layer_name            = "myLayer"
  description           = "My Lambda Layer"
  compatible_runtimes   = ["python3.12"]
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
