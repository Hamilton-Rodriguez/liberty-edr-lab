
resource "aws_iam_role" "liberty-edr-lab-ec2-ssm-role" {
  name = "liberty-edr-lab-ec2-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Sid       = ""
        Principal = { Service = "ec2.amazonaws.com" }
      }
    ]
  })

  tags = {
    Name = "liberty-edr-lab-ec2-ssm-role"
    Project = "csd-edr-lab"
    Created-by = "terraform"
    Date-created = "28-09-2025"
  }
}


resource "aws_iam_role_policy_attachment" "role-policy-attachment-liberty-edr-lab-ec2-ssm-role" {
  role       = aws_iam_role.liberty-edr-lab-ec2-ssm-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

#resource "aws_iam_role_policy_attachment" "role-policy-attachment-liberty-edr-lab-edr-ec2-instance-policy" {
#  role       = aws_iam_role.liberty-edr-lab-ec2-ssm-role.name
#  policy_arn = "arn:aws:iam::aws:policy/AWSElasticDisasterRecoveryEc2InstancePolicy"
#}
#
#resource "aws_iam_role_policy_attachment" "role-policy-attachment-liberty-edr-lab-failback-2-agent-installation-policy" {
#  role       = aws_iam_role.liberty-edr-lab-ec2-ssm-role.name
#  policy_arn = "arn:aws:iam::aws:policy/AWSElasticDisasterRecoveryRecoveryInstancePolicy"
#}






# OTROS ROLES

#resource "aws_iam_role_policy_attachment" "role-policy-attachment-liberty-edr-lab-ec2-ssm-role-s3-full" {
#  role       = aws_iam_role.liberty-edr-lab-ec2-ssm-role.name
#  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
#}

#resource "aws_iam_role_policy_attachment" "role-policy-attachment-liberty-edr-lab-agent-installation-policy" {
#  role       = aws_iam_role.liberty-edr-lab-ec2-ssm-role.name
#  policy_arn = "arn:aws:iam::aws:policy/AWSElasticDisasterRecoveryAgentInstallationPolicy"
#}

#resource "aws_iam_role_policy_attachment" "role-policy-attachment-liberty-edr-lab-edr-agent-policy" {
#  role       = aws_iam_role.liberty-edr-lab-ec2-ssm-role.name
#  policy_arn = "arn:aws:iam::aws:policy/AWSElasticDisasterRecoveryAgentPolicy"
#}

#resource "aws_iam_role_policy_attachment" "role-policy-attachment-liberty-edr-lab-failback-agent-installation-policy" {
#  role       = aws_iam_role.liberty-edr-lab-ec2-ssm-role.name
#  policy_arn = "arn:aws:iam::aws:policy/AWSElasticDisasterRecoveryFailbackInstallationPolicy"
#}

#resource "aws_iam_role_policy_attachment" "role-policy-attachment-liberty-edr-lab-edr-ec2-2-instance-policy" {
#  role       = aws_iam_role.liberty-edr-lab-ec2-ssm-role.name
#  policy_arn = "arn:aws:iam::aws:policy/AWSElasticDisasterRecoveryEc2InstancePolicy"
#}
#






# Esto tuvo que agregarse manualmente desde la consola
#resource "aws_iam_role_policy_attachment" "role-policy-attachment-liberty-edr-lab-ec2-ssm-role-drs-ec2" {
#  role       = aws_iam_role.liberty-edr-lab-ec2-ssm-role.name
#  policy_arn = "arn:aws:iam::aws:policy/AWSElasticDisasterRecoveryEc2InstancePolicy"
#}

#resource "aws_iam_policy" "liberty-edr-lab-drs-agent-policy" {
#  name        = "liberty-edr-lab-drs-agent-policy"
#  description = "Permissions for AWS DRS Replication Agent installation and registration"
#
#  policy = jsonencode({
#    Version = "2012-10-17"
#    Statement = [
#      {
#        Effect = "Allow"
#        Action = [
#          "drs:CreateSourceServer",
#          "drs:DescribeSourceServers",
#          "drs:UpdateSourceServer",
#          "drs:StartReplication",
#          "drs:TagResource",
#          "ec2:DescribeInstances",
#          "ec2:DescribeTags",
#          "sts:GetCallerIdentity",
#          "s3:GetObject"
#        ]
#        Resource = "*"
#      }
#    ]
#  })
#}
#
#resource "aws_iam_role_policy_attachment" "role-policy-attachment-liberty-edr-lab-drs-agent" {
#  role       = aws_iam_role.liberty-edr-lab-ec2-ssm-role.name
#  policy_arn = aws_iam_policy.liberty-edr-lab-drs-agent-policy.arn
#}
#