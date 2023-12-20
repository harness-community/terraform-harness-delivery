# Terraform Modules for Harness Environment Service Overrides
Terraform Module for creating and managing Harness Environment Service Overrides

## Summary
This module handle the creation and managment of Environment Service Overrides by leveraging the Harness Terraform provider

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
| organization_id | [Optional] Provide an organization reference ID. Must exist before execution | string | null | |
| project_id | [Optional] Provide an project reference ID. Must exist before execution | string | null | |
| environment_id | [Required] Provide an environment reference ID. Must exist before execution | string | | X |
| service_id | [Required] Provide a service reference ID. Must exist before execution | string | | X |
| yaml_file | [Optional] (String) File Path to yaml snippet to include. Must not be provided in conjuction with var.yaml_data.| string | null | One of `yaml_file` or `yaml_data` must be provided. |
| yaml_data | [Optional] (String) Description of the resource. | string | null | One of `yaml_file` or `yaml_data` must be provided. |
| yaml_render | [Optional] (Boolean) Determines if the pipeline data should be templatized or is a full pipeline reference file | bool | true | |
| case_sensitive | [Optional] Should identifiers be case sensitive by default? (Note: Setting this value to `true` will retain the case sensitivity of the identifier) | bool | false | |

## Outputs
| Name | Description | Value |
| --- | --- | --- |
| details | Details for the created Harness environment service overrides | Map containing details of created environment service overrides |

## Examples
### Build a single Environment Service Override with minimal inputs using rendered payload
```
module "environment_service_overrides" {
  source = "harness-community/delivery/harness//modules/environment_service_overrides"

  name             = "test-environment-service-override"
  organization_id  = "myorg"
  project_id       = "myproject"
  environment_id   = "test_environment"
  service_id       = "test_service"
  yaml_data        = <<EOT
  variables:
    - name: success
      type: String
      value: "true"
  EOT
}
```

### Build a single Environment with yaml_file overrides using rendered payload
```
module "environment_service_overrides" {
  source = "harness-community/delivery/harness//modules/environment_service_overrides"

  name             = "test-environment-service-override"
  organization_id  = "myorg"
  project_id       = "myproject"
  environment_id   = "test_environment"
  service_id       = "test_service"
  yaml_file        = "environment_service_overrides/test-example.yaml"

}
```

### Build a single Environment with raw yaml_data
```
module "environment_service_overrides" {
  source = "harness-community/delivery/harness//modules/environment_service_overrides"

  name             = "test-environment-service-override"
  organization_id  = "myorg"
  project_id       = "myproject"
  environment_id   = "test_environment"
  service_id       = "test_service"
  yaml_render      = false
  yaml_data        = <<EOT
  serviceOverrides:
    environmentRef: test_environment
    serviceRef: test_service
    variables:
      - name: success
        type: String
        value: "true"
  EOT

}
```

## Contributing
A complete [Contributors Guide](../CONTRIBUTING.md) can be found in this repository

## Authors
Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../LICENSE) for full details.
