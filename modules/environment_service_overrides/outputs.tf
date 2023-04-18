####################
#
# Harness Environment Service Overrides Outputs
#
####################
output "details" {
  depends_on = [
    time_sleep.overrides_setup
  ]
  value = harness_platform_environment_service_overrides.overrides
  description = "Details for the created Harness Environment Service Overrides"
}
