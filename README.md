# Terraform Modules for Harness Platform Delivery
A collection of Terraform resources used to support the content delivery of the Harness Platform

## Goal
The goal of this repository is to provide simple to consume versions of the Harness Terraform resources in such a way to make the management of Harness via Terraform easy to adopt.

## Summary
This collection of Terraform modules focuses on the initial setup of Harness Platform environments, infrastructure and services functionality.

## Providers

```
terraform {
  required_providers {
    harness = {
      source = "harness/harness"
    }
  }
}
```

## Variables
| Name | Description | Type | Default Value | Mandatory |
| --- | --- | --- | --- | --- |
| harness_platform_url | [Optional] Enter the Harness Platform URL.  Defaults to Harness SaaS URL | string | https://app.harness.io/gateway | |
| harness_platform_account | [Required] Enter the Harness Platform Account Number | string | | X |
| harness_platform_key | [Required] Enter the Harness Platform API Key for your account | string | | X |
| organization_name | Provide an organization name.  Must exist before execution | string | default | |
| project_name | Provide an project name in the chosen organization.  Must exist before execution | string | Default Project | |

## Examples
### Retrieve default module outputs
```
module "harness_delivery" {
  source = "git@github.com:harness-community/terraform-harness-delivery.git"

  harness_platform_account = "myaccount_id"
  harness_platform_key = "myplatform_key"
  organization_name = "default"
  project_name = "Default Project"
}
```

## Additional Module Details

### Environments
Create and manage new Harness Platform Environments.  Read more about this module in the [README](modules/environments/README.md)

### Infrastructures
Create and manage new Harness Platform Infrastructure.  Read more about this module in the [README](modules/infrastructures/README.md)

### Services
Create and manage new Harness Platform Services.  Read more about this module in the [README](modules/services/README.md)

## Contributing
A complete [Contributors Guide](CONTRIBUTING.md) can be found in this repository

## Authors
Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](LICENSE) for full details.
