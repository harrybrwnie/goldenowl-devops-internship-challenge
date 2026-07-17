# ECS environment module

Defines one hardened ECS Fargate environment behind a public Application Load
Balancer. It includes isolated security groups, CloudWatch logs, deployment
circuit breaker with rollback, container and ALB health checks, and CPU target
tracking Auto Scaling. Tasks run as UID 65532 with a read-only root filesystem,
all Linux capabilities dropped, and an init process enabled.
