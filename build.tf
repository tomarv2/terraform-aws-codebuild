resource "aws_codebuild_project" "codebuild" {
  name = "${var.teamid}-${var.prjid}"

  description            = var.description == null ? "Terraform managed: ${var.teamid}-${var.prjid}" : var.description
  build_timeout          = var.build_timeout
  queued_timeout         = var.queued_timeout
  service_role           = var.codebuild_role
  concurrent_build_limit = var.concurrent_build_limit
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
      for_each = var.private_repository ? [
      ""] : []
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

  dynamic "vpc_config" {
    for_each = length(var.vpc_config) > 0 ? [""] : []
    content {
      vpc_id             = lookup(var.vpc_config, "vpc_id", null)
      subnets            = lookup(var.vpc_config, "subnets", null)
      security_group_ids = lookup(var.vpc_config, "security_group_ids", null)
    }
  }
}

resource "aws_codebuild_webhook" "codebuild_webook" {
  count = var.build_source_type == "GITHUB" ? 1 : 0

  project_name = aws_codebuild_project.codebuild.name
  build_type   = var.build_type
  dynamic "filter_group" {
    for_each = var.filter_group
    content {

      dynamic "filter" {
        for_each = filter_group.value.filter

        content {
          # exclude_matched_pattern - (optional) is a type of bool
          exclude_matched_pattern = filter.value["exclude_matched_pattern"]
          # pattern - (required) is a type of string
          pattern = filter.value["pattern"]
          # type - (required) is a type of string
          type = filter.value["type"]
        }
      }

    }
  }
}
