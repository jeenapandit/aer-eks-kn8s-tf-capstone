# Deployment Guide - EKS Space Invaders Application

This guide provides step-by-step instructions for deploying the Space Invaders application on Amazon EKS using a Linux EC2 instance.

## Prerequisites

1. **Launch an EC2 Instance**:
   - Use Amazon Linux 2 or Ubuntu 20.04+ AMI
   - Instance type: t3.medium or larger (recommended)
   - Configure security group to allow SSH (port 22) access
   - Attach an IAM role with appropriate AWS permissions (see below)

2. **Required IAM Permissions**:
   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Action": [
           "eks:*",
           "ec2:*",
           "iam:*",
           "elasticloadbalancing:*",
           "autoscaling:*"
         ],
         "Resource": "*"
       }
     ]
   }
   ```

## Step 1: Connect to EC2 and Install Prerequisites

```bash
# Connect to your EC2 instance
ssh -i your-key.pem ec2-user@your-ec2-ip

# Update system packages
sudo yum update -y  # For Amazon Linux
# OR
sudo apt update && sudo apt upgrade -y  # For Ubuntu

# Install Git
sudo yum install -y git  # For Amazon Linux
# OR
sudo apt install -y git  # For Ubuntu
```

## Step 2: Install Terraform

```bash
# Download and install Terraform
wget https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip
sudo yum install -y unzip  # For Amazon Linux
# OR
sudo apt install -y unzip  # For Ubuntu

unzip terraform_1.6.0_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform version
```

## Step 3: Install AWS CLI

```bash
# Install AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Verify installation
aws --version

# Configure AWS CLI (if not using IAM role)
aws configure
```

## Step 4: Install kubectl

```bash
# Download kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Install kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Verify installation
kubectl version --client
```

## Step 5: Clone and Deploy the Project

```bash
# Clone the repository
git clone <your-repo-url>
cd aer-eks-kn8s-tf-capstone/kubernetes/eks

# Review and update terraform.tfvars
nano terraform.tfvars

# Initialize Terraform
terraform init

# Plan the deployment
terraform plan

# Apply the configuration
terraform apply
# Type 'yes' when prompted
```

## Step 6: Configure kubectl for EKS

```bash
# Update kubeconfig to connect to your EKS cluster
aws eks update-kubeconfig --region us-east-1 --name <your-cluster-name>

# Verify connection
kubectl get nodes
kubectl get pods --all-namespaces
```

## Step 7: Access the Application

```bash
# Get the load balancer URL
kubectl get service -n <your-namespace>

# The Space Invaders game will be accessible at the EXTERNAL-IP shown
# Example: http://your-loadbalancer-url.amazonaws.com
```

## Step 8: Monitor and Manage

```bash
# View application logs
kubectl logs -n <your-namespace> -l app=space-invaders

# Scale the deployment
kubectl scale deployment space-invaders --replicas=5 -n <your-namespace>

# Check cluster status
kubectl get all -n <your-namespace>
```

## Cleanup

```bash
# When done, destroy the infrastructure to avoid charges
terraform destroy
# Type 'yes' when prompted
```

## Troubleshooting

1. **Permission Issues**: Ensure your EC2 instance has the proper IAM role attached
2. **Network Issues**: Check security groups allow necessary ports
3. **Terraform Errors**: Run `terraform refresh` and try again
4. **kubectl Issues**: Verify AWS CLI is configured and EKS cluster is running

## Security Considerations

- Use IAM roles instead of hardcoded credentials
- Restrict security group rules to necessary ports only
- Regularly update Terraform and kubectl versions
- Monitor AWS costs during deployment

## Additional Resources

- [AWS EKS Documentation](https://docs.aws.amazon.com/eks/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
