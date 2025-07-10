# Terraform Kubernetes Modules

This directory contains Terraform modules for deploying Kubernetes applications on AWS EKS.

## Module Structure

### website-config Module

The `website-config` module is a reusable Terraform module that deploys a containerized web application to an existing Kubernetes cluster with load balancing capabilities.

#### Purpose
This module creates all the necessary Kubernetes resources to deploy and expose a web application:
- Creates a dedicated namespace for the application
- Deploys the application with multiple replicas for high availability
- Exposes the application through an AWS Load Balancer

#### Module Files

| File | Description |
|------|-------------|
| `kubernetes-namespace.tf` | Creates a dedicated Kubernetes namespace for the application |
| `kubernetes-deployment.tf` | Defines the application deployment with 3 replicas, resource limits, and health checks |
| `kubernetes-load-balancer.tf` | Creates a LoadBalancer service to expose the application via AWS ELB |
| `variables.tf` | Input variables for the module (project name, container image) |
| `output.tf` | Output values including load balancer DNS and application URL |

#### Input Variables

| Variable | Type | Description | Required |
|----------|------|-------------|----------|
| `project` | string | Application name used for resource naming | Yes |
| `container` | string | Docker container image to deploy | Yes |

#### Outputs

| Output | Description |
|--------|-------------|
| `lb_status` | Complete load balancer status information |
| `load_balancer_dns` | DNS hostname of the AWS Load Balancer |

#### Usage Example

```hcl
module "kubernetes" {
  source = "./modules/website-config"

  project   = "space-invaders"
  container = "drehnstrom/space-invaders:v1.0"
}
```

#### Resource Configuration

**Deployment Specifications:**
- **Replicas**: 3 for high availability
- **Resource Limits**: 500Mi memory, 250m CPU
- **Resource Requests**: 100Mi memory, 100m CPU  
- **Health Checks**: Liveness and readiness probes on port 80
- **Container Port**: 80 (HTTP)

**Load Balancer Configuration:**
- **Type**: AWS Classic Load Balancer
- **Port**: 80 (HTTP)
- **Custom Naming**: Uses project name for load balancer identification

**Namespace:**
- Creates an isolated namespace named `{project}-namespace`
- All resources are deployed within this namespace

#### Prerequisites

- Existing Kubernetes cluster (EKS) with proper node groups
- AWS Load Balancer Controller or built-in Kubernetes LoadBalancer support
- Sufficient cluster resources for the deployment

#### Notes

- The module is designed for web applications that serve traffic on port 80
- Load balancer provides external access to the application
- All resources are tagged with the project name for easy identification
- The module supports any Docker container image that exposes port 80