# -----------------------------------------------------------------------------
# VPC
# -----------------------------------------------------------------------------

output "vpc_id" {
  description = "ID of the development VPC."
  value       = module.vpc.vpc_id
}

# -----------------------------------------------------------------------------
# Private Subnets
# -----------------------------------------------------------------------------

output "private_subnet_ids" {
  description = "IDs of the development private subnets."
  value       = module.vpc.private_subnet_ids
}
