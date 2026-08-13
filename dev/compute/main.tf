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
# Golden AMI Pipeline
# -----------------------------------------------------------------------------

module "ami_pipeline" {
  source = "git::https://github.com/nabilislam30/infra-modules.git//ami-pipeline?ref=v1.7.0"

  name = var.name

  parent_image       = var.parent_image
  recipe_version     = var.recipe_version
  component_version  = var.component_version
  component_document = var.component_document

  instance_type = var.instance_type

  subnet_id = data.terraform_remote_state.vpc.outputs.private_subnet_ids[0]

  security_group_ids = var.security_group_ids

  distribution_region = "eu-west-2"

  common_tags = local.common_tags
}
