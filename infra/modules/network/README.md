# Network module

This module defines the shared public network used by the assessment
environments.

It manages one VPC with DNS support, one Internet Gateway, two public subnets
in distinct Availability Zones, and one public route table with a default
route to the Internet Gateway. Each subnet is explicitly associated with the public route table.

Public IP assignment is enabled for this assessment so ECS Fargate tasks can reach ECR and CloudWatch without a NAT Gateway. Security groups added with the ECS environments will restrict inbound task traffic to the corresponding Application Load Balancer. A production-oriented design would place tasks in private subnets and provide controlled outbound access through NAT Gateway or VPC endpoints.
