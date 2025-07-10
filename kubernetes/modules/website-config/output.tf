output "lb_status" {
  value = kubernetes_service.service.status
}

output "load_balancer_dns" {
  description = "DNS name of the load balancer"
  value       = kubernetes_service.service.status.0.load_balancer.0.ingress.0.hostname
}