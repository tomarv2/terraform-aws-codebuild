output "codebuild_project_name" {
  description = "The name of the AWS codebuild."
  value       = module.codebuild.codebuild_project_name
}

output "codebuild_project_arn" {
  description = "The ARN of the CodeBuild project."
  value       = module.codebuild.codebuild_project_arn
}
