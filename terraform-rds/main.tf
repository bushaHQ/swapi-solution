provider "aws" {
  region = "us-east-1" # Change to your desired region
}

resource "aws_db_subnet_group" "postgres_subnet_group" {
  name       = "my-postgresql-subnet-group"
  subnet_ids = ["subnet-052b71b964effa1fe", "subnet-0fc5bb00744373ae3"] # Replace with your existing subnet IDs

  tags = {
    Name = "my-postgresql-subnet-group"
  }
}

resource "aws_db_instance" "postgres" {
  identifier        = "my-postgresql-db"
  engine            = "postgres"
  engine_version    = "14" # Adjust to your preferred version
  instance_class    = "db.t3.micro" # Choose an instance type suitable for your workload
  allocated_storage = 20 # Adjust storage size as needed (in GB)

  db_name           = "mydb"
  username          = "myuser"
  password          = "supersecretpassword" # Store sensitive data securely
  port              = 5432

  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.postgres_subnet_group.name

  publicly_accessible    = true # Make the database publicly accessible
  multi_az               = false # Set to true if you want multi-AZ deployments

  # Backup and maintenance
  backup_retention_period = 7
  maintenance_window      = "Sun:05:00-Sun:06:00"

  # Storage settings
  storage_encrypted = true

  # Optional: Monitoring and logging
  enabled_cloudwatch_logs_exports = ["postgresql"]

  tags = {
    Name = "my-postgresql-db"
  }
}

resource "aws_security_group" "db_sg" {
  name        = "allow-postgres"
  description = "Allow access to PostgreSQL"

  vpc_id = "vpc-0dd9035eac08853ff" # Replace with your existing VPC ID

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Open to all IPs, adjust to your needs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "postgres-sg"
  }
}
