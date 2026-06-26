resource "aws_s3_bucket" "terraform_state" {
  bucket = "fimatix-devops-starter-tfstate-442847318797"
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

module "security_baseline" {
  source = "git::https://github.com/nabilislam30/infra-modules.git//security-baseline?ref=v1.0.0"
}
