
resource "aws_security_group" "liberty-edr-lab-webserver-sg-secondary" {
  provider = aws.useast2
  name        = "liberty-edr-lab-webserver-sg"
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
