# GitHub deployment IAM module

This module creates separate staging and production roles for GitHub Actions.
Both roles use the existing GitHub OIDC provider and short-lived web identity
credentials instead of stored AWS access keys.

Each trust policy requires the `sts.amazonaws.com` audience and an exact,
repository-specific GitHub Environment subject. The staging and production
environments therefore receive separate trust boundaries.

Staging can push immutable images to the application ECR repository, deploy
the staging ECS service, and update the approved digest parameter. Production
can read and verify ECR images, deploy only the production ECS service, and
read the approved digest. `iam:PassRole` is restricted to the future ECS task
roles for the matching environment and to the ECS tasks service principal.
