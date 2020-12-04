output "server" {
  value = module.consul_cluster.asg_name
}

output "agent" {
  value = module.public_servers.public_ips
}