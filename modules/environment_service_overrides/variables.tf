####################
#
# Harness Environment Service Overrides Variables
#
####################
variable "identifier" {
  type        = string
  description = "[Optional] Provide a custom identifier.  More than 2 but less than 128 characters and can only include alphanumeric or '_'"
  default     = null

  validation {
    condition = (
      var.identifier != null
      ?
      can(regex("^[0-9A-Za-z][0-9A-Za-z_]{2,127}$", var.identifier))
      :
      true
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Optional] Provide a custom identifier.  More than 2 but less than 128 characters and can only include alphanumeric or '_'.
            Note: If not set, Terraform will auto-assign an identifier based on the name of the resource
        EOF
  }
}
variable "name" {
  type        = string
  description = "[Required] (String) Name of the resource."

  validation {
    condition = (
      length(var.name) > 2
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Required] Provide a project name.  Must be two or more characters.
        EOF
  }
}
variable "organization_id" {
  type        = string
  description = "[Optional] Provide an organization reference ID.  Must exist before execution"
  default     = null

  validation {
    condition = (
      var.organization_id != null
      ?
      length(var.organization_id) > 2
      :
      true
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Optional] Provide an existing organization reference ID.  Must exist before execution.
        EOF
  }
}

variable "project_id" {
  type        = string
  description = "[Optional] Provide an project reference ID.  Must exist before execution"
  default     = null

  validation {
    condition = (
      var.project_id != null
      ?
      can(regex("^([a-zA-Z0-9_]*)", var.project_id))
      :
      true
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Optional] Provide an existing project reference ID.  Must exist before execution.
        EOF
  }
}

variable "environment_id" {
  type        = string
  description = "[Required] Provide an environment reference ID.  Must exist before execution"

  validation {
    condition = (
      can(regex("^([a-zA-Z0-9_]*)", var.environment_id))
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Required] Provide an environment reference ID.  Must exist before execution.
        EOF
  }
}


variable "service_id" {
  type        = string
  description = "[Required] Provide an service reference ID.  Must exist before execution"

  validation {
    condition = (
      can(regex("^([a-zA-Z0-9_]*)", var.service_id))
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Required] Provide an existing service reference ID to override.  Must exist before execution.
        EOF
  }
}

variable "yaml_file" {
  type        = string
  description = "[Optional] (String) File Path to yaml snippet to include. Must not be provided in conjuction with var.yaml_data"
  default     = null
}

variable "yaml_data" {
  type        = string
  description = "[Optional] (String) Yaml data as a string."
  default     = null
}

variable "yaml_render" {
  type        = bool
  description = "[Optional] (Boolean) Determines if the pipeline data should be templatized or is a full pipeline reference file"
  default     = true
}
