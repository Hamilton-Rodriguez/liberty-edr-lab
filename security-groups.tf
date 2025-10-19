
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

resource "aws_vpc_security_group_ingress_rule" "liberty-edr-lab-drs-replication-inbound-source" {
  security_group_id = aws_security_group.liberty-edr-lab-webserver-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 1500
  ip_protocol       = "tcp"
  to_port           = 1500
}

resource "aws_vpc_security_group_ingress_rule" "liberty-edr-lab-drs-control-inbound-source" {
  security_group_id = aws_security_group.liberty-edr-lab-webserver-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}



# Ingress adicionales Toño

resource "aws_vpc_security_group_ingress_rule" "liberty-edr-lab-webserver-sg-ingress-rule-http-80-xyz01" {
  security_group_id = aws_security_group.liberty-edr-lab-webserver-sg.id
  cidr_ipv4         = "192.168.1.0/24"
  #referenced_security_group_id = aws_security_group.liberty-edr-lab-appuser-sg.id
  from_port         = 5000
  ip_protocol       = "tcp"
  to_port           = 5000
}

resource "aws_vpc_security_group_ingress_rule" "liberty-edr-lab-webserver-sg-ingress-rule-http-80-xyz02" {
  security_group_id = aws_security_group.liberty-edr-lab-webserver-sg.id
  cidr_ipv4         = "192.168.2.0/24"
  #referenced_security_group_id = aws_security_group.liberty-edr-lab-appuser-sg.id
  from_port         = 5000
  ip_protocol       = "tcp"
  to_port           = 5000
}

resource "aws_vpc_security_group_ingress_rule" "liberty-edr-lab-webserver-sg-ingress-rule-http-80-xyz03" {
  security_group_id = aws_security_group.liberty-edr-lab-webserver-sg.id
  cidr_ipv4         = "192.168.1.0/24"
  #referenced_security_group_id = aws_security_group.liberty-edr-lab-appuser-sg.id
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "liberty-edr-lab-webserver-sg-ingress-rule-http-80-xyz04" {
  security_group_id = aws_security_group.liberty-edr-lab-webserver-sg.id
  cidr_ipv4         = "192.168.2.0/24"
  #referenced_security_group_id = aws_security_group.liberty-edr-lab-appuser-sg.id
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "liberty-edr-lab-webserver-sg-ingress-rule-http-80-xyz05" {
  security_group_id = aws_security_group.liberty-edr-lab-webserver-sg.id
  cidr_ipv4         = "192.168.1.0/24"
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




#### PUBLIC SECURITY GROUP

resource "aws_security_group" "liberty-edr-lab-webserver-sg-public" {
  name        = "liberty-edr-lab-webserver-sg-public"
  description = "Allow http inbound traffic and all outbound traffic"
  vpc_id = aws_vpc.liberty-edr-lab-vpc.id

  tags = {
    Name = "allow_http"
  }
}

# TEMP
#resource "aws_vpc_security_group_ingress_rule" "liberty-edr-lab-webserver-sg-ingress-rule-http-80-public-full-temp" {
#  security_group_id = aws_security_group.liberty-edr-lab-webserver-sg-public.id
#  cidr_ipv4         = "0.0.0.0/0"
#  #referenced_security_group_id = aws_security_group.liberty-edr-lab-appuser-sg.id
#  from_port         = 0
#  ip_protocol       = -1
#  to_port           = 0
#}

resource "aws_vpc_security_group_ingress_rule" "liberty-edr-lab-webserver-sg-ingress-rule-http-80-public" {
  security_group_id = aws_security_group.liberty-edr-lab-webserver-sg-public.id
  cidr_ipv4         = "0.0.0.0/0"
  #referenced_security_group_id = aws_security_group.liberty-edr-lab-appuser-sg.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "liberty-edr-lab-drs-replication-inbound-source-public" {
  security_group_id = aws_security_group.liberty-edr-lab-webserver-sg-public.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 1500
  ip_protocol       = "tcp"
  to_port           = 1500
}

resource "aws_vpc_security_group_ingress_rule" "liberty-edr-lab-drs-control-inbound-source-public" {
  security_group_id = aws_security_group.liberty-edr-lab-webserver-sg-public.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "liberty-edr-lab-webserver-sg-egress-rule-all-traffic-public" {
  security_group_id = aws_security_group.liberty-edr-lab-webserver-sg-public.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}