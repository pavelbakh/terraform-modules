# Terraform module tf-aws-dynamodb

## Terraform module for creating DynamoDb resources.

## Usage

```
module "dynamodb_table" {
  source  = "git::https://github.com/devoteam/terraform-modules.git//tf-aws-dynamodb"

  namespace             = "devoteam"
  environment           = "prod"
  project               = "genai"
  component             = "db"

  table_name            = "logs_table"
  hash_key              = "HashKey"
  range_key             = "RangeKey"

  dynamodb_attributes = [
    {
      name = "Component"
      type = "S"
    },
    {
      name = "Timestamp"
      type = "S"
    }
  ]

  local_secondary_index_map = [
    {
      name               = "TimestampSortIndex"
      range_key          = "Timestamp"
      projection_type    = "INCLUDE"
      non_key_attributes = ["HashKey", "RangeKey"]
    },
    {
      name               = "ComponentIndex"
      range_key          = "Timestamp"
      projection_type    = "INCLUDE"
      non_key_attributes = ["HashKey", "RangeKey"]
    }
  ]

  global_secondary_index_map = [
    {
      name               = "ComponentGlobalIndex"
      hash_key           = "Component"
      range_key          = "Timestamp"
      write_capacity     = 5
      read_capacity      = 5
      projection_type    = "INCLUDE"
      non_key_attributes = ["HashKey", "RangeKey"]
    }
  ]
}
```
