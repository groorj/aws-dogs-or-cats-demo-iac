
# Add ssh key
resource "aws_key_pair" "dogsorcats-key" {
  key_name   = "dogsorcats-key"
  public_key = "<your-public-key-value>"
}

# Create Security Group - bastion host
resource "aws_security_group" "jumphost" {
  vpc_id      = aws_vpc.vpc.id
  name        = "SecurityGroup-Jumphost"
  description = "Security Group for the Jumphost."

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["<your-ip-address>/32"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "SecurityGroup-Jumphost"
    Application = "dogs-or-cats.com"
  } 
}
# Create EC2 Instance - bastion host
resource "aws_instance" "jumphost" {
  instance_type               = "t3.micro"
  ami                         = "<your-ami-id>"
  vpc_security_group_ids      = [aws_security_group.jumphost.id]
  subnet_id                   = aws_subnet.public-subnet-1.id
  key_name                    = "dogsorcats-key"
  associate_public_ip_address = true
  user_data                   = ""

  tags = {
    Name        = "jumphost"
    Application = "dogs-or-cats.com"
  }
}


# Create Security Group - application
resource "aws_security_group" "dogs-or-cats-app" {
  vpc_id      = aws_vpc.vpc.id
  name        = "SecurityGroup-DogsOrCatsApp"
  description = "Security Group for the dogs-or-cats.com app."

  ingress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "SecurityGroup-DogsOrCatsApp"
    Application = "dogs-or-cats.com"
  } 
}

# Create EC2 Instance - application
resource "aws_instance" "instance-1" {
  instance_type               = "t3.micro"
  ami                         = "<your-ami-id>"
  vpc_security_group_ids      = [aws_security_group.dogs-or-cats-app.id]
  subnet_id                   = aws_subnet.private-subnet-1.id
  key_name                    = "dogsorcats-key"
  associate_public_ip_address = false
  user_data                   = file("user-data.sh")
  iam_instance_profile        = aws_iam_instance_profile.instance_profile.name

  tags = {
    Name        = "Prod-DogsOrCatsApp-1"
    Application = "dogs-or-cats.com Web"
    Environment = "Prod"
  }
}

# Output
output "jumphost-public-ip" {
  value = aws_instance.jumphost.public_ip
}

# End;