# environments

## Example

```hcl
module "environments-harness-management-nonprod" {

  source = "../../environments"

  name            = "non-production"
  organization_id = module.harness-core.organization_details.id
  project_id      = module.project-harness-organization-management.project_details.id
  description     = "NonProd Environment definitions"
  color           = "#ABABAB"
  type            = "nonprod"
  infrastructures = [
    {
      name            = "azure-cloud-connection"
      deployment_type = "NativeHelm"
      type            = "KubernetesAzure"
      yaml_data       = <<EOF
        spec:
          connectorRef: org.azure
          subscriptionId: 00000000-0000-0000-0000-000000000000
          resourceGroup: rg-nonprod-kubernetes
          cluster: harness
          namespace: <+service.name>
          releaseName: release-<+INFRA_KEY>
        EOF
    },
    {
      name            = "azure-kubernetes-connection"
      deployment_type = "Kubernetes"
      type            = "KubernetesAzure"
      yaml_data       = <<EOF
        spec:
          connectorRef: org.azure
          subscriptionId: 00000000-0000-0000-0000-000000000000
          resourceGroup: rg-nonprod-kubernetes
          cluster: harness
          namespace: default
          releaseName: release-<+INFRA_KEY>
        EOF
    }
  ]
  tags = {
    purpose = "NonProduction"
  }
  global_tags = var.global_tags
}

module "environments-harness-organization-management-nonprod" {

  source = "../../environments"

  name            = "non-production"
  organization_id = module.harness-core.organization_details.id
  project_id      = module.project-harness-management.project_details.id
  description     = "NonProd Environment definitions"
  color           = "#ABABAB"
  type            = "nonprod"
  infrastructures = [
    {
      name            = "azure-cloud-connection"
      deployment_type = "NativeHelm"
      type            = "KubernetesAzure"
      yaml_data       = <<EOF
        spec:
          connectorRef: org.azure
          subscriptionId: 00000000-0000-0000-0000-000000000000
          resourceGroup: rg-nonprod-kubernetes
          cluster: harness
          namespace: <+service.name>
          releaseName: release-<+INFRA_KEY>
        EOF
    },
    {
      name            = "azure-kubernetes-connection"
      deployment_type = "Kubernetes"
      type            = "KubernetesAzure"
      yaml_data       = <<EOF
        spec:
          connectorRef: org.azure
          subscriptionId: 00000000-0000-0000-0000-000000000000
          resourceGroup: rg-nonprod-kubernetes
          cluster: harness
          namespace: default
          releaseName: release-<+INFRA_KEY>
        EOF
    }
  ]
  tags = {
    purpose = "NonProduction"
  }
  global_tags = var.global_tags
}
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_harness"></a> [harness](#provider\_harness) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [harness_platform_environment.environments](https://registry.terraform.io/providers/harness/harness/latest/docs/resources/platform_environment) | resource |
| [harness_platform_infrastructure.infrastructure](https://registry.terraform.io/providers/harness/harness/latest/docs/resources/platform_infrastructure) | resource |
| [time_sleep.environment_setup](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_color"></a> [color](#input\_color) | [Optional] (String) Color of the Environment. | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | [Optional] (String) Description of the resource. | `string` | `"Harness Environment created via Terraform"` | no |
| <a name="input_global_tags"></a> [global\_tags](#input\_global\_tags) | [Optional] Provide a Map of Tags to associate with the project and resources created | `map(any)` | `{}` | no |
| <a name="input_infrastructures"></a> [infrastructures](#input\_infrastructures) | [Options] Provide a list of maps containing infrastructure details | `any` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | [Required] (String) Name of the resource. | `string` | n/a | yes |
| <a name="input_organization_id"></a> [organization\_id](#input\_organization\_id) | [Required] Provide an organization reference ID.  Must exist before execution | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | [Required] Provide an project reference ID.  Must exist before execution | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | [Optional] Provide a Map of Tags to associate with the environment | `map(any)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | [Required] (String) The type of environment. Valid values are nonprod or prod | `string` | `"nonprod"` | no |
| <a name="input_yaml_data"></a> [yaml\_data](#input\_yaml\_data) | [Optional] (String) Yaml data as a string. | `string` | `null` | no |
| <a name="input_yaml_file"></a> [yaml\_file](#input\_yaml\_file) | [Optional] (String) File Path to yaml snippet to include. Must not be provided in conjuction with var.yaml\_data | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_environment_details"></a> [environment\_details](#output\_environment\_details) | n/a |
| <a name="output_infrastructures"></a> [infrastructures](#output\_infrastructures) | n/a |
