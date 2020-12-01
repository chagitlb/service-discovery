
terraform {
  required_version = ">= 0.12.26"
}

# CREATE AN AUTO SCALING GROUP (ASG) TO RUN CONSUL

resource "aws_autoscaling_group" "autoscaling_group" {
  name_prefix = var.cluster_name

  launch_configuration = aws_launch_configuration.launch_configuration.name

  availability_zones  = var.availability_zones
  
  # Run a fixed number of instances in the ASG
  min_size             = var.cluster_size
  max_size             = var.cluster_size
  desired_capacity     = var.cluster_size


  tags = flatten(
    [
      {
        key                 = "Name"
        value               = var.cluster_name
        propagate_at_launch = true
      },
      {
        key                 = var.cluster_tag_key
        value               = var.cluster_tag_value
        propagate_at_launch = true
      },
      var.tags,
    ]
  )
}

# CREATE LAUNCH CONFIGURATION TO DEFINE WHAT RUNS ON EACH INSTANCE IN THE ASG

resource "aws_launch_configuration" "launch_configuration" {
  name_prefix   = "${var.cluster_name}-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  user_data     = var.user_data
  key_name = var.ssh_key_name

  security_groups = var.security_groups
  associate_public_ip_address = var.associate_public_ip_address

  lifecycle {
    create_before_destroy = true
  }
}
