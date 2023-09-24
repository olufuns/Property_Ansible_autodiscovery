provider "aws" {
  region  = "eu-west-2" #data.vault_generic_secret.aws-cred.data["region"]
  profile = "default"
}