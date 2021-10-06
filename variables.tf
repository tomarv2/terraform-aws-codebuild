variable "teamid" {
  description = "(Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply'"
  type        = string
}

variable "prjid" {
  description = "(Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply'"
  type        = string
}

variable "profile_to_use" {
  description = "Getting values from ~/.aws/credentials"
  default     = "default"
  type        = string
}

variable "build_source_type" {
  description = "Type of repository that contains the source code to be built. Valid values: CODECOMMIT, CODEPIPELINE, GITHUB, GITHUB_ENTERPRISE, BITBUCKET or S3"
  default     = "GITHUB"
  type        = string
}

variable "build_source_location" {
  description = "Information about the build output artifact location. If type is set to CODEPIPELINE or NO_ARTIFACTS, this value is ignored. If type is set to S3, this is the name of the output bucket."
  type        = string
  default     = null
}

variable "aws_region" {
  description = "aws region to deploy resource(s)"
  default     = "us-west-2"
  type        = string
}

variable "buildspec_filepath" {
  description = "Build specification to use for this build project's related builds."
  default     = ""
  type        = string
}

# var.codebuild_environment_vars
variable "environment_vars" {
  type = list(object({
    name  = string
    value = string
    type  = string
  }))
  default = [
    {
      name  = "NO_ADDITIONAL_BUILD_VARS"
      value = "TRUE"
      type  = "PLAINTEXT"
  }]
  description = "A list of maps, that contain both the key 'name' and the key 'value' to be used as additional environment variables for the build"
}

variable "vpc_config" {
  type        = any
  default     = {}
  description = "Configuration for the builds to run inside a VPC."
}

variable "build_timeout" {
  description = "Number of minutes, from 5 to 480 (8 hours), for AWS CodeBuild to wait until timing out any related build that does not get marked as completed. The default is 60 minutes."
  default     = "60"
  type        = string
}

variable "queued_timeout" {
  description = "Number of minutes, from 5 to 480 (8 hours), a build is allowed to be queued before it times out. The default is 8 hours."
  default     = "30"
  type        = string
}

variable "compute_type" {
  description = "Information about the compute resources the build project will use. Valid values: BUILD_GENERAL1_SMALL, BUILD_GENERAL1_MEDIUM, BUILD_GENERAL1_LARGE, BUILD_GENERAL1_2XLARGE. BUILD_GENERAL1_SMALL is only valid if type is set to LINUX_CONTAINER. When type is set to LINUX_GPU_CONTAINER, compute_type must be BUILD_GENERAL1_LARGE."
  default     = "BUILD_GENERAL1_MEDIUM"
  type        = string
}

variable "container_type" {
  description = "Type of build environment to use for related builds. Valid values: LINUX_CONTAINER, LINUX_GPU_CONTAINER, WINDOWS_CONTAINER (deprecated), WINDOWS_SERVER_2019_CONTAINER, ARM_CONTAINER. For additional information, see the CodeBuild User Guide."
  default     = "LINUX_CONTAINER"
  type        = string
}

variable "schedule" {
  description = "cloudwatch event schedule"
  default     = null
  type        = string
}

variable "branch" {
  description = "cloudwatch event branch"
  default     = "main"
  type        = string
}

variable "description" {
  description = "Short description of the project."
  default     = null
  type        = string
}

variable "codebuild_role" {
  description = "Service role to be used by cicd"
  type        = string
}

variable "build_artifact_type" {
  description = "Build output artifact's type. Valid values: CODEPIPELINE, NO_ARTIFACTS, S3."
  default     = "NO_ARTIFACTS"
  type        = string
}

variable "privileged_mode" {
  description = "Whether to enable running the Docker daemon inside a Docker container. Defaults to false."
  default     = false
  type        = bool
}

variable "deploy_event_target" {
  description = "Deploy cloudwatch event trigger"
  default     = false
  type        = bool
}

variable "deploy_event_rule" {
  description = "Deploy cloudwatch event rule"
  default     = false
  type        = bool
}

variable "source_version" {
  description = "A string that identifies the action type."
  default     = null
  type        = string
}

variable "git_clone_depth" {
  description = "Truncate git history to this many commits. Use 0 for a Full checkout which you need to run commands like git branch --show-current. See AWS CodePipeline User Guide: Tutorial: Use full clone with a GitHub pipeline source for details."
  default     = 1
  type        = number
}

variable "build_container_image" {
  type        = string
  default     = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
  description = "Docker image to use for this build project. Valid values include Docker images provided by CodeBuild (e.g aws/codebuild/standard:2.0)."
}

variable "override_artifact_name" {
  description = "Whether a name specified in the build specification overrides the artifact name."
  default     = false
  type        = bool
}

variable "badge_enabled" {
  type        = bool
  default     = false
  description = "Generates a publicly-accessible URL for the projects build badge. Available as badge_url attribute when enabled"
}

variable "private_repository" {
  type        = bool
  default     = true
  description = "Set to true to login into private repository with credentials supplied in source_credential variable."
}

variable "source_credential_auth_type" {
  type        = string
  default     = "PERSONAL_ACCESS_TOKEN"
  description = "The type of authentication used to connect to a GitHub, GitHub Enterprise, or Bitbucket repository."
}

variable "source_credential_server_type" {
  description = "The source provider used for this project."
  type        = string
  default     = "GITHUB"
}

variable "source_credential_user_name" {
  type        = string
  default     = ""
  description = "Bitbucket username when the authType is BASIC_AUTH. This parameter is not valid for other types of source providers or connections."
}

variable "cloudwatch_path" {
  description = "Name of the log group"
  default     = "/codebuild"
  type        = string
}

variable "cloudwatch_logs_status" {
  description = "Current status of logs in CloudWatch Logs for a build project. Valid values: ENABLED, DISABLED. Defaults to ENABLED."
  default     = "ENABLED"
  type        = string
}
variable "source_credential_token" {
  description = "For GitHub or GitHub Enterprise, this is the personal access token. For Bitbucket, this is the app password."
  type        = string
}

variable "filter_group" {
  description = "nested block: NestingSet, min items: 0, max items: 0"
  type = set(object(
    {
      filter = list(object(
        {
          exclude_matched_pattern = bool
          pattern                 = string
          type                    = string
        }
      ))
    }
  ))
  default = []
}

variable "concurrent_build_limit" {
  default     = 1
  type        = number
  description = "Specify a maximum number of concurrent builds for the project. The value specified must be greater than 0 and less than the account concurrent running builds limit."
}

variable "build_type" {
  default     = "BUILD"
  type        = string
  description = "The type of build this webhook will trigger. Valid values for this parameter are: BUILD, BUILD_BATCH."
}

variable "custom_tags" {
  type        = any
  description = "Custom extra tags"
  default     = null
}
