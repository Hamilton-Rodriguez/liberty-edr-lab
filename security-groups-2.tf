
resource "aws_security_group" "liberty-edr-lab-webserver-sg-secondary" {
  provider = aws.useast2
  name        = "liberty-edr-lab-webserver-sg"  # Agregar en el nombre el Secondary
  description = "Allow Flask inbound traffic and all outbound traffic"
  vpc_id = aws_vpc.liberty-edr-lab-vpc-2.id

  tags = {
    Name = "allow_http"
  }
}

resource "aws_vpc_security_group_ingress_rule" "liberty-edr-lab-webserver-sg-ingress-rule-http-80-secondary" {
  provider = aws.useast2
  security_group_id = aws_security_group.liberty-edr-lab-webserver-sg-secondary.id
  cidr_ipv4         = "192.168.1.0/24"
  #referenced_security_group_id = aws_security_group.liberty-edr-lab-appuser-sg.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "liberty-edr-lab-webserver-sg-egress-rule-all-traffic-secondary" {
  provider = aws.useast2
  security_group_id = aws_security_group.liberty-edr-lab-webserver-sg-secondary.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}







#### PUBLIC SECURITY GROUP - REPLICATION SERVER

#resource "aws_security_group" "liberty-edr-lab-replication-server-sg-public-secondary" {
#  provider = aws.useast2
#  name        = "liberty-edr-lab-replication-server-sg-public-secondary"
#  description = "Allow inbound replication traffic and all outbound traffic"
#  vpc_id = aws_vpc.liberty-edr-lab-vpc-2.id
#
#  tags = {
#    Name = "allow_1500"
#  }
#}
#
## TEMP
##resource "aws_vpc_security_group_ingress_rule" "liberty-edr-lab-drs-replication-inbound-source-public-secondary-full-temp" {
##  provider = aws.useast2
##  security_group_id = aws_security_group.liberty-edr-lab-replication-server-sg-public-secondary.id
##  cidr_ipv4         = "0.0.0.0/0"
##  from_port         = 0
##  ip_protocol       = -1
##  to_port           = 0
##}
#
#resource "aws_vpc_security_group_ingress_rule" "liberty-edr-lab-drs-replication-inbound-source-public-secondary" {
#  provider = aws.useast2
#  security_group_id = aws_security_group.liberty-edr-lab-replication-server-sg-public-secondary.id
#  cidr_ipv4         = "0.0.0.0/0"
#  from_port         = 1500
#  ip_protocol       = "tcp"
#  to_port           = 1500
#}
#
#resource "aws_vpc_security_group_ingress_rule" "liberty-edr-lab-drs-control-inbound-source-public-secondary" {
#  provider = aws.useast2
#  security_group_id = aws_security_group.liberty-edr-lab-replication-server-sg-public-secondary.id
#  cidr_ipv4         = "0.0.0.0/0"
#  from_port         = 443
#  ip_protocol       = "tcp"
#  to_port           = 443
#}
#
#resource "aws_vpc_security_group_egress_rule" "liberty-edr-lab-drs-control-sg-egress-rule-all-traffic-public-secondary" {
#  provider = aws.useast2
#  security_group_id = aws_security_group.liberty-edr-lab-replication-server-sg-public-secondary.id
#  cidr_ipv4         = "0.0.0.0/0"
#  ip_protocol       = "-1"
#}






#### PUBLIC SECURITY GROUP - REPLICATED INSTANCES


resource "aws_security_group" "liberty-edr-lab-webserver-sg-public-secondary" {
  provider = aws.useast2
  name        = "liberty-edr-lab-webserver-sg-public-secondary"
  description = "Allow http inbound traffic and all outbound traffic"
  vpc_id = aws_vpc.liberty-edr-lab-vpc-2.id

  tags = {
    Name = "allow_http"
  }
}

resource "aws_vpc_security_group_ingress_rule" "liberty-edr-lab-webserver-sg-ingress-rule-http-80-public-secondary" {
  provider = aws.useast2
  security_group_id = aws_security_group.liberty-edr-lab-webserver-sg-public-secondary.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "liberty-edr-lab-webserver-sg-egress-rule-all-traffic-public-secondary" {
  provider = aws.useast2
  security_group_id = aws_security_group.liberty-edr-lab-webserver-sg-public-secondary.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}




