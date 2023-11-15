---
service:
  name: ${service_name}
  identifier: ${service_identifier}
  description: ${description}
  tags:
    ${indent(4, tags)}
  ${indent(2, yaml_data)}
