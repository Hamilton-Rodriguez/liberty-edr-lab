
# Requires an existing user-supplied key pair
# C:\Hamilton\Dev-Ops-Study\AWS Hamilton multi-account\liberty-edr-lab\keys
# Fingerprint: 6a:f2:86:31:1b:b4:69:bd:ed:a6:bc:5c:a2:47:4e:3c:f7:7b:65:86
# ID: key-06772721f7c7565ba

data "aws_key_pair" "liberty-edr-lab-linux-key" {
  key_name = "liberty-edr-lab-linux-key"
}

data "aws_key_pair" "liberty-edr-lab-windows-key" {
  key_name = "liberty-edr-lab-windows-key"
}
