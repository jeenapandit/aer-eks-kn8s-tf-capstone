output "lb_status" {
  value = kubernetes_service.service.status
}

output "load_balancer_dns" {
  description = "DNS name of the load balancer"
  value       = kubernetes_service.service.status.0.load_balancer.0.ingress.0.hostname
}

output "load_balancer_ip" {
  description = "IP address of the load balancer (if available)"
  value       = try(kubernetes_service.service.status.0.load_balancer.0.ingress.0.ip, null)
}