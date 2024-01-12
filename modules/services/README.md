# Terraform Modules for Harness Services
Terraform Module for creating and managing Harness Services

## Summary
This module handle the creation and managment of Services by leveraging the Harness Terraform provider

## Supported Terraform Versions
_Note: These modules require a minimum of Terraform Version 1.2.0 to support the Input Validations and Precondition Lifecycle hooks leveraged in the code._

_Note: The list of supported Terraform Versions is based on the most recent of each release which has been tested against this module._

    - v1.2.9
    - v1.3.9
    - v1.4.7
    - v1.5.7
    - v1.6.0
    - v1.6.1
    - v1.6.2
    - v1.6.3
    - v1.6.4
    - v1.6.5
    - v1.6.6

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
| name | [Required] Provide a resource name. Must be at least 1 character but but less than 128 characters | string | | X |
| identifier | [Optional] Provide a custom identifier.  Must be at least 1 character but but less than 128 characters and can only include alphanumeric or '_' | string | null | |
| organization_id | [Optional] Provide an organization reference ID.  Must exist before execution | string | | |
| project_id | [Optional] Provide an project reference ID. Must exist before execution | string | | |
| description | [Optional] (String) Description of the resource. | string | Harness Services created via Terraform | |
| yaml_file | [Optional] (String) File Path to yaml snippet to include. Must not be provided in conjuction with var.yaml_data.| string | null | One of `yaml_file` or `yaml_data` must be provided. |
| yaml_data | [Optional] (String) Description of the resource. | string | null | One of `yaml_file` or `yaml_data` must be provided. |
| yaml_render | [Optional] (Boolean) Determines if the pipeline data should be templatized or is a full pipeline reference file | bool | true | |
| case_sensitive | [Optional] Should identifiers be case sensitive by default? (Note: Setting this value to `true` will retain the case sensitivity of the identifier) | bool | false | |
| force_delete | [Optional] Enable this flag for force deletion of service | bool | false | |
| tags | [Optional] Provide a Map of Tags to associate with the resource | map(any) | {} | |
| global_tags | [Optional] Provide a Map of Tags to associate with all resources created | map(any) | {} | |

## Outputs
| Name | Description | Value |
| --- | --- | --- |
| details | Details for the created Harness service | Map containing details of created service


## Examples
### Build a single Service definition with minimal inputs
```
module "services" {
  source = "harness-community/delivery/harness//modules/services"

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
  source = "harness-community/delivery/harness//modules/services"

  name            = "test-service"
  organization_id = "myorg"
  project_id      = "myproject"
  yaml_file       = "templates/test-service.yaml"

}
```

### Build a single Service with raw yaml_data
```
module "services" {
  source = "harness-community/delivery/harness//modules/services"

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
  source = "harness-community/delivery/harness//modules/services"
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
