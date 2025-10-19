
#
#resource "aws_instance" "liberty-edr-lab-linux-webserver-ec2" {
#  #ami                     = "ami-08982f1c5bf93d976"
#  ami                     = "ami-0341d95f75f311023"
#  # Amazon Linux 2023 AMI 2023.8.20250915.0 x86_64 HVM kernel-6.1
#  instance_type           = "t2.micro"
#  subnet_id               = aws_subnet.liberty-edr-lab-subnet-private1-us-east-1a.id
#  #key_name                = data.aws_key_pair.liberty-edr-lab-linux-key.key_name
#  vpc_security_group_ids  = [aws_security_group.liberty-edr-lab-webserver-sg.id]
#  # Instance profile
#  iam_instance_profile    = aws_iam_instance_profile.liberty-edr-lab-ec2-ssm-profile.name
#  #user_data               = file("scripts/user-data.sh")
#  tags = {
#    Name = "liberty-edr-lab-linux-webserver-ec2"
#    Project = "csd-edr-lab"
#    Created-by = "terraform"
#    Date-created = "28-09-2025"
#  }
#  depends_on = [ aws_nat_gateway.liberty-edr-lab-nat-public1-us-east-1a ]
#  metadata_options {
#  http_tokens                 = "required"
#  http_endpoint               = "enabled"
#  http_put_response_hop_limit = 2
#  }
#  user_data = <<-EOF
#    #!/bin/bash
#    yum update -y
#    yum install -y python3
#    yum install -y httpd
#    systemctl enable httpd
#    systemctl start httpd
#    echo "<h1>Hello from EC2 $(hostname) - V1</h1>" > /var/www/html/index.html
#  EOF
#}
#







#### PUBLIC INSTANCE #####


resource "aws_instance" "liberty-edr-lab-linux-webserver-ec2-public" {
  ami                     = "ami-08982f1c5bf93d976"
  #ami                     = "ami-0fd3ac4abb734302a"
  # Amazon Linux 2023 AMI 2023.8.20250915.0 x86_64 HVM kernel-6.1
  instance_type           = "t2.small"
  subnet_id               = aws_subnet.liberty-edr-lab-subnet-public1-us-east-1a.id
  #key_name                = data.aws_key_pair.liberty-edr-lab-linux-key.key_name
  vpc_security_group_ids  = [aws_security_group.liberty-edr-lab-webserver-sg-public.id]
  # Instance profile
  iam_instance_profile    = aws_iam_instance_profile.liberty-edr-lab-ec2-ssm-profile.name
  #user_data               = file("scripts/user-data.sh")
  associate_public_ip_address = true
  tags = {
    Name = "liberty-edr-lab-linux-webserver-ec2-public"
    Project = "csd-edr-lab"
    Created-by = "terraform"
    Date-created = "28-09-2025"
  }
  depends_on = [ aws_nat_gateway.liberty-edr-lab-nat-public1-us-east-1a ]
  metadata_options {
  http_tokens                 = "required"
  http_endpoint               = "enabled"
  http_put_response_hop_limit = 2
  }
  lifecycle {
    ignore_changes = [
      associate_public_ip_address   # Para el failover - El estado STOP forza el replacement
    ]
  }
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y python3
    yum install -y httpd
    systemctl enable httpd
    systemctl start httpd
    echo "<h1>Hello from EC2 $(hostname) - V1</h1>" > /var/www/html/index.html
  EOF
}







# Instance profile for EC2

resource "aws_iam_instance_profile" "liberty-edr-lab-ec2-ssm-profile" {
  name = "liberty-edr-lab-ec2-ssm-profile"
  role = aws_iam_role.liberty-edr-lab-ec2-ssm-role.name
}