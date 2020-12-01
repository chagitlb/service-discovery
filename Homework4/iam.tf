# ---------------------------------------------------------------------------------------------------------------------
# ATTACH AN IAM POLICY THAT ALLOWS THE CONSUL NODES TO AUTOMATICALLY DISCOVER EACH OTHER AND FORM A CLUSTER
# ---------------------------------------------------------------------------------------------------------------------

# resource "aws_iam_role_policy" "auto_discover_cluster" {
# #   count  = var.enabled ? 1 : 0
#   name   = "auto-discover-cluster"
#   role   = var.iam_role_id
#   policy = data.aws_iam_policy_document.auto_discover_cluster.json
# }

# data "aws_iam_policy_document" "auto_discover_cluster" {
#   statement {
#     effect = "Allow"

#     actions = [
#       "ec2:DescribeInstances",
#       "ec2:DescribeTags",
#       "autoscaling:DescribeAutoScalingGroups",
#     ]

#     resources = ["*"]
#   }
# }


# Create an IAM role for the auto-join
resource "aws_iam_role" "consul-join" {
  name               = "chagit-consul-join"
  assume_role_policy = var.assume_role
}

# Create the policy
resource "aws_iam_policy" "consul-join" {
  name        = "chagit-consul-join"
  description = "Allows Consul nodes to describe instances for joining."
  policy      = var.describe_instances
  
}

# Attach the policy
resource "aws_iam_policy_attachment" "consul-join" {
  name       = "chagit-consul-join"
  roles      = [aws_iam_role.consul-join.name]
  policy_arn = aws_iam_policy.consul-join.arn
}

# Create the instance profile
resource "aws_iam_instance_profile" "consul-join" {
  name  = "chagit-consul-join"
  role = aws_iam_role.consul-join.name
}