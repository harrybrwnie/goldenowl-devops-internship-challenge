locals {
  environments = toset(["staging", "production"])

  cluster_arns = {
    for environment in local.environments :
    environment => "arn:${var.aws_partition}:ecs:${var.aws_region}:${var.aws_account_id}:cluster/goldenowl-${environment}-cluster"
  }

  service_arns = {
    for environment in local.environments :
    environment => "arn:${var.aws_partition}:ecs:${var.aws_region}:${var.aws_account_id}:service/goldenowl-${environment}-cluster/goldenowl-${environment}-service"
  }

  task_arns = {
    for environment in local.environments :
    environment => "arn:${var.aws_partition}:ecs:${var.aws_region}:${var.aws_account_id}:task/goldenowl-${environment}-cluster/*"
  }

  task_role_arns = {
    for environment in local.environments : environment => [
      "arn:${var.aws_partition}:iam::${var.aws_account_id}:role/goldenowl-${environment}-task-execution-role",
      "arn:${var.aws_partition}:iam::${var.aws_account_id}:role/goldenowl-${environment}-task-role",
    ]
  }
}

data "aws_iam_policy_document" "trust" {
  for_each = local.environments

  statement {
    sid     = "GitHubActionsOidc"
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [var.oidc_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["${var.github_subject_prefix}:environment:${each.key}"]
    }
  }
}

resource "aws_iam_role" "deployment" {
  for_each = local.environments

  name                 = "goldenowl-${each.key}-deployment-role"
  description          = "GitHub Actions deployment role for the ${each.key} environment."
  assume_role_policy   = data.aws_iam_policy_document.trust[each.key].json
  max_session_duration = 3600
}

data "aws_iam_policy_document" "deployment" {
  for_each = local.environments

  statement {
    sid       = "EcrAuthorization"
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    sid    = "EcrImageRead"
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:DescribeImages",
      "ecr:GetDownloadUrlForLayer",
      "ecr:ListImages",
    ]
    resources = [var.ecr_repository_arn]
  }

  dynamic "statement" {
    for_each = each.key == "staging" ? [1] : []

    content {
      sid    = "EcrImagePush"
      effect = "Allow"
      actions = [
        "ecr:CompleteLayerUpload",
        "ecr:InitiateLayerUpload",
        "ecr:PutImage",
        "ecr:UploadLayerPart",
      ]
      resources = [var.ecr_repository_arn]
    }
  }

  statement {
    sid    = "EcsDeployment"
    effect = "Allow"
    actions = [
      "ecs:DescribeServices",
      "ecs:UpdateService",
    ]
    resources = [local.service_arns[each.key]]
  }

  statement {
    sid     = "EcsClusterRead"
    effect  = "Allow"
    actions = ["ecs:DescribeClusters"]
    resources = [
      local.cluster_arns[each.key],
    ]
  }

  statement {
    sid       = "EcsTaskRead"
    effect    = "Allow"
    actions   = ["ecs:DescribeTasks"]
    resources = [local.task_arns[each.key]]
  }

  statement {
    sid       = "EcsTaskList"
    effect    = "Allow"
    actions   = ["ecs:ListTasks"]
    resources = ["*"]

    condition {
      test     = "ArnEquals"
      variable = "ecs:cluster"
      values   = [local.cluster_arns[each.key]]
    }
  }

  statement {
    sid    = "EcsTaskDefinition"
    effect = "Allow"
    actions = [
      "ecs:DescribeTaskDefinition",
      "ecs:ListTaskDefinitions",
      "ecs:RegisterTaskDefinition",
    ]
    resources = ["*"]
  }

  statement {
    sid       = "PassEcsTaskRoles"
    effect    = "Allow"
    actions   = ["iam:PassRole"]
    resources = local.task_role_arns[each.key]

    condition {
      test     = "StringEquals"
      variable = "iam:PassedToService"
      values   = ["ecs-tasks.amazonaws.com"]
    }
  }

  statement {
    sid    = each.key == "staging" ? "ApproveImageDigest" : "ReadApprovedImageDigest"
    effect = "Allow"
    actions = each.key == "staging" ? [
      "ssm:GetParameter",
      "ssm:PutParameter",
      ] : [
      "ssm:GetParameter",
    ]
    resources = [var.approved_image_parameter_arn]
  }
}

resource "aws_iam_role_policy" "deployment" {
  for_each = local.environments

  name   = "goldenowl-${each.key}-deployment-policy"
  role   = aws_iam_role.deployment[each.key].id
  policy = data.aws_iam_policy_document.deployment[each.key].json
}
