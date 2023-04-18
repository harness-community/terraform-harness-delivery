---
serviceOverrides:
    environmentRef: ${environment_identifier}
    serviceRef: ${service_identifier}
    ${indent(4, yaml_data)}
