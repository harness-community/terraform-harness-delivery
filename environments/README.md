# Terraform Modules for Harness Environments
Terraform Module for creating and managing Harness Environments

## Summary
This module handle the creation and managment of Environments by leveraging the Harness Terraform provider

## Providers

```
terraform {
  required_providers {
    harness = {
      source = "harness/harness"
    }
    time = {
      source = "hashicorp/time"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

```

## Variables

_Note: When the identifier variable is not provided, the module will automatically format the identifier based on the provided resource name_

| Name | Description | Type | Default Value | Mandatory |
| --- | --- | --- | --- | --- |
| name | [Required] (String) Name of the resource. | string |  | X |
| type | [Required] (String) The type of environment. Valid values are nonprod or prod| string | nonprod | |
| identifier | [Optional] Provide a custom identifier.  More than 2 but less than 128 characters and can only include alphanumeric or '_' | string | null | |
| organization_id | [Optional] Provide an organization reference ID. Must exist before execution | string | null | |
| project_id | [Optional] Provide an project reference ID. Must exist before execution | string | null | |
| description | [Optional] (String) Description of the resource. | string | Harness Environment created via Terraform | |
| color | [Optional] (String) Color of the Environment. | string | _Automatically selected if no value provided_ | |
| yaml_file | [Optional] (String) File Path to yaml snippet to include. Must not be provided in conjuction with var.yaml_data.| string | null | One of `yaml_file` or `yaml_data` must be provided. |
| yaml_data | [Optional] (String) Description of the resource. | string | null | One of `yaml_file` or `yaml_data` must be provided. |
| yaml_render | [Optional] (Boolean) Determines if the pipeline data should be templatized or is a full pipeline reference file | bool | true | |
| tags | [Optional] Provide a Map of Tags to associate with the project | map(any) | {} | |
| global_tags | [Optional] Provide a Map of Tags to associate with the project and resources created | map(any) | {} | |

## Examples
### Build a single Environment with minimal inputs using rendered payload
```
module "environments" {
  source = "git@github.com:harness-community/terraform-harness-delivery.git//environments"

  name             = "test-environment"
  organization_id  = "myorg"
  project_id       = "myproject"
  type             = "nonprod"
}
```

### Build a single Environment with yaml_file overrides using rendered payload
```
module "templates" {
  source = "git@github.com:harness-community/terraform-harness-content.git//templates"

  name             = "test-example"
  organization_id  = "myorg"
  project_id       = "myproject"
  type             = "nonprod"
  yaml_file        = "templates/test-example.yaml"

}
```

### Build a single Environment with raw yaml_data
```
module "templates" {
  source = "git@github.com:harness-community/terraform-harness-content.git//templates"

  name             = "test-example"
  organization_id  = "myorg"
  project_id       = "myproject"
  type             = "nonprod"
  yaml_render      = false
  yaml_data        = <<EOT
  environment:
    name: test-example
    identifier: test_example
    projectIdentifier: myproject
    orgIdentifier: myorg
    description: Harness Environment created via Terraform
    type: PreProduction
    overrides:
      manifests:
      - manifest:
          identifier: manifestEnv
          spec:
            store:
              spec:
                branch: master
                connectorRef: <+input>
                gitFetchType: Branch
                paths:
                - file1
                repoName: <+input>
              type: Git
          type: Values
  EOT

}
```

### Build multiple Environments
```
variable "environment_list" {
    type = list(map())
    default = [
        {
            name        = "cloud1"
            tags        = {
                role    = "nonprod-cloud1"
            }
        },
        {
            name        = "cloud1-prod"
            description = "Production Environment in Cloud1"
            type        = "prod"
            yaml_file   = "templates/environments/cloud1-prod-overrides.yaml"
            tags        = {
                role    = "prod-cloud1"
            }
        },
        {
            name        = "cloud2"
            type        = "nonprod"
            yaml_render = false
            yaml_file   = "templates/environments/cloud2-nonprod-full.yaml"
            tags        = {
                role    = "nonprod-cloud2"
            }
        }
    ]
}

variable "global_tags" {
    type = map()
    default = {
        environment = "NonProd"
    }
}

module "environments" {
  source = "git@github.com:harness-community/terraform-harness-content.git//environments"
  for_each = { for environment in var.environment_list : environment.name => environment }

  name             = each.value.name
  description      = lookup(each.value, "description", "Harness Environment for ${each.value.name}")
  type             = lookup(each.value, "type", "nonprod")
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
