# Create a custom VPC
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = var.tag-vpc
  }
}
# Creating keypair
resource "aws_key_pair" "keypair" {
  key_name   = var.keypair-name
  public_key = file(var.path-to-pub-key)
}