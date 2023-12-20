####################
#
# Harness Infrastructure Setup
#
####################
resource "harness_platform_infrastructure" "infrastructure" {
  lifecycle {
    precondition {
      condition     = local.yaml != "invalid-missing-yaml-details"
      error_message = "[Invalid] One of the following must be provided - 'yaml_data' or 'yaml_file'"
    }
  }
  # [Required] (String) Unique identifier of the resource.
  identifier = local.fmt_identifier
  # [Required] (String) Name of the resource.
  name = var.name
  # [Required] (String) Unique identifier of the organization.
  org_id = var.organization_id
  # [Required] (String) Unique identifier of the project.
  project_id = var.project_id
  # [Required] (String) environment identifier.
  env_id = var.environment_id

  # (String) Type of Infrastructure. Valid values are:
  # * KubernetesDirect
  # * KubernetesGcp
  # * ServerlessAwsLambda
  # * Pdc
  # * KubernetesAzure
  # * SshWinRmAzure
  # * SshWinRmAws
  # * AzureWebApp
  # * ECS
  # * GitOps
  # * CustomDeployment.
  type = var.type

  # [Required] (String) YAML of the pipeline.
  yaml = local.yaml_payload

  # [Optional] (String) Description of the resource.
  description = var.description

  # (String) Infrastructure deployment type. Valid values are:
  # * Kubernetes
  # * NativeHelm
  # * Ssh
  # * WinRm
  # * ServerlessAwsLambda
  # * AzureWebApp
  # * Custom
  # * ECS
  deployment_type = var.deployment_type

  # [Optional] (Set of String) Tags to associate with the resource.
  tags = local.common_tags_tuple
}

# When creating a new Infrastructure, there is a potential race-condition
# as the infrastructure comes up.  This resource will introduce
# a slight delay in further execution to wait for the resources to
# complete.
resource "time_sleep" "infrastructure_setup" {
  depends_on = [
    harness_platform_infrastructure.infrastructure
  ]

  create_duration  = "30s"
  destroy_duration = "15s"
}
