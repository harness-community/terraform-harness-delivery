---
environment:
    name: ${environment_name}
    identifier: ${environment_identifier}
    %{ if project_identifier != null }projectIdentifier: ${project_identifier}%{~ endif }
    %{ if organization_identifier != null }orgIdentifier: ${organization_identifier}%{~ endif }
    description: ${description}
    type: ${type}
    ${indent(4, yaml_data)}
