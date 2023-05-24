resource "aws_iam_role" "spring_restapi_apprunner_role" {
  name = "spring-restapi-apprunner-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "tasks.apprunner.amazonaws.com",
            "build.apprunner.amazonaws.com"
          ]
        }
        Action = [
          "sts:AssumeRole"
        ]
      }
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
  ]
}

resource "aws_apprunner_auto_scaling_configuration_version" "auto_scaling_low_cost" {
  auto_scaling_configuration_name = "auto_scaling_low_cost"

  max_concurrency = 2
  max_size        = 2
  min_size        = 1

}

resource "time_sleep" "iam_propagation" {
  depends_on      = [aws_iam_role.spring_restapi_apprunner_role]
  create_duration = "15s"
}

resource "aws_apprunner_service" "spring_restapi" {

  service_name = "Spring_Rest_API"

  depends_on = [time_sleep.iam_propagation]

  auto_scaling_configuration_arn = aws_apprunner_auto_scaling_configuration_version.auto_scaling_low_cost.arn

  source_configuration {
    authentication_configuration {
      access_role_arn = aws_iam_role.spring_restapi_apprunner_role.arn
    }
    image_repository {
      image_configuration {
        port = var.container_configuration.port
      }
      image_identifier      = "${local.account_id}.dkr.ecr.${local.region}.amazonaws.com/${var.container_configuration.image_identifier}"
      image_repository_type = "ECR"
    }
    auto_deployments_enabled = var.container_configuration.auto_deployments_enabled
  }
  instance_configuration {
    cpu    = 256
    memory = 512
  }
}

output "spring_restapi_service_url" {
  value = aws_apprunner_service.spring_restapi.service_url
}