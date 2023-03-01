####################
#
# Harness Services Outputs
#
####################
output "service_details" {
  depends_on = [
    time_sleep.service_setup
  ]
  value = harness_platform_service.services
  description = "Details for the created Harness Services"
}
