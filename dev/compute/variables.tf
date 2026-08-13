# -----------------------------------------------------------------------------
# General
# -----------------------------------------------------------------------------

variable "name" {
  description = "Name used for the development Golden AMI resources."
  type        = string
}

# -----------------------------------------------------------------------------
# Golden AMI Source
# -----------------------------------------------------------------------------

variable "parent_image" {
  description = "Parent AMI used as the base for the Golden AMI."
  type        = string
}

# -----------------------------------------------------------------------------
# Golden AMI Versioning
# -----------------------------------------------------------------------------

variable "recipe_version" {
  description = "Version of the EC2 Image Builder image recipe."
  type        = string
}

variable "component_version" {
  description = "Version of the EC2 Image Builder component."
  type        = string
}

# -----------------------------------------------------------------------------
# Golden AMI Build Configuration
# -----------------------------------------------------------------------------

variable "component_document" {
  description = "EC2 Image Builder YAML document containing the Golden AMI build and hardening steps."
  type        = string
}

# -----------------------------------------------------------------------------
# Build Infrastructure
# -----------------------------------------------------------------------------

variable "instance_type" {
  description = "EC2 instance type used to build and test the Golden AMI."
  type        = string
}

variable "security_group_ids" {
  description = "Security groups attached to the EC2 Image Builder build instance."
  type        = list(string)
}
