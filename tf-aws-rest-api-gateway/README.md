# Terraform module tf-aws-rest-api-gateway

## Usage

```
module "api" {
  source  = "git::https://github.com/devoteam/terraform-modules.git//tf-aws-rest-api-gateway"

  Namespace     = "devoteam"
  environment   = "prod"
  project       = "genai"
  component     = "api"

  tags = {
    "Billing" = "Department_1"
  }

  openapi_config = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "example"
      version = "1.0"
    }
    paths = {
      "/path1" = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "https://ip-ranges.amazonaws.com/ip-ranges.json"
          }
        }
      }
    }
  })
  logging_level = "OFF"
}
```
