provider "aws" {
  region = "us-east-1" # Change to your desired region
}

resource "aws_security_group" "redis_sg" {
  name        = "redis-public-sg"
  description = "Security group for public Redis access"
  vpc_id      = "vpc-0dd9035eac08853ff" # Replace with your VPC ID

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow access from all IPs (public)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "redis-public-sg"
  }
}

resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "redis-subnet-group"
  subnet_ids = ["subnet-0fc5bb00744373ae3", "subnet-052b71b964effa1fe"] # Replace with your existing subnet IDs

  tags = {
    Name = "redis-subnet-group"
  }
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "my-public-redis"
  engine               = "redis"
  node_type            = "cache.t2.micro" # Choose instance type based on your requirements
  num_cache_nodes      = 1 # Single node for Redis
  parameter_group_name = "default.redis7" # Adjust to your Redis version
  port                 = 6379

  subnet_group_name = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids = [
    aws_security_group.redis_sg.id
  ]

  apply_immediately = true

  tags = {
    Name = "my-public-redis"
  }
}
