# 🌍 infra-live

> Live Terraform configuration for immutable AWS infrastructure.

`infra-live` contains the **environment-specific Terraform configuration** used to deploy infrastructure into AWS. Rather than containing reusable infrastructure code, this repository consumes **versioned Terraform modules** from the companion **infra-modules** repository and deploys them into live AWS environments.

---

# 📖 Overview

This repository represents the **live state** of the AWS estate.

Each directory represents a deployable environment or account-level configuration. All infrastructure is managed using Terraform and follows Infrastructure as Code (IaC) best practices.

The project is designed around:

* Immutable Infrastructure
* Infrastructure as Code (Terraform)
* Reusable Terraform modules
* Remote Terraform state
* Version-pinned module releases
* Least privilege security
* AWS security best practices

---

# 🏗 Repository Structure

```text
infra-live/
│
├── global/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── versions.tf
│   └── .trivyignore
│
├── dev/
│   ├── vpc/
│   ├── compute/
│   └── database/
│
├── staging/
│
├── prod/
│
├── .gitignore
├── .pre-commit-config.yaml
└── README.md
```

---

# 🚀 Project Goals

This repository aims to provide a fully reproducible AWS platform by separating:

* Live infrastructure configuration
* Reusable Terraform modules
* Remote state management
* Environment-specific deployments

This allows infrastructure to be promoted safely between environments while keeping reusable code isolated from deployment configuration.

---

# 🌎 Environments

| Environment | Purpose                      | Status         |
| ----------- | ---------------------------- | -------------- |
| Global      | Account-wide shared services | ✅ Complete     |
| Development | Development workloads        | 🚧 In Progress |
| Staging     | Pre-production validation    | 📅 Planned     |
| Production  | Production workloads         | 📅 Planned     |

---

# 🔐 Current Global Infrastructure

The **Global** deployment provisions account-wide security and governance services.

Current resources include:

* ✅ AWS CloudTrail
* ✅ AWS Config
* ✅ AWS Config Managed Rules
* ✅ Amazon GuardDuty
* ✅ AWS Security Hub
* ✅ IAM Access Analyzer
* ✅ Default EBS Encryption
* ✅ S3 Account Public Access Block
* ✅ CloudWatch Log Group
* ✅ Customer Managed KMS Key
* ✅ CloudTrail Log Storage
* ✅ AWS Config Delivery Bucket

---

# 🧩 Terraform Module Architecture

This repository consumes reusable modules from the companion repository:

```text
infra-live
        │
        ▼
infra-modules
        │
        ▼
Terraform
        │
        ▼
AWS
```

Current module:

```hcl
module "security_baseline" {
  source = "git::https://github.com/nabilislam30/infra-modules.git//security-baseline?ref=v0.9.0"
}
```

Using Git tags ensures every deployment is reproducible and avoids accidental breaking changes.

---

# ☁ AWS Deployment Target

| Setting         | Value         |
| --------------- | ------------- |
| AWS Account     | 442847318797  |
| Region          | eu-west-2     |
| Deployment Tool | Terraform     |
| Module Source   | infra-modules |

---

# 💾 Remote State

Terraform state is stored remotely using Amazon S3.

```text
Bucket:
fimatix-devops-starter-tfstate-442847318797
```

State locking is provided by DynamoDB.

```text
Table:
terraform-state-locks
```

State files are separated by environment.

Example:

```text
global/terraform.tfstate

dev/vpc/terraform.tfstate

dev/compute/terraform.tfstate

prod/vpc/terraform.tfstate
```

---

# ⚙ Deployment Workflow

The deployment workflow follows a standard Terraform lifecycle.

```text
Developer

        │

        ▼

Git Commit

        │

        ▼

infra-live

        │

        ▼

Terraform Init

        │

        ▼

Terraform Plan

        │

        ▼

Terraform Apply

        │

        ▼

AWS
```

---

# 🚀 Deployment

Initialise Terraform

```bash
terraform init
```

Review the execution plan

```bash
terraform plan
```

Deploy infrastructure

```bash
terraform apply
```

Destroy infrastructure (where appropriate)

```bash
terraform destroy
```

---

# 🔍 Validation

Infrastructure is validated before deployment using:

* Terraform Validate
* Terraform Fmt
* TFLint
* Trivy
* Terraform Docs
* Git Pre-Commit Hooks

This helps maintain consistent code quality across all environments.

---

# 🔒 Security

The repository follows several security best practices.

* Infrastructure managed exclusively through Terraform
* Remote state locking
* Versioned modules
* Least privilege IAM
* KMS encryption
* AWS Config compliance monitoring
* CloudTrail audit logging
* GuardDuty threat detection
* Security Hub posture management
* IAM Access Analyzer

---

# 📂 Related Repository

Reusable infrastructure modules are maintained separately.

**Repository**

```text
infra-modules
```

This repository contains reusable Terraform modules that are consumed by `infra-live`.

---

# 🗺 Roadmap

Completed

* ✅ Remote Terraform State
* ✅ Global Security Baseline
* ✅ AWS Config
* ✅ CloudTrail
* ✅ GuardDuty
* ✅ Security Hub
* ✅ IAM Access Analyzer
* ✅ EBS Encryption by Default

Planned

* 🔲 VPC Module
* 🔲 Compute Module
* 🔲 Database Module
* 🔲 Monitoring Module
* 🔲 CI/CD Deployment Pipeline
* 🔲 Automated Testing
* 🔲 Multi-Account Support

---

# 🤝 Contributing

1. Create a feature branch.
2. Implement infrastructure changes.
3. Run validation checks.
4. Open a Pull Request.
5. Obtain approval before merging.

---

# 📜 License

This repository is provided for learning, portfolio, and infrastructure engineering purposes.
