# Terraform Modules for Harness Services
Terraform Module for creating and managing Harness Services

## Summary
This module handle the creation and managment of Services by leveraging the Harness Terraform provider

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
  }
}

```

## Variables

_Note: When the identifier variable is not provided, the module will automatically format the identifier based on the provided resource name_

| Name | Description | Type | Default Value | Mandatory |
| --- | --- | --- | --- | --- |
| name | [Required] (String) Name of the resource. | string |  | X |
| organization_id | [Required] Provide an organization reference ID. Must exist before execution | string | | X |
| project_id | [Required] Provide an project reference ID. Must exist before execution | string | | X |
| identifier | [Optional] Provide a custom identifier.  More than 2 but less than 128 characters and can only include alphanumeric or '_' | string | null | |
| description | [Optional] (String) Description of the resource. | string | Harness Services created via Terraform | |
| yaml_file | [Optional] (String) File Path to yaml snippet to include. Must not be provided in conjuction with var.yaml_data.| string | null | One of `yaml_file` or `yaml_data` must be provided. |
| yaml_data | [Optional] (String) Description of the resource. | string | null | One of `yaml_file` or `yaml_data` must be provided. |
| yaml_render | [Optional] (Boolean) Determines if the pipeline data should be templatized or is a full pipeline reference file | bool | true | |
| tags | [Optional] Provide a Map of Tags to associate with the project | map(any) | {} | |
| global_tags | [Optional] Provide a Map of Tags to associate with the project and resources created | map(any) | {} | |

## Examples
### Build a single Service definition with minimal inputs
```
module "services" {
  source = "git@github.com:harness-community/terraform-harness-delivery.git//services"

  name            = "test-service"
  organization_id = "myorg"
  project_id      = "myproject"
  yaml_data       = <<EOT
  serviceDefinition:
    spec: {}
    type: Ssh
  EOT
}
```

### Build a single Service with yaml_file overrides using rendered payload
```
module "services" {
  source = "git@github.com:harness-community/terraform-harness-delivery.git//services"

  name            = "test-service"
  organization_id = "myorg"
  project_id      = "myproject"
  yaml_file       = "templates/test-service.yaml"

}
```

### Build a single Service with raw yaml_data
```
module "services" {
  source = "git@github.com:harness-community/terraform-harness-content.git//services"

  name            = "test-service"
  organization_id = "myorg"
  project_id      = "myproject"
  yaml_render      = false
  yaml_data        = <<EOT
  service:
    name: test-service
    identifier: test_service
    description: Harness Service created via Terraform
    serviceDefinition:
      spec: {}
      type: Ssh
  EOT

}
```

### Build multiple Services
```
variable "services_list" {
    type = list(map())
    default = [
        {
            name             = "green"
            organization_id  = "myorg"
            project_id       = "myproject"
            yaml_file        = "templates/green-service.yaml"
        },
        {
            name             = "blue"
            organization_id  = "myorg"
            project_id       = "myproject"
            yaml_file        = "templates/blue-service.yaml"
        },
        {
            name             = "yellow"
            organization_id  = "myorg"
            project_id       = "myproject"
            yaml_file        = "templates/yellow-service.yaml"
        }
    ]
}

variable "global_tags" {
    type = map()
    default = {
        environment = "NonProd"
    }
}

module "services" {
  source = "git@github.com:harness-community/terraform-harness-content.git//services"
  for_each = { for service in var.services_list : service.name => service }

  name             = each.value.name
  description      = lookup(each.value, "description", "Harness Service Definition for ${each.value.name}")
  organization_id  = lookup(each.value, "organization_id", null)
  project_id       = lookup(each.value, "project_id", null)
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
