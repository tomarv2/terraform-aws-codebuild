module "codebuild" {
  source                        = "../.."

  teamid                        = var.teamid
  prjid                         = var.prjid
  email                         = var.email
  profile_to_use                = var.profile_to_use

  aws_region                    = var.aws_region
  buildspec_filepath            = var.buildspec_filepath
  image_version                 = var.image_version
  image_env                     = var.image_env
  build_source_type             = var.build_source_type
  build_source_location         = var.build_source_location
  codebuild_role                = var.codebuild_role
  environment_vars              = var.environment_vars
  description                   = var.description
  build_artifact_type           = var.build_artifact_type
  privileged_mode               = var.privileged_mode
  branch                        = var.branch
  add_eventrule                 = var.add_eventrule
  add_eventtarget               = var.add_eventtarget
  schedule                      = var.schedule
}
