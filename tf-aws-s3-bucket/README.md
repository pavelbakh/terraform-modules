# Terraform module tf-aws-s3-bucket

## Terraform module for creating AWS S3 Bucket resources.

## Usage

```
module "s3_bucket" {
  source  = "git::https://github.com/devoteam/terraform-modules.git//tf-aws-s3-bucket"

  namespace             = "devoteam"
  environment           = "prod"
  project               = "genai"
  component             = "storage"

  versioning_enabled    = true
}
```
