# Hackday2023
Using Github actions and terraform to deploy security rules and track changes across UI and api

## GOAL

Be able to update, create and get state of datadog rules in terraform adding this here

## step 1
Get all rules with terraformer
https://docs.datadoghq.com/agent/guide/how-to-import-datadog-resources-into-terraform/#overview
`terraformer import datadog --resources=security_monitoring_rule --api-key=$DD_API_KEY --app-key=$DD_APP_KEY`

# step 2
Setup Terraform cloud
https://developer.hashicorp.com/terraform/tutorials/automation/github-actions


Update rule through IDE, github actions performing terraform apply
Easy to do since terraform is a supported tool on ubuntu 22 runners https://github.com/actions/runner-images/blob/main/images/linux/Ubuntu2204-Readme.md

# Extra - use OPA to require rules be tagged with attack technique, tactic and number
https://blog.gruntwork.io/terraform-up-running-3rd-edition-is-now-published-4b99804d922a
https://www.openpolicyagent.org/docs/latest/terraform/

Ideal workflow is to create rule in one dd account, run atomic/ stratus test on it, if succeeds then is created in prod account. 

### Guide text

Move to a feature branch to create changes to the cloudtrailrules.tf

change severity or add case for tagged amis.

Create pull request

add secrets to repo/ setup github actions

