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

variable "description" {
  default = "codebuild pipeline"
}

variable "schedule" {}

variable "branch" {}

variable "codebuild_role" {
  description = "service role to be used by CICD"
}

variable "build_artifact_type" {}

variable "privileged_mode" {
  default = true
}

variable "add_eventrule" {
  default = false
}

variable "add_eventtarget" {
  default = false
}