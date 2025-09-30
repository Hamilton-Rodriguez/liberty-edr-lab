
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
