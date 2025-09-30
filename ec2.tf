
#resource "aws_instance" "liberty-edr-lab-linux-webserver-ec2" {
#  ami                     = "ami-08982f1c5bf93d976"
#  # Amazon Linux 2023 AMI 2023.8.20250915.0 x86_64 HVM kernel-6.1
#  instance_type           = "t2.micro"
#  subnet_id               = aws_subnet.liberty-edr-lab-subnet-private1-us-east-1a.id
#  key_name                = data.aws_key_pair.liberty-edr-lab-linux-key.key_name
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
#  user_data = <<-EOF
#    #!/bin/bash
#    sudo dnf install -y python3.9-pip
#    pip install virtualenv
#    sudo dnf install -y git
#    pip install flask
#    pip install mysql-connector-python
#    pip install boto3
#    git clone https://github.com/jhormanvillanueva/ec2-databases.git
#    git clone https://github.com/Hamilton-Rodriguez/hamilton-custom-flask.git
#  EOF
#}



###########



resource "aws_instance" "liberty-edr-lab-linux-webserver-ec2" {
  ami                     = "ami-08982f1c5bf93d976"
  # Amazon Linux 2023 AMI 2023.8.20250915.0 x86_64 HVM kernel-6.1
  instance_type           = "t2.micro"
  subnet_id               = aws_subnet.liberty-edr-lab-subnet-private1-us-east-1a.id
  key_name                = data.aws_key_pair.liberty-edr-lab-linux-key.key_name
  vpc_security_group_ids  = [aws_security_group.liberty-edr-lab-webserver-sg.id]
  # Instance profile
  iam_instance_profile    = aws_iam_instance_profile.liberty-edr-lab-ec2-ssm-profile.name
  #user_data               = file("scripts/user-data.sh")
  tags = {
    Name = "liberty-edr-lab-linux-webserver-ec2"
    Project = "csd-edr-lab"
    Created-by = "terraform"
    Date-created = "28-09-2025"
  }
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl enable httpd
    systemctl start httpd
    echo "<h1>Hello from EC2 $(hostname) - V1</h1>" > /var/www/html/index.html
  EOF
}











###########

#resource "aws_instance" "liberty-edr-lab-linux-database-ec2" {
#  ami                     = "ami-08982f1c5bf93d976"
#  instance_type           = "t2.micro"
#  subnet_id               = aws_subnet.liberty-edr-lab-subnet-private3-us-east-1a.id
#  key_name                = data.aws_key_pair.liberty-edr-lab-linux-key.key_name
#  vpc_security_group_ids  = [aws_security_group.liberty-edr-lab-database-sg.id]
#  # Instance profile
#  iam_instance_profile    = aws_iam_instance_profile.liberty-edr-lab-ec2-ssm-profile.name
#  tags = {
#    Name = "liberty-edr-lab-linux-database-ec2"
#    Project = "csd-edr-lab"
#    Created-by = "terraform"
#    Date-created = "28-09-2025"
#  }
#  user_data = <<-EOF
#    #!/bin/bash
#    sudo dnf install -y mariadb105-server
#    sudo dnf install -y git
#    sudo service mariadb start
#    sudo chkconfig mariadb on
#    git clone https://github.com/jhormanvillanueva/ec2-databases.git
#    sudo mv ec2-databases /home/ec2-user
#  EOF
#}

###########


#resource "aws_instance" "liberty-edr-lab-windows-user-ec2" {
#  ami                     = "ami-0f6d3d1de3c02ee19"
#  # Microsoft Windows Server 2019 with Desktop Experience Locale English
#  instance_type           = "t2.micro"
#  subnet_id               = aws_subnet.liberty-edr-lab-subnet-private1-us-east-1a.id
#  key_name                = data.aws_key_pair.liberty-edr-lab-windows-key.key_name
#  vpc_security_group_ids  = [aws_security_group.liberty-edr-lab-appuser-sg.id]
#  # Instance profile
#  iam_instance_profile    = aws_iam_instance_profile.liberty-edr-lab-ec2-ssm-profile.name
#  #user_data               = file("scripts/user-data.sh")
#  tags = {
#    Name = "liberty-edr-lab-windows-user-ec2"
#    Project = "csd-edr-lab"
#    Created-by = "terraform"
#    Date-created = "28-09-2025"
#  }
#}








# Instance profile for EC2

resource "aws_iam_instance_profile" "liberty-edr-lab-ec2-ssm-profile" {
  name = "liberty-edr-lab-ec2-ssm-profile"
  role = aws_iam_role.liberty-edr-lab-ec2-ssm-role.name
}