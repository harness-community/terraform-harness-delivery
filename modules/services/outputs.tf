####################
#
# Harness Services Outputs
#
####################
# 2023-03-16
# This output is being deprecated and replaced by the output
# labeled `details`
output "service_details" {
  depends_on = [
    time_sleep.service_setup
  ]
  value = harness_platform_service.services
  description = "Details for the created Harness Services"
}
output "details" {
  depends_on = [
    time_sleep.service_setup
  ]
  value = harness_platform_service.services
  description = "Details for the created Harness Services"
}
