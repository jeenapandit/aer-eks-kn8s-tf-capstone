resource "aws_security_group" "node_group_one" {
  name   = "${var.project}-ng-1-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
    ]
  }

  tags = {
    Name = "${var.project}-ng-1-sg"
  }
}

resource "aws_security_group" "node_group_two" {
  name   = "${var.project}-ng-2-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "192.168.0.0/16",
    ]
  }

  tags = {
    Name = "${var.project}-ng-2-sg"
  }
}
