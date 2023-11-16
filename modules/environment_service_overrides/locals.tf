####################
#
# Harness Environment Service Overrides Local Variables
#
####################
locals {
  auto_identifier = (
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

  fmt_identifier = (
    var.identifier == null
    ?
    (
      var.case_sensitive
      ?
      local.auto_identifier
      :
      lower(local.auto_identifier)
    )
    :
    var.identifier
  )

  environment_id = (
          var.project_id != null
          ?
            var.environment_id
          :
            var.organization_id != null
            ?
              "org.${var.environment_id}"
            :
              "account.${var.environment_id}"
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
    length(var.yaml_data) == 0
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
      "${path.module}/templates/service_overrides_definition.yml.tpl",
      {
        environment_identifier  = local.environment_id
        service_identifier      = var.service_id
        yaml_data               = (local.yaml != null ? yamlencode(yamldecode(local.yaml)) : "")
      }
    )
    :
    local.yaml
  )
}
