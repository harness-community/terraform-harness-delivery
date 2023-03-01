####################
#
# Harness Infrastructure Validations
#
####################
locals {
  infrastructure_outputs = flatten([
    {
      minimum        = module.infrastructures_minimal.infrastructure_details
      yaml_file      = module.infrastructures_yaml_file.infrastructure_details
      yaml_data_full = module.infrastructures_yaml_data_full.infrastructure_details
    }
  ])
}

module "infrastructures_minimal" {

  source = "../../modules/infrastructures"

  name            = "test-infrastructure-minimal"
  organization_id = local.organization_id
  project_id      = local.project_id
  environment_id  = local.environment_id
  type            = "KubernetesDirect"
  deployment_type = "Kubernetes"
  yaml_data       = <<EOT
  spec:
    connectorRef: account.gfgf
    namespace: asdasdsa
    releaseName: release-<+INFRA_KEY>
  EOT
  global_tags     = local.common_tags

}
module "infrastructures_yaml_file" {

  source = "../../modules/infrastructures"

  name            = "test-infrastructure-yaml-file"
  organization_id = local.organization_id
  project_id      = local.project_id
  environment_id  = local.environment_id
  type            = "KubernetesDirect"
  deployment_type = "Kubernetes"
  yaml_file       = "infrastructures/kubernetes-infra.yaml"
  global_tags     = local.common_tags

}
module "infrastructures_yaml_data_full" {

  source = "../../modules/infrastructures"

  identifier      = "test_infrastructure_yaml_data_full"
  name            = "test-infrastructure-yaml-data-full"
  organization_id = local.organization_id
  project_id      = local.project_id
  environment_id  = local.environment_id
  type            = "KubernetesDirect"
  deployment_type = "Kubernetes"
  yaml_render     = false
  yaml_data       = <<EOT
  infrastructureDefinition:
    name: test-infrastructure-yaml-data-full
    identifier: test_infrastructure_yaml_data_full
    description: Harness Environment created via Terraform
    orgIdentifier: ${local.organization_id}
    projectIdentifier: ${local.project_id}
    environmentRef: ${local.environment_id}
    deploymentType: Kubernetes
    type: KubernetesDirect
    spec:
      connectorRef: account.gfgf
      namespace: asdasdsa
      releaseName: release-<+INFRA_KEY>
    allowSimultaneousDeployments: false
    tags: {}
  EOT
  global_tags     = local.common_tags

}
