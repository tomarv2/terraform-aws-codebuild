variable "email" {
  description = "email address to be used for tagging (suggestion: use group email address)"
}

variable "teamid" {
  description = "(Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply'"
}

variable "prjid" {
  description = "(Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply'"
}

variable "profile_to_use" {
  description = "Getting values from ~/.aws/credentials"
}

variable "build_source_type" {}

variable "build_source_location" {}

variable "aws_region" {}

variable "buildspec_filepath" {}

# var.codebuild_environment_vars
variable "environment_vars" {
  type = list(object({
      name  = string
      value = string
      type = string
  }))
  default = [
    {
      name  = "NO_ADDITIONAL_BUILD_VARS"
      value = "TRUE"
      type  = "PLAINTEXT"
  }]

  description = "A list of maps, that contain both the key 'name' and the key 'value' to be used as additional environment variables for the build"
}

variable build_timeout {
  default = "60"
}

variable "queued_timeout" {
  default = "30"
}
variable compute_type {
  default = "BUILD_GENERAL1_SMALL"
}

variable container_type {
  default = "LINUX_CONTAINER"
}

variable "schedule" {
  default = null
}

variable "branch" {}

variable "trigger_timeout" {
  default = 60
}

variable "description" {
  default = "codebuild pipeline"
}

variable "codebuild_role" {
  description = "service role to be used by CICD"
}

variable "build_artifact_type" {
  default = "NO_ARTIFACTS"
}

variable "privileged_mode" {}

variable "add_eventtarget" {
  default = false
}

variable "add_eventrule" {
  default = false
}

variable "source_version" {
  default = "main"
}

variable "git_clone_depth" {
  default = 1
}

variable "image_repo_name" {
  type        = string
  default     = "UNSET"
  description = "(Optional) ECR repository name to store the Docker image built by this module. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html"
}

variable "image_tag" {
  type        = string
  default     = "latest"
  description = "(Optional) Docker image tag in the ECR repository, e.g. 'latest'. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html"
}

variable "override_artifact_name" {
  default = false
}

variable "badge_enabled" {
  type        = bool
  default     = false
  description = "Generates a publicly-accessible URL for the projects build badge. Available as badge_url attribute when enabled"
}

variable "private_repository" {
  type        = bool
  default     = false
  description = "Set to true to login into private repository with credentials supplied in source_credential variable."
}

variable "source_credential_auth_type" {
  type        = string
  default     = "PERSONAL_ACCESS_TOKEN"
  description = "The type of authentication used to connect to a GitHub, GitHub Enterprise, or Bitbucket repository."
}

variable "source_credential_server_type" {
  type        = string
  default     = "GITHUB"
  description = "The source provider used for this project."
}

variable "source_credential_token" {
  type        = string
  default     = ""
  description = "For GitHub or GitHub Enterprise, this is the personal access token. For Bitbucket, this is the app password."
}

variable "source_credential_user_name" {
  type        = string
  default     = ""
  description = "The Bitbucket username when the authType is BASIC_AUTH. This parameter is not valid for other types of source providers or connections."
}