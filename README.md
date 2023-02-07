# Hackday2023
Use Github actions and terraform to test + deploy Datadog Cloud SIEM security rules. 


## Importing Rules
I began by importing some rules using terraformer according to [this guide](https://docs.datadoghq.com/agent/guide/how-to-import-datadog-resources-into-terraform/#overview). The following command worked once terraformer was installed.
`terraformer import datadog --resources=security_monitoring_rule --api-key=$DD_API_KEY --app-key=$DD_APP_KEY`

# Terraform Cloud
I chose to use terraform cloud to remotely run the terraform commands (i.e. plan, apply, fmt, etc). Alternatively, I could have used the Github actions runners or ran them on a self hosted runner.

# Architecture
![architecture](https://content.hashicorp.com/api/assets?product=tutorials&version=main&asset=public%2Fimg%2Fterraform%2Fautomation%2Ftfc-gh-actions-workflow.png)
Update rule through IDE, github actions performing terraform apply

<ol>
    <li> Rule is updated in .tf file (cloudtrail_rules.tf in this example)
    <li> Editer creates new pull request 
    <li> Github actions follow script to output result of `terraform plan` in PR
    <li> Upon approval and push, `terraform apply` github actions script applies the changes/ additional of sec rules
</ol>

# Use Cases

An additional github action job/step could be implemented to kick off stratus read team, atmoic red team or other pen test tools to automatically test the applied rule. This would need to be done after `terraform apply` so it would be necessary to run this in a datadog account dedicated to staging/ testing. 