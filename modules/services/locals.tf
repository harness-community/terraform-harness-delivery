####################
#
# Harness Services Local Variables
#
####################
locals {
  required_tags = {
    created_by: "Terraform"
  }

  common_tags = merge(
    var.tags,
    var.global_tags,
    local.required_tags
  )
  # Harness Tags are read into Terraform as a standard Map entry but needs to be
  # converted into a list of key:value entries
  common_tags_tuple = [for k, v in local.common_tags : "${k}:${v}"]

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
      "${path.module}/templates/services_definition.yml.tpl",
      {
        service_name       = var.name
        service_identifier = local.fmt_identifier
        description        = var.description
        yaml_data          = (local.yaml != null ? yamlencode(yamldecode(local.yaml)) : "")
        tags               = yamlencode(local.common_tags)
      }
    )
    :
    local.yaml
  )

}
