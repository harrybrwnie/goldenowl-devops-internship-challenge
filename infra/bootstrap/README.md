# Terraform backend bootstrap

This stack provisions the S3 bucket that stores remote Terraform state for the shared, staging, and production infrastructure stacks added in later
milestones.

The bootstrap stack initially uses local state because its remote backend does not exist until this stack has been provisioned. Its state is excluded from Git and must be retained securely.

## Managed resources

The stack manages:

- one private S3 bucket for Terraform state;
- S3 bucket versioning for state recovery;
- server-side encryption using Amazon S3 managed keys (`AES256`);
- all four S3 public-access blocking controls;
- bucket-owner-enforced object ownership;
- a bucket policy that denies requests made without TLS.

The bucket uses `force_destroy = false` by default so it cannot be deleted
while it still contains state objects.

## Inputs

- `aws_region`: AWS Region for the state bucket;
- `state_bucket_name`: globally unique S3 bucket name;
- `owner`: value used by the resource ownership tag;
- `force_destroy`: controlled cleanup switch, disabled by default.

## Outputs

- `state_bucket_name`: bucket name consumed by later backend configurations;
- `state_bucket_arn`: bucket ARN for IAM policies and verification;
- `backend_region`: Region consumed by later backend configurations.

## Resource tags

Taggable resources receive a consistent tag set through the AWS provider:

```text
Project     = goldenowl-devops
Environment = bootstrap
ManagedBy   = terraform
Owner       = harrybrwnie
```

## Design decisions

SSE-S3 encryption is used instead of a customer-managed KMS key to keep the
assessment inexpensive and avoid unnecessary key administration. A
customer-managed KMS key would provide more granular key policies and audit
controls for a production platform.

Later Terraform stacks use separate state keys and S3-native lockfiles. This isolates their blast radius while keeping state encryption, version history, and locking in the same backend bucket.
