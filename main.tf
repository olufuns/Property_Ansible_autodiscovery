locals {
  name = "property-auto"
}

module "vpc" {
  source                 = "./module/vpc"
  keypair-name           = "pacpeuteam1"
   tag-vpc               = "${local.name}-vpc"
  vpc_cidr               = "10.0.0.0/16"
  path-to-pub-key        = "~/Keypairs/pacpeuteam1.pub"
}
