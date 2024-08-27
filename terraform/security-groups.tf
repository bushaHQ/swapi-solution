resource "aws_security_group" "busha_node1_sg" {
  name_prefix = "busha_sg"

  vpc_id = module.vpc.vpc_id
  
  ingress {
    from_port = 0
    to_port = -1

    protocol = "tcp"

    cidr_blocks = [
        "10.0.0.0/16",
    ]
  }
  egress {
    from_port = 0
    to_port = -1

    protocol = "tcp"

    cidr_blocks = [
        "10.0.0.0/16",
    ]
  }

}

resource "aws_security_group" "busha_node2_sg" {
  name_prefix = "busha_sg"

  vpc_id = module.vpc.vpc_id
  
  ingress {
    from_port = 0
    to_port = -1

    protocol = "tcp"

    cidr_blocks = [
        "10.0.0.0/16",
    ]
  }
  egress {
    from_port = 0
    to_port = -1

    protocol = "tcp"

    cidr_blocks = [
        "10.0.0.0/16",
    ]
  }

}