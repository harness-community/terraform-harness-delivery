####################
#
# Harness Environment Setup
#
####################
# Allows for automatic color selection for resources when
# var.color is not provided.
resource "random_id" "color_picker" {
  keepers = {
    # Generate a new id each time we switch to a new resource id
    identifier = local.fmt_identifier
  }

  byte_length = 3
}

resource "harness_platform_environment" "environments" {
  # [Required] (String) Unique identifier of the resource.
  identifier = local.fmt_identifier
  # [Required] (String) Name of the resource.
  name = var.name
  # [Required] (String) Unique identifier of the organization.
  org_id = var.organization_id
  # [Required] (String) Unique identifier of the project.
  project_id = var.project_id

  # (String) The type of environment. Valid values are PreProduction, Production
  type = local.type

  # [Required] (String) YAML of the pipeline.
  yaml = local.yaml_payload

  # [Optional] (String) Description of the resource.
  description = var.description

  # [Optional] (String) Color of the environment.
  color = var.color != null ? var.color : "#${random_id.color_picker.hex}"

  # [Optional] (Set of String) Tags to associate with the resource.
  tags = local.common_tags_tuple
}

# When creating a new Environment, there is a potential race-condition
# as the environment comes up.  This resource will introduce
# a slight delay in further execution to wait for the resources to
# complete.
resource "time_sleep" "environment_setup" {
  depends_on = [
    harness_platform_environment.environments
  ]

  create_duration  = "15s"
  destroy_duration = "15s"
}
