# Shared infrastructure

This root stack owns infrastructure shared by the staging and production
environments. At this milestone it contains only the network module.

The stack selects two available Availability Zones in `us-east-1` and creates
one public subnet in each zone. Its Terraform state is isolated at
`goldenowl/shared/terraform.tfstate` in the encrypted S3 backend and uses an
S3-native lockfile.

Later milestones add ECR, deployment IAM/OIDC, and the approved image
parameter to this stack as separate, reviewable changes.
