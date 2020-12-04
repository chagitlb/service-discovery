output "vpc_id" {
  description = "VPC id"
  value       = aws_vpc.vpc.id
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public-subnet.*.id
}
