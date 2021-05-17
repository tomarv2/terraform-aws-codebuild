resource "aws_codebuild_project" "codebuild" {
  name = "${var.teamid}-${var.prjid}"

  description    = var.description == null ? "Terraform managed: ${var.teamid}-${var.prjid}" : var.description
  build_timeout  = var.build_timeout
  queued_timeout = var.queued_timeout
  # NOTE: this role should pre-exist or can be created at runtime
  service_role = var.codebuild_role
  artifacts {
    type                   = var.build_artifact_type
    override_artifact_name = var.override_artifact_name
  }

  environment {
    compute_type    = var.compute_type
    image           = var.build_container_image
    type            = var.container_type
    privileged_mode = var.privileged_mode

    dynamic "environment_variable" {
      for_each = var.environment_vars
      content {
        name  = environment_variable.value.name
        value = environment_variable.value.value
        type  = environment_variable.value.type
      }
    }
  }

  source {
    type            = var.build_source_type
    location        = var.build_source_location
    git_clone_depth = var.git_clone_depth
    buildspec       = file(local.buildspec_filepath)

    dynamic "auth" {
      for_each = var.private_repository ? [""] : []
      content {
        type     = "OAUTH"
        resource = join("", aws_codebuild_source_credential.authorization.*.id)
      }
    }
  }

  source_version = var.source_version
  tags           = merge(local.shared_tags)

  badge_enabled = var.badge_enabled

  logs_config {
    cloudwatch_logs {
      group_name = "/${var.cloudwatch_path}/${var.teamid}-${var.prjid}"
      status     = var.cloudwatch_logs_status

    }
  }
}
