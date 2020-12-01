module "public_servers" {
  source           = "./InstanceModule"
  name            = "nginx server"
  subnets          = module.vpc.public_subnets
  instance_type   = var.instance_type
  ami_id           = data.aws_ami.ubuntu.id
  key_name         = aws_key_pair.terraform-key.key_name
  security_groups  = [aws_security_group.public-sg.id]
  user_data        = file("consul-agent.sh")
  # cluster_tag_key   = "consul-cluster"
  # cluster_tag_value = "consul-cluster-example"
  tags             = {Name = "web server"}
}
