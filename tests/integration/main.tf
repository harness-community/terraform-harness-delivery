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

resource "harness_platform_service" "test" {
  count       = 3
  identifier  = "terraform_harness_delivery_${count.index}"
  name        = "terraform-harness-delivery-${count.index}"
  description = "Testing Service for terraform_harness_delivery module"
  org_id      = harness_platform_organization.test.id
  project_id  = harness_platform_project.test.id
  yaml        = <<EOT
  service:
    name: terraform-harness-delivery-${count.index}
    identifier: terraform_harness_delivery_${count.index}
    description: "Testing Service for terraform_harness_delivery module"
    tags:
      purpose: terraform-testing
    serviceDefinition:
      spec: {}
      type: Ssh
  EOT
  tags        = ["purpose:terraform-testing"]
}

resource "harness_platform_service" "test_org" {
  identifier  = "terraform_harness_delivery_org"
  name        = "terraform-harness-delivery-org"
  description = "Testing Service for terraform_harness_delivery module"
  org_id      = harness_platform_organization.test.id
  yaml        = <<EOT
  service:
    name: terraform-harness-delivery-org
    identifier: terraform_harness_delivery_org
    description: "Testing Service for terraform_harness_delivery module"
    tags:
      purpose: terraform-testing
    serviceDefinition:
      spec: {}
      type: Ssh
  EOT
  tags        = ["purpose:terraform-testing"]
}

resource "harness_platform_service" "test_acct" {
  identifier  = "${local.fmt_prefix}_terraform_harness_delivery_account"
  name        = "${local.fmt_prefix}-terraform-harness-delivery-account"
  description = "Testing Service for terraform_harness_delivery module"
  yaml        = <<EOT
  service:
    name: ${local.fmt_prefix}-terraform-harness-delivery-account
    identifier: ${local.fmt_prefix}_terraform_harness_delivery_account
    description: "Testing Service for terraform_harness_delivery module"
    tags:
      purpose: terraform-testing
    serviceDefinition:
      spec: {}
      type: Ssh
  EOT
  tags        = ["purpose:terraform-testing"]
}
