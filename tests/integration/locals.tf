locals {
  organization_id      = harness_platform_organization.test.id
  project_id           = harness_platform_project.test.id
  environment_id       = harness_platform_environment.test.id
  environment_org_id   = harness_platform_environment.test_org.id
  environment_acct_id  = harness_platform_environment.test_acct.id
  service_id           = harness_platform_service.test.0.id
  service_id_yaml_file = harness_platform_service.test.1.id
  service_id_yaml_full = harness_platform_service.test.2.id
  service_org_id       = harness_platform_service.test_org.id
  service_acct_id      = harness_platform_service.test_acct.id
  fmt_prefix = (
    lower(
      replace(
        replace(
          var.prefix,
          " ",
          "_"
        ),
        "-",
        "_"
      )
    )
  )

  common_tags = merge(
    var.global_tags,
    {
      purpose = "terraform-testing"
    }
  )
}
