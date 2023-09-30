# My terraform provider

provider "aws" {
  region  = "ca-central-1"
  profile = "<your-profile-name>"
  version = "~> 2.7"
}

terraform {
  backend "s3" {
    bucket  = "<your-bucket-name>"
    key     = "iac-cicd/main.tfstate"
    region  = "ca-central-1"
    profile = "<your-profile-name>"
  }
}

# End;