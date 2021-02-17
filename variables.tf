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

variable "image_version" {}

variable "image_env" {}

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
  default = "30"
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
