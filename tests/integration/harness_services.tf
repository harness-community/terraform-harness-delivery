####################
#
# Harness Service Validations
#
####################
locals {
  service_outputs = flatten([
    {
      minimum        = module.services_minimal.service_details
      yaml_file      = module.services_yaml_file.service_details
      yaml_data_full = module.services_yaml_data_full.service_details
    }
  ])
}

module "services_minimal" {

  source = "../../services"

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

  source = "../../services"

  name            = "test-service-yaml-file"
  organization_id = local.organization_id
  project_id      = local.project_id
  yaml_file       = "services/test-service.yaml"
  global_tags     = local.common_tags

}

module "services_yaml_data_full" {

  source = "../../services"

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
