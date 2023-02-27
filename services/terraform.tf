####################
#
# Harness Services Provider Requirements
#
####################
terraform {
  required_providers {
    harness = {
      source = "harness/harness"
    }
    time = {
      source = "hashicorp/time"
    }
  }
}
