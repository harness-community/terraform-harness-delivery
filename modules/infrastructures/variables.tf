####################
#
# Harness Infrastructure Variables
#
####################
variable "identifier" {
  type        = string
  description = "[Optional] Provide a custom identifier.  Must be at least 1 character but less than 128 characters and can only include alphanumeric or '_'"
  default     = null

  validation {
    condition = (
      var.identifier != null
      ?
      can(regex("^[0-9A-Za-z][0-9A-Za-z_]{0,127}$", var.identifier))
      :
      true
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Optional] Provide a custom identifier.  Must be at least 1 character but less than 128 characters and can only include alphanumeric or '_'.
            Note: If not set, Terraform will auto-assign an identifier based on the name of the resource
        EOF
  }
}
variable "name" {
  type        = string
  description = "[Required] Provide a resource name. Must be at least 1 character but but less than 128 characters"

  validation {
    condition = (
      length(var.name) > 1
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Required] Provide a resource name. Must be at least 1 character but but less than 128 characters.
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
            * [Optional] Provide an organization name.  Must exist before execution.
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
            * [Optional] Provide an project name.  Must exist before execution.
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

variable "type" {
  type        = string
  description = "[Required] Type of Infrastructure. Valid values are: KubernetesDirect, KubernetesGcp, ServerlessAwsLambda, Pdc, KubernetesAzure, SshWinRmAzure, SshWinRmAws, AzureWebApp, ECS, GitOps, CustomDeployment, TAS, KubernetesRancher, or AWS_SAM"

  validation {
    condition = (
      anytrue([
        contains([
          "KubernetesDirect",
          "KubernetesGcp",
          "ServerlessAwsLambda",
          "Pdc",
          "KubernetesAzure",
          "SshWinRmAzure",
          "SshWinRmAws",
          "AzureWebApp",
          "ECS",
          "GitOps",
          "CustomDeployment",
          "TAS",
          "KubernetesRancher",
          "AWS_SAM"
        ], var.type)
      ])
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Required]   # (String) Type of Infrastructure. Valid values are:
            - KubernetesDirect
            - KubernetesGcp
            - ServerlessAwsLambda
            - Pdc
            - KubernetesAzure
            - SshWinRmAzure
            - SshWinRmAws
            - AzureWebApp
            - ECS
            - GitOps
            - CustomDeployment
            - TAS
            - KubernetesRancher
            - AWS_SAM
        EOF
  }
}

variable "deployment_type" {
  type        = string
  description = "[Required] Infrastructure deployment type. Valid values are Kubernetes, NativeHelm, Ssh, WinRm, ServerlessAwsLambda, AzureWebApp, Custom, ECS"

  validation {
    condition = (
      contains([
        "Kubernetes",
        "NativeHelm",
        "Ssh",
        "WinRm",
        "ServerlessAwsLambda",
        "AzureWebApp",
        "CustomDeployment",
        "ECS"
      ], var.deployment_type)
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Required] (String) Infrastructure deployment type. Valid values are:
              - Kubernetes
              - NativeHelm
              - Ssh
              - WinRm
              - ServerlessAwsLambda
              - AzureWebApp
              - CustomDeployment
              - ECS
        EOF
  }
}

variable "description" {
  type        = string
  description = "[Optional] (String) Description of the resource."
  default     = "Harness Infrastructure created via Terraform"

  validation {
    condition = (
      length(var.description) > 6
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Optional] Provide an Pipeline description.  Must be six or more characters.
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

variable "allow_simultaneous" {
  type        = bool
  description = "[Optional] (Boolean) Determines if infrastructure supports simultaneous deployments"
  default     = false
}

variable "case_sensitive" {
  type        = bool
  description = "[Optional] Should identifiers be case sensitive by default? (Note: Setting this value to `true` will retain the case sensitivity of the identifier)"
  default     = false
}


variable "tags" {
  type        = map(any)
  description = "[Optional] Provide a Map of Tags to associate with the environment"
  default     = {}

  validation {
    condition = (
      length(keys(var.tags)) == length(values(var.tags))
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Optional] Provide a Map of Tags to associate with the project
        EOF
  }
}

variable "global_tags" {
  type        = map(any)
  description = "[Optional] Provide a Map of Tags to associate with the project and resources created"
  default     = {}

  validation {
    condition = (
      length(keys(var.global_tags)) == length(values(var.global_tags))
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Optional] Provide a Map of Tags to associate with the project and resources created
        EOF
  }
}
