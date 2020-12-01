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
  default = ["10.100.1.0/24", "10.100.2.0/24"]
}

variable "cidr_private" {
  type    = list(string)
  default = ["10.100.10.0/24", "10.100.11.0/24"]
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
  default = ["us-east-1a", "us-east-1b"]
}

variable "enable_iam_setup" {
  default     = true
}

variable "describe_instances" {
  type    = string
  default = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
      }
    ]
  }
    EOF
}

variable "assume_role" {
  type = string
  default = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
         "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
    EOF
}
data "http" "my_ip" {
  url = "http://ipv4.icanhazip.com"
}