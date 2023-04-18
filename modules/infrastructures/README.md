# Terraform Modules for Harness Infrastructures
Terraform Module for creating and managing Harness Infrastructures

## Summary
This module handle the creation and managment of Infrastructures by leveraging the Harness Terraform provider

## Supported Terraform Versions
_Note: These modules require a minimum of Terraform Version 1.2.0 to support the Input Validations and Precondition Lifecycle hooks leveraged in the code._

_Note: The list of supported Terraform Versions is based on the most recent of each release which has been tested against this module._

    - v1.2.9
    - v1.3.9
    - v1.4.0
    - v1.4.2
    - v1.4.3
    - v1.4.4
    - v1.4.5

_Note: Terraform version 1.4.1 will not work due to an issue with the Random provider_

## Providers

_Note: Terraform Provider must be a minimum of 0.14.9 to support Account or Organization level Infrastructure definitions._

```
terraform {
  required_providers {
    harness = {
      source  = "harness/harness"
      version = ">= 0.14"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9.1"
    }
  }
}

```

## Variables

_Note: When the identifier variable is not provided, the module will automatically format the identifier based on the provided resource name_

| Name | Description | Type | Default Value | Mandatory |
| --- | --- | --- | --- | --- |
| name | [Required] (String) Name of the resource. | string |  | X |
| organization_id | [Optional] Provide an organization reference ID. Must exist before execution | string | | X |
| project_id | [Optional] Provide an project reference ID. Must exist before execution | string | | X |
| environment_id | Required] Provide an environment reference ID.  Must exist before execution | string | | X |
| type | [Required] Type of Infrastructure. Valid values are: KubernetesDirect, KubernetesGcp, ServerlessAwsLambda, Pdc, KubernetesAzure, SshWinRmAzure, SshWinRmAws, AzureWebApp, ECS, GitOps, or CustomDeployment | string | | X |
| deployment_type | [Required] Infrastructure deployment type. Valid values are Kubernetes, NativeHelm, Ssh, WinRm, ServerlessAwsLambda, AzureWebApp, Custom, ECS | string | | x |
| identifier | [Optional] Provide a custom identifier.  More than 2 but less than 128 characters and can only include alphanumeric or '_' | string | null | |
| description | [Optional] (String) Description of the resource. | string | Harness Infrastructure created via Terraform | |
| yaml_file | [Optional] (String) File Path to yaml snippet to include. Must not be provided in conjuction with var.yaml_data.| string | null | One of `yaml_file` or `yaml_data` must be provided. |
| yaml_data | [Optional] (String) Description of the resource. | string | null | One of `yaml_file` or `yaml_data` must be provided. |
| yaml_render | [Optional] (Boolean) Determines if the pipeline data should be templatized or is a full pipeline reference file | bool | true | |
| tags | [Optional] Provide a Map of Tags to associate with the project | map(any) | {} | |
| global_tags | [Optional] Provide a Map of Tags to associate with the project and resources created | map(any) | {} | |

## Outputs
| Name | Description | Value |
| --- | --- | --- |
| details | Details for the created Harness infrastructure | Map containing details of created infrastructure
| infrastructure_details | [Deprecated] Details for the created Harness infrastructure | Map containing details of created infrastructure

## Examples
### Build a single Infrastructure definition with minimal inputs
_One of the following must be provided - `yaml_data` or `yaml_file`_
```
module "infrastructures" {
  source = "harness-community/delivery/harness//modules/infrastructures"

  name             = "test-infrastructure"
  organization_id  = "myorg"
  project_id       = "myproject"
  environment_id   = "cloud1"
  type             = "KubernetesDirect"
  deployment_type  = "Kubernetes"
  yaml_data        = <<EOT
  spec:
    connectorRef: account.gfgf
    namespace: asdasdsa
    releaseName: release-<+INFRA_KEY>
  EOT
}
```

### Build a single Infrastructure with yaml_file overrides using rendered payload
```
module "infrastructures" {
  source = "harness-community/delivery/harness//modules/infrastructures"

  name             = "test-infrastructure"
  organization_id  = "myorg"
  project_id       = "myproject"
  environment_id   = "cloud1"
  type             = "KubernetesDirect"
  deployment_type  = "Kubernetes"
  yaml_file        = "templates/test-infrastructure.yaml"

}
```

### Build a single Environment with raw yaml_data
```
module "infrastructures" {
  source = "harness-community/delivery/harness//modules/infrastructures"

  name             = "test-infrastructure"
  organization_id  = "myorg"
  project_id       = "myproject"
  environment_id   = "cloud1"
  type             = "KubernetesDirect"
  deployment_type  = "Kubernetes"
  yaml_render      = false
  yaml_data        = <<EOT
  infrastructureDefinition:
    name: test-infrastructure
    identifier: test_infrastructure
    environmentRef: cloud1
    projectIdentifier: myproject
    orgIdentifier: myorg
    description: Harness Infrastructure created via Terraform
    type: KubernetesDirect
    deploymentType: Kubernetes
    allowSimultaneousDeployments: false
    spec:
      connectorRef: account.gfgf
      namespace: asdasdsa
      releaseName: release-<+INFRA_KEY>
  EOT

}
```

### Build multiple Infrastructures
```
variable "infrastructures_list" {
    type = list(map())
    default = [
        {
            name             = "green"
            organization_id  = "myorg"
            project_id       = "myproject"
            environment_id   = "cloud1"
            type             = "KubernetesDirect"
            deployment_type  = "Kubernetes"
            yaml_file        = "templates/kubernetes.yaml"
        },
        {
            name             = "blue"
            organization_id  = "myorg"
            project_id       = "myproject"
            environment_id   = "cloud1"
            type             = "KubernetesDirect"
            deployment_type  = "Kubernetes"
            yaml_file        = "templates/kubernetes.yaml"
        },
        {
            name             = "yellow"
            organization_id  = "myorg"
            project_id       = "myproject"
            environment_id   = "cloud1"
            type             = "KubernetesDirect"
            deployment_type  = "Kubernetes"
            yaml_file        = "templates/kubernetes.yaml"
        }
    ]
}

variable "global_tags" {
    type = map()
    default = {
        environment = "NonProd"
    }
}

module "infrastructures" {
  source = "harness-community/delivery/harness//modules/infrastructures"
  for_each = { for infrastructure in var.infrastructures_list : infrastructure.name => infrastructure }

  name             = each.value.name
  description      = lookup(each.value, "description", "Harness Infrastructure Definition for ${each.value.name}")
  organization_id  = lookup(each.value, "organization_id", null)
  project_id       = lookup(each.value, "project_id", null)
  environment_id   = lookup(each.value, "environment_id", null)
  type             = lookup(each.value, "type", null)
  deployment_type  = lookup(each.value, "deployment_type", null)
  yaml_render      = lookup(each.value, "render", true)
  yaml_file        = lookup(each.value, "yaml_file", null)
  yaml_data        = lookup(each.value, "yaml_data", null)
  tags             = lookup(each.value, "tags", {})
  global_tags      = var.global_tags
}
```

## Contributing
A complete [Contributors Guide](../CONTRIBUTING.md) can be found in this repository

## Authors
Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../LICENSE) for full details.
