terraform {
  required_version = ">= 0.13.0"
}

locals {

  defaults = {
    delimiter   = "-"
    label_case  = "lower"
  }

  input = {
    namespace   = var.namespace == null ? "devoteam" : var.namespace
    environment = var.environment == null ? "dev" : var.environment
    project     = var.project == null ? "" : var.project
    component   = var.component == null ? "" : var.component
    delimiter   = var.delimiter == null ? "-" : var.delimiter
    label_case  = var.label_case == null ? "lower" : var.label_case
  }

  string_id_label_names = ["namespace", "environment", "project", "component"]

  format_label = { 
    for k in local.string_id_label_names : 
      k => local.label_case == "upper" ? upper(local.input[k]) : lower(local.input[k])
  }

  namespace   = local.format_label["namespace"]
  environment = local.format_label["environment"]
  project     = local.format_label["project"]
  component   = local.format_label["component"]

  delimiter     = local.input.delimiter == null ? local.defaults.delimiter : local.input.delimiter
  label_case    = local.input.label_case == null ? local.defaults.label_case : local.input.label_case

  tags_context = {
    namespace   = local.namespace
    environment = local.environment
    project     = local.project
    component   = local.component
  }

  labels_as_tags = keys(local.tags_context)

  tags = {
    for l in setintersection(keys(local.tags_context), local.labels_as_tags) :
    local.label_case == "upper" ? upper(l) : lower(l)
        => local.tags_context[l] if length(local.tags_context[l]) > 0
  }

  id = join(local.delimiter, [local.namespace, local.environment, local.project, local.component])

}
