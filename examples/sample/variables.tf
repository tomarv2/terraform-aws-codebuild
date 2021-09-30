variable "teamid" {
  description = "(Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply'"
  type        = string
}

variable "prjid" {
  description = "(Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply'"
  type        = string
}

variable "source_credential_token" {
  description = "For GitHub or GitHub Enterprise, this is the personal access token. For Bitbucket, this is the app password."
  type        = string
  sensitive   = true
}
