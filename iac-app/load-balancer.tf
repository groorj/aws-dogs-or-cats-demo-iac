# Create Security Group - load balancer
resource "aws_security_group" "lb-dogs-or-cats-app" {
  vpc_id      = aws_vpc.vpc.id
  name        = "SecurityGroup-LB-DogsOrCatsApp"
  description = "Security Group for the dogs-or-cats.com app Load Balancer."

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "SecurityGroup-LB-DogsOrCatsApp"
    Application = "dogs-or-cats.com"
  } 
}

# Create a new load balancer
resource "aws_elb" "dogs-or-cats-elb" {
  name               = "dogs-or-cats-elb"
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id, aws_subnet.public-subnet-3.id]
  security_groups    = [aws_security_group.lb-dogs-or-cats-app.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 5
  }

  instances                   = [aws_instance.instance-1.id]
  #instances                   = [aws_instance.instance-1.id, aws_instance.instance-2.id, aws_instance.instance-3.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 10
  connection_draining         = false

  tags = {
    Name = "dogs-or-cats-elb"
    Application = "dogs-or-cats.com"
  }
}

# Output
output "loadbalancer_dns_name" {
  value = aws_elb.dogs-or-cats-elb.dns_name
}

# End;
