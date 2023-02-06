resource "datadog_security_monitoring_rule" "security_monitoring_rule_mzb-tso-njf" {
  case {
    condition = "a > 1"
    status    = "medium"
  }

  enabled            = "true"
  has_extended_title = "true"
  message            = "## Goal\nDetect when an AMI is made public.\n\n## Strategy\nThis rule lets you monitor these CloudTrail API calls to detect if an AMI is made public.\n\n* [ModifyImageAttribute][1]\n\nThis rule inspects the `@requestParameters.launchPermission.add.items.group` array to determine if the string `all` is contained. This is the indicator which means the image is made public.\n\n## Triage and response\n1. Determine if the AMI (`@requestParameters.imageId`) should be made public using CloudTrail logs.\n2. Investigate the following ARN (`{{@userIdentity.arn}}`) that made the AMI public.\n3. Contact the user to see if they intended to make the image public.\n4. If the user did not make the API call:\n    * Rotate the credentials.\n    * Investigate if the same credentials made other unauthorized API calls.\n    * Revert AMI permissions to the original state.\n    * Begin your company's IR process and investigate.\n\n## Changelog\n11 November 2022 - Add steps to Triage and response section.\n\n[1]: https://docs.aws.amazon.com/cli/latest/reference/ec2/modify-image-attribute.html#examples"
  name               = "AWS AMI Made Public - Newest"

  options {
    decrease_criticality_based_on_env = "true"
    detection_method                  = "threshold"
    evaluation_window                 = "300"
    keep_alive                        = "3600"
    max_signal_duration               = "3600"
  }

  query {
    aggregation     = "count"
    group_by_fields = ["@userIdentity.arn"]
    query           = "source:cloudtrail @evt.name:ModifyImageAttribute @requestParameters.launchPermission.add.items.group:\"all\""
  }

  type = "log_detection"
}