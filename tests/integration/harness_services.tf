####################
#
# Harness Service Validations
#
####################
locals {
  service_outputs = flatten([
    {
      minimum        = module.services_minimal.details
      yaml_file      = module.services_yaml_file.details
      yaml_data_full = module.services_yaml_data_full.details
    }
  ])
}

module "services_minimal" {

  source = "../../modules/services"

  name            = "test-service-minimal"
  organization_id = local.organization_id
  project_id      = local.project_id
  yaml_data       = <<EOT
  serviceDefinition:
    spec: {}
    type: Ssh
  EOT
  global_tags     = local.common_tags

}

module "services_yaml_file" {

  source = "../../modules/services"

  name            = "test-service-yaml-file"
  organization_id = local.organization_id
  project_id      = local.project_id
  yaml_file       = "services/test-service.yaml"
  global_tags     = local.common_tags

}

module "services_yaml_data_full" {

  source = "../../modules/services"

  identifier      = "test_service_yaml_data_full"
  name            = "test-service-yaml-data-full"
  description     = "Harness Test Service"
  organization_id = local.organization_id
  project_id      = local.project_id
  yaml_render     = false
  yaml_data       = <<EOT
  service:
    name: test-service-yaml-data-full
    identifier: test_service_yaml_data_full
    description: Harness Test Service
    serviceDefinition:
      spec: {}
      type: Ssh
  EOT
  tags = {
    role = "yaml-data-full"
  }
  global_tags = local.common_tags

}
