locals {
  name = "property-auto"
}

module "vpc" {
  source                 = "./module/vpc"
  keypair-name           = "pacpeuteam1"
   tag-vpc               = "${local.name}-vpc"
   tag-pub-subnet1       = "${local.name}-subnet1"
   tag-pub-subnet2       = "${local.name}-subnet2"
  vpc_cidr               = "10.0.0.0/16"
  path-to-pub-key        = "~/Keypairs/pacpeuteam1.pub"
   az1                   = "eu-west-2a"
   az2                   = "eu-west-2b"
  cidr-pub-01            = "10.0.1.0/24"
  cidr-pub-02            = "10.0.2.0/24"
  tag-prt-subnet1        = "${local.name}-subnet1"
  cidr-prt-1             = "10.0.3.0/24"
  cidr-prt-2             = "10.0.4.0/24"
  tag-prt-subnet2        = "${local.name}-subnet2"
  tag-igw                = "${local.name}-igw"
  tag-nat                = "${local.name}-ngw"
  cidr-pub-RT            = "0.0.0.0/0"
  tag-pub-rt             = "${local.name}-pub-rt"
  tag-prt-rt             = "${local.name}-prt-rt"
}
