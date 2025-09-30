
resource "aws_security_group" "liberty-edr-lab-webserver-sg" {
  name        = "liberty-edr-lab-webserver-sg"
  description = "Allow Flask inbound traffic and all outbound traffic"
  vpc_id = aws_vpc.liberty-edr-lab-vpc.id

  tags = {
    Name = "allow_http"
  }
}

resource "aws_vpc_security_group_ingress_rule" "liberty-edr-lab-webserver-sg-ingress-rule-http-80" {
  security_group_id = aws_security_group.liberty-edr-lab-webserver-sg.id
  cidr_ipv4         = "192.168.2.0/24"
  #referenced_security_group_id = aws_security_group.liberty-edr-lab-appuser-sg.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

#resource "aws_vpc_security_group_ingress_rule" "liberty-edr-lab-webserver-sg-ingress-rule-ssh-22" {
#  security_group_id = aws_security_group.liberty-edr-lab-webserver-sg.id
#  #cidr_ipv4         = "0.0.0.0/32" # Reemplazar por el SG del bastion
#  referenced_security_group_id = aws_security_group.liberty-edr-lab-appuser-sg.id
#  from_port         = 22
#  ip_protocol       = "tcp"
#  to_port           = 22
#}

resource "aws_vpc_security_group_egress_rule" "liberty-edr-lab-webserver-sg-egress-rule-all-traffic" {
  security_group_id = aws_security_group.liberty-edr-lab-webserver-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

##


#resource "aws_security_group" "liberty-edr-lab-database-sg" {
#  name        = "liberty-edr-lab-database-sg"
#  description = "Allow MySql and SSH inbound traffic from the application SG and all outbound traffic"
#  vpc_id = aws_vpc.liberty-edr-lab-vpc.id
#
#  tags = {
#    Name = "allow_mysql and SSH"
#  }
#}
#
#resource "aws_vpc_security_group_ingress_rule" "liberty-edr-lab-database-sg-ingress-rule-tcp-3306" {
#  security_group_id = aws_security_group.liberty-edr-lab-database-sg.id
#  referenced_security_group_id = aws_security_group.liberty-edr-lab-webserver-sg.id
#  from_port         = 3306
#  ip_protocol       = "tcp"
#  to_port           = 3306
#}
#
#resource "aws_vpc_security_group_ingress_rule" "liberty-edr-lab-database-sg-ingress-rule-tcp-22" {
#  security_group_id = aws_security_group.liberty-edr-lab-database-sg.id
#  referenced_security_group_id = aws_security_group.liberty-edr-lab-webserver-sg.id
#  from_port         = 22
#  ip_protocol       = "tcp"
#  to_port           = 22
#}
#
#resource "aws_vpc_security_group_egress_rule" "liberty-edr-lab-database-sg-egress-rule-all-traffic" {
#  security_group_id = aws_security_group.liberty-edr-lab-database-sg.id
#  cidr_ipv4         = "0.0.0.0/0"
#  ip_protocol       = "-1"
#}


##

#resource "aws_security_group" "liberty-edr-lab-appuser-sg" {
#  name        = "liberty-edr-lab-appuser-sg"
#  description = "Accessed from SSM and all outbound traffic"
#  vpc_id = aws_vpc.liberty-edr-lab-vpc.id
#
#  tags = {
#    Name = "liberty-edr-lab-appuser-sg"
#  }
#}
#
#resource "aws_vpc_security_group_egress_rule" "liberty-edr-lab-appuser-sg-egress-rule-all-traffic" {
#  security_group_id = aws_security_group.liberty-edr-lab-appuser-sg.id
#  cidr_ipv4         = "0.0.0.0/0"
#  ip_protocol       = "-1"
#}

