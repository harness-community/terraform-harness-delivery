####################
#
# Harness Environments Outputs
#
####################
# 2023-03-16
# This output is being deprecated and replaced by the output
# labeled `details`
output "environment_details" {
  depends_on = [
    time_sleep.environment_setup
  ]
  value = harness_platform_environment.environments
  description = "Details for the created Harness Environments"
}
output "details" {
  depends_on = [
    time_sleep.environment_setup
  ]
  value = harness_platform_environment.environments
  description = "Details for the created Harness Environments"
}
