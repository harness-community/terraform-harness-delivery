####################
#
# Harness Infrastructure Outputs
#
####################
output "infrastructure_details" {
  depends_on = [
    time_sleep.infrastructure_setup
  ]
  value = harness_platform_infrastructure.infrastructure
}
