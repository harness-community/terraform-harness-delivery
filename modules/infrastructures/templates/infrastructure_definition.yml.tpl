---
infrastructureDefinition:
  name: ${infrastructure_name}
  identifier: ${infrastructure_identifier}
  environmentRef: ${environment_identifier}
  %{ if project_identifier != null }projectIdentifier: ${project_identifier}%{~ endif }
  %{ if organization_identifier != null }orgIdentifier: ${organization_identifier}%{~ endif }
  description: ${description}
  type: ${type}
  tags:
    ${indent(4, tags)}
  %{ if deployment_type != null }deploymentType: ${deployment_type}%{~ endif }
  allowSimultaneousDeployments: ${allow_simultaneous}
  ${indent(2, yaml_data)}
