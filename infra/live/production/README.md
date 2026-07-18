# Production environment

This stack creates a production ECS Fargate service behind a dedicated public
ALB. It starts with two tasks and scales between two and four tasks at 60%
average CPU. The initial task definition uses the image digest approved by the
staging deployment workflow.
