module "vpc" {
  source       = "./NetworkModule"
  name         = "vpc"
  cidr_vpc   = var.cidr_vpc
  azs          = var.availability_zones
  cidr_public  = var.cidr_public
}

