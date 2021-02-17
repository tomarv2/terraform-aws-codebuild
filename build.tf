resource "aws_codebuild_project" "codebuild" {
  name                          = "${var.teamid}-${var.prjid}"
  description                   = var.description
  build_timeout                 = var.build_timeout
  queued_timeout                = var.queued_timeout
  #
  # NOTE: this role should pre-exist or can be created at runtime
  service_role                  = var.codebuild_role
  artifacts {
    type                        = var.build_artifact_type
  }

  environment {
    compute_type                = var.compute_type
    image                       = "${var.image_env}:${var.image_version}"
    type                        = var.container_type
    privileged_mode             = var.privileged_mode

    dynamic "environment_variable" {
      for_each                  = var.environment_vars
      content {
        name                    = environment_variable.value.name
        value                   = environment_variable.value.value
        type                    = environment_variable.value.type
      }
    }
  }

  source {
    type                          = var.build_source_type
    location                      = var.build_source_location
    git_clone_depth               = 1
    buildspec                     = file(var.buildspec_filepath)
//    auth {
//      type                        = "OAUTH"
//    }
  }

  tags                            = merge(local.shared_tags)
}

