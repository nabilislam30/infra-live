module "vpc" {
  source = "git::https://github.com/nabilislam30/infra-modules.git//vpc?ref=v1.5.0"

  name       = "dev-vpc"
  aws_region = "eu-west-2"

  vpc_cidr = "10.10.0.0/16"

  availability_zones = [
    "eu-west-2a",
    "eu-west-2b",
    "eu-west-2c"
  ]

  public_subnet_cidrs = [
    "10.10.1.0/24",
    "10.10.2.0/24",
    "10.10.3.0/24"
  ]

  private_subnet_cidrs = [
    "10.10.11.0/24",
    "10.10.12.0/24",
    "10.10.13.0/24"
  ]

  database_subnet_cidrs = [
    "10.10.21.0/24",
    "10.10.22.0/24",
    "10.10.23.0/24"
  ]

  nat_gateway_strategy = "single"

  common_tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
    Project     = "DevOps-Starter"
  }
}
