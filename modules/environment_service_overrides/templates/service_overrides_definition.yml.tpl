---
serviceOverrides:
  environmentRef: ${environment_identifier}
  serviceRef: ${service_identifier}
  ${indent(2, yaml_data)}
