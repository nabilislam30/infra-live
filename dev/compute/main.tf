# -----------------------------------------------------------------------------
# Terraform Remote State
# -----------------------------------------------------------------------------

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "fimatix-devops-starter-tfstate-442847318797"
    key    = "dev/vpc/terraform.tfstate"
    region = "eu-west-2"
  }
}

# -----------------------------------------------------------------------------
# Local Values
# -----------------------------------------------------------------------------

locals {
  common_tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
    Project     = "DevOps-Starter"
  }
}

# -----------------------------------------------------------------------------
# Image Builder Security Group
# -----------------------------------------------------------------------------

# Image Builder requires outbound HTTPS for package updates and AWS service access.
# Egress is restricted to TCP/443; no ingress is permitted.
# trivy:ignore:AWS-0104

resource "aws_security_group" "image_builder" {
  name        = "dev-golden-ami-image-builder"
  description = "Security group for EC2 Image Builder build instances."
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  tags = local.common_tags
}

# trivy:ignore:AWS-0104
resource "aws_vpc_security_group_egress_rule" "image_builder" {
  security_group_id = aws_security_group.image_builder.id

  description = "Allow HTTPS egress for Image Builder package updates and AWS service access."

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"

  tags = local.common_tags
}

# -----------------------------------------------------------------------------
# Golden AMI Pipeline
# -----------------------------------------------------------------------------

module "ami_pipeline" {
  source = "git::https://github.com/nabilislam30/infra-modules.git//ami-pipeline?ref=v1.7.1"

  name = "dev"

  parent_image = "ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"

  recipe_version    = "1.0.0"
  component_version = "1.0.0"

  component_document = <<-YAML
    name: DevGoldenAMI
    description: Build and harden the development Golden AMI.
    schemaVersion: 1.0

    phases:
      - name: build
        steps:
          - name: UpdateOperatingSystem
            action: ExecuteBash
            inputs:
              commands:
                - dnf upgrade -y

          - name: EnableSSMAgent
            action: ExecuteBash
            inputs:
              commands:
                - systemctl enable amazon-ssm-agent
                - systemctl start amazon-ssm-agent
  YAML

  instance_type = "t3.micro"

  subnet_id = data.terraform_remote_state.vpc.outputs.private_subnet_ids[0]

  security_group_ids = [
    aws_security_group.image_builder.id
  ]

  distribution_region = "eu-west-2"

  common_tags = local.common_tags
}
