module "consul_cluster" {

    cluster_name = var.cluster_name
    source = "./ConsulModule"
    ami_id = data.aws_ami.ubuntu.id
    cluster_tag_key   = "consul-cluster"
    cluster_tag_value = "consul-cluster-example"
    cluster_size = 3
    instance_type = "t2.micro"
    vpc_id = module.vpc.vpc_id
    allowed_inbound_cidr_blocks = var.cidr_public
    subnet_ids = module.vpc.public_subnets
    availability_zones = var.availability_zones
    ssh_key_name = aws_key_pair.terraform-key.key_name
    security_groups = [aws_security_group.public-sg.id]
//  iam_instance_profile_name = 
    associate_public_ip_address = true
    user_data = file("consul-server.sh")
}
resource "aws_security_group" "public-sg" {
  name   = "homework-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_ip.body)}/32"]
  }
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_ip.body)}/32"]
  }
  ingress {
    description = "Allow ICMP"
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["${chomp(data.http.my_ip.body)}/32"]
  }
  ingress {
    from_port   = 8500
    to_port     = 8500
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.10.0.0/16"]
  }  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "homework-sg"
  }
}