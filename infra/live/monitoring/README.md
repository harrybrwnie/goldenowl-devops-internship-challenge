# Monitoring

This stack creates a single CloudWatch dashboard for the staging and production
ECS services and their Application Load Balancers. It includes ECS CPU, memory,
and running task metrics together with ALB traffic, latency, 5XX, and target
health metrics.

CloudWatch alarms cover unhealthy targets and ALB 5XX responses in both
environments, plus sustained high CPU in production. Alarm notifications are
not configured because this assessment does not provision an SNS subscription.
The existing ECS target-tracking policies remain responsible for scaling.
