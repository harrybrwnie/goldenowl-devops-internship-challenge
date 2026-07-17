# Shared infrastructure

This root stack owns infrastructure shared by the staging and production
environments. At this milestone it contains the network and ECR modules.

The stack selects two available Availability Zones in `us-east-1` and creates
one public subnet in each zone. Its Terraform state is isolated at
`goldenowl/shared/terraform.tfstate` in the encrypted S3 backend and uses an
S3-native lockfile.

The ECR repository stores application images shared by both environments. It
uses immutable tags, scan-on-push, AES256 encryption, and lifecycle retention
controls. An SSM Parameter Store value records the image digest approved by
staging for production promotion.

The parameter starts with the sentinel value `UNSET`. Deployment automation
owns subsequent value changes, so Terraform ignores drift only for its value
while continuing to manage the parameter itself.

Later milestones add deployment IAM/OIDC to this stack as separate,
reviewable changes.
