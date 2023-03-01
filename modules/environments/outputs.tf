####################
#
# Harness Environments Outputs
#
####################
output "environment_details" {
  depends_on = [
    time_sleep.environment_setup
  ]
  value = harness_platform_environment.environments
  description = "Details for the created Harness Environments"
}
