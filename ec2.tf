data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_launch_template" "web_lt" {
  name_prefix   = "web-lt-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  user_data              = file("${path.module}/user_data.sh")
  key_name               = "my-key-pair"
}

resource "aws_autoscaling_group" "web_asg" {
  name                = "web-asg"
  desired_capacity    = 2
  max_size            = 3
  min_size            = 2
  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }
  vpc_zone_identifier = var.public_subnets

  target_group_arns = [aws_lb_target_group.app_tg.arn]
  health_check_type = "ELB"
}

# 3rd EC2 for BI tool
resource "aws_instance" "bi_instance" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t3.small"
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  subnet_id                   = element(var.public_subnets, 0)
  associate_public_ip_address = true
  user_data                   = <<-EOF
                #!/bin/bash
                yum update -y
                amazon-linux-extras install docker -y
                service docker start
                docker run -d --name metabase -p 3000:3000 metabase/metabase
                EOF
  key_name = "my-key-pair"
}