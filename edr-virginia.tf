
resource "aws_drs_replication_configuration_template" "liberty-edr-lab-failback-replication_configuration_template-virginia" {
    staging_area_tags = {
        "Environment" = "FAILBACK-DRS"
    }
    associate_default_security_group        = true
    bandwidth_throttling                    = 0  # No throttling
    create_public_ip                        = true
    data_plane_routing                      = "PUBLIC_IP" # "PRIVATE_IP"
    default_large_staging_disk_type         = "AUTO"
    ebs_encryption                          = "DEFAULT"
    #ebs_encryption_key_arn                  = "arn:aws:kms:us-east-2:aws:key/aws/ebs"
    replication_server_instance_type        = "t3.small"
    replication_servers_security_groups_ids = [
        #aws_security_group.liberty-edr-lab-replication-server-sg-public-secondary.id          # Used by the replication server
    ]
    staging_area_subnet_id                  = aws_subnet.liberty-edr-lab-subnet-public1-us-east-1a.id
    use_dedicated_replication_server        = false


# rolling 1-hour window of granular recovery points
  pit_policy {
    enabled            = true
    interval           = 10
    retention_duration = 60
    units              = "MINUTE"
    rule_id            = 1
  }

# Hourly snapshots for 1 day
  pit_policy {
    enabled            = true
    interval           = 1
    retention_duration = 24
    units              = "HOUR"
    rule_id            = 2
  }

# Daily snapshots for 3 days
  pit_policy {
    enabled            = true
    interval           = 1
    retention_duration = 3
    units              = "DAY"
    rule_id            = 3
  }
}


### If there is an existing replication configuration template:
# AWS CLI
# aws drs delete-replication-configuration-template --replication-configuration-template-id rct-4e58b82b6031dffff --region us-east-2
#           aws drs describe-replication-configuration-templates --region us-east-2
#           terraform state rm aws_drs_replication_configuration_template.liberty-edr-lab-replication_configuration_template-ohio



