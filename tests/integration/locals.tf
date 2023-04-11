locals {
  organization_id     = harness_platform_organization.test.id
  project_id          = harness_platform_project.test.id
  environment_id      = harness_platform_environment.test.id
  environment_org_id  = harness_platform_environment.test_org.id
  environment_acct_id = harness_platform_environment.test_acct.id
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
