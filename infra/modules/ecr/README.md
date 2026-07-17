# ECR module

This module defines the private Amazon ECR repository that stores application container images.

Image tags are immutable so a Git SHA tag cannot be overwritten after it has been pushed. Images are encrypted with Amazon-managed AES256 encryption and basic vulnerability scanning runs on every push.

The lifecycle policy removes untagged images after a short retention period
and limits the total number of retained revisions. Repository force deletion is disabled by default to protect published artifacts from accidental
destruction.
