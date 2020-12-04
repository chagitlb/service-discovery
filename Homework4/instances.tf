module "public_servers" {
  source           = "./InstanceModule"
  name            = "nginx server"
  subnets          = module.vpc.public_subnets
  instance_type   = var.instance_type
  ami_id           = data.aws_ami.ubuntu.id
  key_name         = aws_key_pair.terraform-key.key_name
  security_groups  = ["${aws_security_group.web.id}"]
  iam_instance_profile_name = module.consul_cluster.aws_iam_instance_profile
  user_data        = file("consul-agent.sh")
  tags             = {Name = "web server"}
}
resource "aws_security_group" "web" {
    name = "vpc_web"
    description = "Allow incoming HTTP connections."

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = module.vpc.vpc_id

    tags ={
        Name = "WebServerSG"
    }
}