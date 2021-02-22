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

variable "build_source_type" {
  description = "Getting values from ~/.aws/credentials"
}

variable "build_source_location" {
  description = "Getting values from ~/.aws/credentials"
}

variable "aws_region" {
  description = "Getting values from ~/.aws/credentials"
}

variable "image_version" {
  description = "Getting values from ~/.aws/credentials"
}

variable "image_env" {
  description = "Getting values from ~/.aws/credentials"
}

variable "buildspec_filepath" {
  description = "Getting values from ~/.aws/credentials"
}

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
  description = "Getting values from ~/.aws/credentials"
  default = "codebuild pipeline"
}

variable "schedule" {
  description = "Getting values from ~/.aws/credentials"
}

variable "branch" {
  description = "Getting values from ~/.aws/credentials"
}

variable "codebuild_role" {
  description = "service role to be used by CICD"
}

variable "build_artifact_type" {
  description = "Getting values from ~/.aws/credentials"
}

variable "privileged_mode" {
  description = "Getting values from ~/.aws/credentials"
  default = true
}

variable "add_eventrule" {
  description = "Getting values from ~/.aws/credentials"
  default = false
}

variable "add_eventtarget" {
  description = "Getting values from ~/.aws/credentials"
  default = false
}