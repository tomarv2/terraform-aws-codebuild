output "codebuild_project_name" {
  description = "The name of the AWS codebuild."
  value = aws_codebuild_project.codebuild.name
}

output "codebuild_project_arn" {
  description = "The ARN of the CodeBuild project."
  value = aws_codebuild_project.codebuild.arn
}
