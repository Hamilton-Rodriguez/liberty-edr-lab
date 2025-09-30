#
#resource "aws_vpc_peering_connection" "cross_region" {
#  vpc_id        = aws_vpc.vpc_a.id
#  peer_vpc_id   = aws_vpc.vpc_b.id
#  peer_region   = "us-east-2"
#  auto_accept   = false
#}
#
#resource "aws_vpc_peering_connection_accepter" "accept" {
#  provider                  = aws.useast2
#  vpc_peering_connection_id = aws_vpc_peering_connection.cross_region.id
#  auto_accept               = true
#}
#


# Request side

resource "aws_vpc_peering_connection" "liberty-edr-lab-vpc-peer" {
  vpc_id        = aws_vpc.liberty-edr-lab-vpc.id
  peer_vpc_id   = aws_vpc.liberty-edr-lab-vpc-2.id
  peer_region   = "us-east-2"
  auto_accept   = false
  tags = { Name = "liberty-edr-lab-vpc-peer" }
}


# Accept side

resource "aws_vpc_peering_connection_accepter" "liberty-edr-lab-peer_accept" {
  provider                  = aws.useast2
  vpc_peering_connection_id = aws_vpc_peering_connection.liberty-edr-lab-vpc-peer.id
  auto_accept               = true
  tags = { Name = "liberty-edr-lab-peer_accept" }
}
