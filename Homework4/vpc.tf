module "vpc" {
  source       = "./NetworkModule"
  name         = "env"
  cidr_vpc   = var.cidr_vpc
  azs          = var.availability_zones
  cidr_public  = var.cidr_public
  cidr_private = var.cidr_private
}

