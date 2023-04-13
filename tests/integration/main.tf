# Depends on
# - harness_environments.tf
# - harness_infrastructures.tf
# - harness_services.tf

# Create Testing infrastructure
resource "harness_platform_organization" "test" {
  identifier  = "${local.fmt_prefix}_terraform_harness_delivery"
  name        = "${local.fmt_prefix}-terraform-harness-delivery"
  description = "Testing Organization for Terraform Harness Delivery"
  tags        = ["purpose:terraform-testing"]
}

resource "harness_platform_project" "test" {
  identifier = "terraform_harness_delivery"
  name       = "terraform-harness-delivery"
  org_id     = harness_platform_organization.test.id
  color      = "#0063F7"
  tags       = ["purpose:terraform-testing"]
}

resource "harness_platform_environment" "test" {
  identifier = "terraform_harness_delivery"
  name       = "terraform-harness-delivery"
  org_id     = harness_platform_organization.test.id
  project_id = harness_platform_project.test.id
  tags       = ["purpose:terraform-testing"]
  type       = "PreProduction"
}

resource "harness_platform_environment" "test_org" {
  identifier = "terraform_harness_delivery_org"
  name       = "terraform-harness-delivery-org"
  org_id     = harness_platform_organization.test.id
  tags       = ["purpose:terraform-testing"]
  type       = "PreProduction"
}

resource "harness_platform_environment" "test_acct" {
  identifier = "${local.fmt_prefix}_terraform_harness_delivery_acct"
  name       = "${local.fmt_prefix}-terraform-harness-delivery-acct"
  tags       = ["purpose:terraform-testing"]
  type       = "PreProduction"
}
