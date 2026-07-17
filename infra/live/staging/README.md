# Staging environment

This stack creates one ECS Fargate service behind a dedicated public ALB. It
starts with one task and scales between one and two tasks at 65% average CPU.
The initial task definition uses a manually verified bootstrap image digest;
later revisions are owned by the staging deployment workflow.
