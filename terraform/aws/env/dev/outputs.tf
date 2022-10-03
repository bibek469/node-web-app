
output "cluster_name" {
  value       = module.ping-pong-cluster.cluster_name
  description = "Name of the cluster"
}

output "cluster_endpoint" {
  value       = module.ping-pong-cluster.cluster_endpoint
  description = "Endpoint for your Kubernetes API server."
}
