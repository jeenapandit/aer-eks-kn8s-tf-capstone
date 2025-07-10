# This is a project with Terraform and EKS

## Project Overview

This is a Terraform project that deploys a Space Invaders game application on Amazon EKS (Elastic Kubernetes Service).

### Project Structure

**EKS Infrastructure** (eks/):
- Creates an EKS cluster named "space-invaders" with managed node groups
- Sets up VPC with public/private subnets across 3 availability zones
- Configures security groups for SSH access to worker nodes
- Uses Terraform modules for EKS and VPC provisioning

**Kubernetes Application** (modules/website-config/):
- Deploys the Space Invaders container (`drehnstrom/space-invaders:v1.0`) 
- Creates a dedicated namespace for the application
- Sets up a Kubernetes deployment with 3 replicas
- Exposes the application via an AWS Load Balancer service

### Key Features

- **Container**: Runs a Space Invaders game accessible via web browser
- **High Availability**: 3 replicas across multiple node groups
- **Load Balancing**: AWS ELB automatically distributes traffic
- **Resource Management**: CPU/memory limits and requests configured
- **Infrastructure as Code**: Everything defined in Terraform

The cheat_sheet.txt provides kubectl commands to interact with the deployed application once the cluster is created.

## Getting Started

For detailed deployment instructions, please refer to [DEPLOYMENT.md](DEPLOYMENT.md) which contains step-by-step guidance for deploying this application on a Linux EC2 instance.