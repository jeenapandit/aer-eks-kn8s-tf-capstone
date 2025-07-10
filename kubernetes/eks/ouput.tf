output "cluster_id" {
  description = "EKS cluster ID"
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = local.cluster_name
}

output "load_balancer_dns" {
  description = "DNS name of the application load balancer"
  value       = module.kubernetes.load_balancer_dns
}

output "application_url" {
  description = "URL to access the Space Invaders application"
  value       = "http://${module.kubernetes.load_balancer_dns}"
}
