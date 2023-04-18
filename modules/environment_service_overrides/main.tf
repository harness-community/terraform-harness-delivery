####################
#
# Harness Environment Service Overrides Setup
#
####################

resource "harness_platform_environment_service_overrides" "overrides" {
  # [Required] (String) Unique identifier of the organization.
  org_id = var.organization_id
  # [Required] (String) Unique identifier of the project.
  project_id = var.project_id
  # [Required] (String) The environment ID to which the overrides applies.
  env_id = var.environment_id
  # [Required] (String) The service ID to which the overrides applies.
  service_id = var.service_id

  # [Required] (String) YAML of the pipeline.
  yaml = local.yaml_payload
}

# When creating a new Environment, there is a potential race-condition
# as the environment comes up.  This resource will introduce
# a slight delay in further execution to wait for the resources to
# complete.
resource "time_sleep" "overrides_setup" {
  depends_on = [
    harness_platform_environment_service_overrides.overrides
  ]

  create_duration  = "15s"
  destroy_duration = "15s"
}
