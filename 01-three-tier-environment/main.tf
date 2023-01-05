# Create a VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "example-vpc"
  }
}

# Create an EC2 instance
resource "aws_instance" "web" {
  ami           = "ami-0f65671a86f061fcd"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  key_name             = "mykey"
  subnet_id            = aws_subnet.web.id
  associate_public_ip_address = true
  tags = {
    Name = "example-web"
  }
}

# Retrieve the secrets from Vault
resource "vault_generic_secret" "rds_secrets" {
  path = "secret/rds"
}

# Create an RDS instance
resource "aws_db_instance" "db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username          = "${vault_generic_secret.rds_secrets.data.username}"
  password          = "${vault_generic_secret.rds_secrets.data.password}"
  vpc_security_group_ids = [aws_security_group.db.id]
  publicly_accessible  = false
  tags = {
    Name = "example-db"
  }
}


# Create an ELB
resource "aws_elb" "elb" {
  name = "example-elb"
  security_groups = [aws_security_group.elb.id]
  subnets = [aws_subnet.web.id, aws_subnet.db.id]
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:80/health"
    interval = 30
  }
  tags = {
    Name = "example-elb"
  }
}

# Create security groups
resource "aws_security_group" "web" {
  name = "example-web-sg"
  description = "Security group for web servers"
  vpc_id = aws_vpc.example.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db" {
  name = "example-db-sg"
  description = "Security group for database servers"
  vpc_id = aws_vpc.example.id
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.web.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "elb" {
  name = "example-elb-sg"
  description = "Security group for the load balancer"
  vpc_id = aws_vpc.example.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create subnets
resource "aws_subnet" "web" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  tags = {
    Name = "example-web-subnet"
  }
}

resource "aws_subnet" "db" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2b"
  tags = {
    Name = "example-db-subnet"
  }
}
