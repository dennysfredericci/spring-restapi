resource "aws_ecr_repository" "ecr_repository_spring_restapi" {
  name                 = "fredericci/spring-restapi"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
}