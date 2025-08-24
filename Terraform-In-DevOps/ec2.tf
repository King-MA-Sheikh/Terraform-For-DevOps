# key-par (login)

resource "aws_key_pair" "my_key_new" {
  key_name   = "terra_key_ec2"
  public_key = file("terra-key-ec2.pub")
}

# VPC & Security Group

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "my_security_group" {
  name        = "automate-sg"
  description = "This will add a TF generated security group"
  vpc_id      = aws_default_vpc.default.id #Interpolaion

  #inbound rules

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"         # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
    description = "Allow SSH access from anywhere"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP Open"
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Flask app"
  }

  #outbound rules

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "automate-sg"
  }
}

# EC2 Instance

resource "aws_instance" "my_instance" {
    for_each = tomap({
      automate-micro = "t3.micro",
      automate-medium = "t3.medium"
    }) #meta argument

    depends_on = [aws_security_group.my_security_group, aws_key_pair.my_key_new]

    ami                    = var.ec2_ami_id
    instance_type          = each.value
    key_name               = aws_key_pair.my_key_new.key_name
    vpc_security_group_ids = [aws_security_group.my_security_group.id]
    user_data              = file("install_nginx.sh")

    root_block_device {
        volume_size = var.env == "prd" ? 20 : var.ec2_default_root_storage_size
        volume_type = "gp3"
    }

    tags = {
        Name = each.key
        Environment = var.env
    }
}