module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name = "${var.project}-vpc"

  cidr = "10.0.0.0/16"
  azs  = slice(data.aws_availability_zones.available.names, 0, 3)

  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  # Custom naming for VPC components
  igw_tags = {
    Name = "${var.project}-igw"
  }
  
  nat_gateway_tags = {
    Name = "${var.project}-nat-gw"
  }
  
  private_route_table_tags = {
    Name = "${var.project}-private-rt"
  }
  
  public_route_table_tags = {
    Name = "${var.project}-public-rt"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = 1
    Name = "${var.project}-public-subnet"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
    Name = "${var.project}-private-subnet"
  }
}
