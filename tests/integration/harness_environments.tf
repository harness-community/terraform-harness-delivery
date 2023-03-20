####################
#
# Harness Environment Validations
#
####################
locals {
  environment_outputs = flatten([
    {
      minimum               = module.environments_minimal.details
      minimal_org_level     = module.environments_minimal_org_level.details
      minimal_account_level = module.environments_minimal_account_level.details
      yaml_file             = module.environments_yaml_file.details
      yaml_data             = module.environments_yaml_data.details
      yaml_data_full        = module.environments_yaml_data_full.details
    }
  ])
}

module "environments_minimal" {

  source = "../../modules/environments"

  name            = "test-environment-minimal"
  organization_id = local.organization_id
  project_id      = local.project_id
  global_tags     = local.common_tags

}
module "environments_minimal_org_level" {

  source = "../../modules/environments"

  name            = "${local.organization_id}-test-environment-minimal"
  organization_id = local.organization_id
  global_tags     = local.common_tags

}
module "environments_minimal_account_level" {

  source = "../../modules/environments"

  name        = "${local.organization_id}-test-environment-minimal"
  global_tags = local.common_tags

}
module "environments_yaml_file" {

  source = "../../modules/environments"

  name            = "test-environment-yaml-file"
  organization_id = local.organization_id
  project_id      = local.project_id
  yaml_file       = "environments/manifest-configuration.yaml"
  global_tags     = local.common_tags

}
module "environments_yaml_data" {

  source = "../../modules/environments"

  name            = "test-environment-yaml-data"
  organization_id = local.organization_id
  project_id      = local.project_id
  yaml_data       = <<EOT
  overrides:
    manifests:
      - manifest:
          identifier: manifestEnv
          type: Values
          spec:
            store:
              type: Git
              spec:
                connectorRef: <+input>
                gitFetchType: Branch
                paths:
                  - file1
                repoName: <+input>
                branch: master
  EOT
  global_tags     = local.common_tags

}

module "environments_yaml_data_full" {

  source = "../../modules/environments"

  name            = "test-environment-yaml-data-full"
  organization_id = local.organization_id
  project_id      = local.project_id
  yaml_render     = false
  yaml_data       = <<EOT
  environment:
    name: test-environment-yaml-data-full
    identifier: test_environment_yaml_data_full
    description: Harness Environment created via Terraform
    tags: {}
    type: PreProduction
    orgIdentifier: ${local.organization_id}
    projectIdentifier: ${local.project_id}
    variables: []
    overrides:
      manifests:
        - manifest:
            identifier: manifestEnv
            type: Values
            spec:
              store:
                type: Git
                spec:
                  connectorRef: <+input>
                  gitFetchType: Branch
                  paths:
                    - file1
                  repoName: <+input>
                  branch: master
  EOT
  global_tags     = local.common_tags

}
