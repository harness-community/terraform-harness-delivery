####################
#
# Harness Environments Local Variables
#
####################
locals {
  required_tags = [
    "created_by:Terraform"
  ]
  # Harness Tags are read into Terraform as a standard Map entry but needs to be
  # converted into a list of key:value entries
  global_tags = [for k, v in var.global_tags : "${k}:${v}"]
  # Harness Tags are read into Terraform as a standard Map entry but needs to be
  # converted into a list of key:value entries
  tags = [for k, v in var.tags : "${k}:${v}"]

  common_tags = flatten([
    local.tags,
    local.global_tags,
    local.required_tags
  ])

  fmt_identifier = (
    var.identifier == null
    ?
    (
      lower(
        replace(
          replace(
            var.name,
            " ",
            "_"
          ),
          "-",
          "_"
        )
      )
    )
    :
    var.identifier
  )

  type = (
    var.type == "prod"
    ?
    "Production"
    :
    "PreProduction"
  )

  yaml = (
    var.yaml_file != null
    ?
      try(
        file("${path.module}/rendered/${var.yaml_file}"),
        file("${path.root}/rendered/${var.yaml_file}"),
        file(var.yaml_file)
      )
    :
      var.yaml_data != null
      ?
        length(var.yaml_data)==0
        ?
          "invalid-missing-yaml-details"
        :
          var.yaml_data
      :
        var.yaml_data

  )

  yaml_payload = (
    var.yaml_render
    ?
      templatefile(
        "${path.module}/templates/environment_definition.yml.tpl",
        {
          environment_name        = var.name
          environment_identifier  = local.fmt_identifier
          description             = var.description
          type                    = local.type
          organization_identifier = var.organization_id
          project_identifier      = var.project_id
          yaml_data               = (local.yaml != null ? yamlencode(yamldecode(local.yaml)) : "")
          tags = yamlencode([
            for tag in local.common_tags : {
              split(":", tag)[0] = split(":", tag)[1]
            }

          ])
        }
      )
    :
      local.yaml
  )
}
