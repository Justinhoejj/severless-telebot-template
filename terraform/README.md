### Getting started install venv locally
Navigate to source dir
`cd source`

Install and activate virtual environment
`pip3 -m venv venv`
`source venv/bin/activate`

Install basic dependencies
`pip3 install -r requirements.txt`

### Create your own requirements.txt
`pip3 freeze > requirement.txt

### Deployment via terraform
1. Create state file in account
1. Replace state file reference in main.tf
1. Create `terraform.tfvars` and populate variables `bot_token` and `bot_name`. See `terraform.tfvars.example` for reference. 
1. `terraform validate` and `terraform apply`
