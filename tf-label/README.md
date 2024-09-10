# Terraform module tf-label

## Terraform module for consistent names and tags generation for resources.

There are 4 inputs which are used for label and tag generation:
1. namespace
1. environment
1. project
1. component

This module generates name using the following convention: {namespace}-{project}-{component}-{environment}

Also it generates following default tags:

namespace=**value**

environment=**value**

project=**value**

component=**value**

## Output values

**id** - Label string *{namespace}-{project}-{component}-{environment}*

**tags** - Auto Generated tags map concatenated with custom tags from variables


## Usage

```
module "name" {
  source   = "../tf-label"

  Namespace     = "devoteam"
  environment   = "prod"
  project       = "genai"
  component     = "api"
  delimiter     = "-"
  label_case    = "lower"

  tags = {
    "Billing" = "Department_1"
  }
}
```

This will create an output `module.name.id` with the value of `devoteam-prod-genai-api`.
As well as default tags set as `module.name.tags`:
```
  namespace     = "devoteam"
  environment   = "prod"
  project       = "genai"
  component     = "api"
  Billing       = "Department_1"
```
