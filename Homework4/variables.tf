variable "aws_region" {
  default = "us-east-1"
}
variable "cluster_name" {
  default = "opsschool-cluster"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
}
variable "cidr_public" {
  type    = list(string)
  default = ["10.100.1.0/24"]
}
variable "cidr_vpc" {
  type    = string
  default = "10.100.0.0/16"
}

variable "cluster_size" {
  default     = 3
}

variable "cluster_tag_key" {
  default     = "consul-servers"
}

variable "cluster_tag_value" {
  default     = "auto-join"
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a"]
}

variable "enable_iam_setup" {
  default     = true
}
