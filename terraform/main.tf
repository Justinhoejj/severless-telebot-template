# Define the backend configuration
terraform {
  backend "s3" {
    bucket  = "<YOUR_BUCKET_NAME>"                              # Replace with your S3 bucket name
    key     = "<YOUR_APP_NAME_OR_ANY_ID_KEY>/terraform.tfstate" # State file path
    region  = "ap-southeast-1"                                  # Replace with your AWS region
    encrypt = true                                              # Enable state file encryption
  }
}

# Provider configuration
provider "aws" {
  region = "ap-southeast-1" # Replace with your preferred AWS region
}