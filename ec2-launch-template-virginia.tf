

resource "aws_launch_template" "liberty_edr_lab_drs-launch_template_virginia" {
  name_prefix   = "liberty_edr_lab_drs-launch_template_virginia"
  image_id      = "ami-08982f1c5bf93d976"  # Amazon Linux 2023
  instance_type = "t2.small"

  iam_instance_profile {
    name = aws_iam_instance_profile.liberty-edr-lab-ec2-ssm-profile.name
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.liberty-edr-lab-webserver-sg-public.id]
    subnet_id                   = aws_subnet.liberty-edr-lab-subnet-public2-us-east-1b.id
  }

  metadata_options {
    http_tokens                 = "required"
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 2
  }

  tags = {
    Environment = "drs-failback"    # Tal vez sobre, para el failback sobre la misma VM
  }
}
