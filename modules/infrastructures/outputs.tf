####################
#
# Harness Infrastructure Outputs
#
####################
# 2023-03-16
# This output is being deprecated and replaced by the output
# labeled `details`
output "infrastructure_details" {
  depends_on = [
    time_sleep.infrastructure_setup
  ]
  value = harness_platform_infrastructure.infrastructure
  description = "Details for the created Harness Infrastructure"
}
output "details" {
  depends_on = [
    time_sleep.infrastructure_setup
  ]
  value = harness_platform_infrastructure.infrastructure
  description = "Details for the created Harness Infrastructure"
}
