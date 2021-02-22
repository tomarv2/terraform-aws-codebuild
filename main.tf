# terraform {
#   required_version            = ">= 0.14"
#   required_providers {
#     aws = {
#       version                     = "~> 2.61"
#     }
#   }
# }

provider "aws" {
  region                      = var.aws_region
  profile                     = var.profile_to_use
}


module "cloudwatch_event" {
  source                                = "git::git@github.com:tomarv2/terraform-aws-cloudwatch-event.git?ref=0.0.1"

  add_eventtarget                       = var.add_eventtarget
  add_eventrule                         = var.add_eventrule

  email                                 = var.email
  teamid                                = var.teamid
  prjid                                 = var.prjid

  branch                                = var.branch
  aws_region                            = var.aws_region
  schedule                              = var.schedule
  target_arn                            = aws_codebuild_project.codebuild.arn
  service_role                          = var.codebuild_role
}

locals {
  shared_tags = map(
      "Name", "${var.teamid}-${var.prjid}",
      "Owner", var.email,
      "Team", var.teamid,
      "Project", var.prjid

  )
}
