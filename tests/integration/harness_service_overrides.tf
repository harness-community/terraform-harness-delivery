####################
#
# Harness Environment Validations
#
####################
locals {
  service_override_outputs = flatten([
    {
      minimum = module.service_overrides_minimal.details
    }
  ])
}

module "service_overrides_minimal" {

  source = "../../modules/environment_service_overrides"

  name            = "test-service-overrides-minimal"
  organization_id = local.organization_id
  project_id      = local.project_id
  environment_id  = local.environment_id
  service_id      = local.service_id
  yaml_data       = <<EOT
  variables:
    - name: success
      type: String
      value: "true"
  EOT

}

module "service_overrides_minimal_org_level" {

  source = "../../modules/environment_service_overrides"

  name            = "${local.organization_id}-test-service-overrides-minimal"
  organization_id = local.organization_id
  environment_id  = local.environment_org_id
  service_id      = local.service_org_id
  yaml_data       = <<EOT
  variables:
    - name: success
      type: String
      value: "true"
  EOT

}

module "service_overrides_minimal_account_level" {

  source = "../../modules/environment_service_overrides"

  name           = "${local.organization_id}-test-service-overrides-minimal"
  environment_id = local.environment_acct_id
  service_id     = local.service_acct_id
  yaml_data      = <<EOT
  variables:
    - name: success
      type: String
      value: "true"
  EOT

}

module "service_overrides_yaml_file" {

  source = "../../modules/environment_service_overrides"

  name            = "test-service-overrides-yaml-file"
  organization_id = local.organization_id
  project_id      = local.project_id
  environment_id  = local.environment_id
  service_id      = local.service_id_yaml_file
  yaml_file       = "service_overrides/test-service.yaml"

}

module "service_overrides_yaml_full" {

  source = "../../modules/environment_service_overrides"

  name            = "test-service-overrides-yaml-full"
  organization_id = local.organization_id
  project_id      = local.project_id
  environment_id  = local.environment_id
  service_id      = local.service_id_yaml_full
  yaml_render     = false
  yaml_data       = <<EOT
  serviceOverrides:
      environmentRef: ${local.environment_id}
      serviceRef: ${local.service_id}
      variables:
        - name: success
          type: String
          value: "true"
  EOT

}
