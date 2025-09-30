
resource "aws_iam_role" "liberty-edr-lab-ec2-ssm-role-2" {
  provider = aws.useast2
  name = "liberty-edr-lab-ec2-ssm-role-2"

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
    Name = "liberty-edr-lab-ec2-ssm-role-2"
    Project = "csd-edr-lab"
    Created-by = "terraform"
    Date-created = "28-09-2025"
  }
}


resource "aws_iam_role_policy_attachment" "role-policy-attachment-liberty-edr-lab-ec2-ssm-role-2" {
  provider = aws.useast2
  role       = aws_iam_role.liberty-edr-lab-ec2-ssm-role-2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
