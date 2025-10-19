

#resource "aws_instance" "liberty-edr-lab-linux-webserver-ec2-secondary" {
#  provider = aws.useast2
#  ami                     = "ami-0ca4d5db4872d0c28"
#  # Amazon Linux 2023 AMI 2023.8.20250915.0 x86_64 HVM kernel-6.1
#  instance_type           = "t2.micro"
#  subnet_id               = aws_subnet.liberty-edr-lab-subnet-private1-us-east-2a.id
#  #key_name                = data.aws_key_pair.liberty-edr-lab-linux-key.key_name
#  vpc_security_group_ids  = [aws_security_group.liberty-edr-lab-webserver-sg-secondary.id]
#  # Instance profile
#  iam_instance_profile    = aws_iam_instance_profile.liberty-edr-lab-ec2-ssm-profile-secondary.name
#  #user_data               = file("scripts/user-data.sh")
#  tags = {
#    Name = "liberty-edr-lab-linux-webserver-ec2-secondary"
#    Project = "csd-edr-lab"
#    Created-by = "terraform"
#    Date-created = "28-09-2025"
#  }
#  depends_on = [ aws_nat_gateway.liberty-edr-lab-nat-public1-us-east-2a ]
#  user_data = <<-EOF
#    #!/bin/bash
#    yum update -y
#    yum install -y httpd
#    systemctl enable httpd
#    systemctl start httpd
#    echo "<h1>Hello from EC2 $(hostname) - V1</h1>" > /var/www/html/index.html
#  EOF
#}
#

# Instance profile for EC2




# Posiblemente sobre este rol secundario

#resource "aws_iam_instance_profile" "liberty-edr-lab-ec2-ssm-profile-secondary" {
#  provider = aws.useast2
#  name = "liberty-edr-lab-ec2-ssm-profile-secondary"
#  role = aws_iam_role.liberty-edr-lab-ec2-ssm-role-2.name
#}