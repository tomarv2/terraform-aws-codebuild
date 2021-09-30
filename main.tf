module "cloudwatch_event" {
  source = "git::git@github.com:tomarv2/terraform-aws-cloudwatch-events.git?ref=v0.0.4"

  deploy_event_target = var.deploy_event_target
  deploy_event_rule   = var.deploy_event_rule

  branch       = var.branch
  schedule     = var.schedule
  target_arn   = aws_codebuild_project.codebuild.arn
  service_role = var.codebuild_role
  #-----------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}

module "cloudwatch" {
  source = "git::git@github.com:tomarv2/terraform-aws-cloudwatch.git?ref=v0.0.2"

  cloudwatch_path = var.cloudwatch_path
  aws_region      = var.aws_region
  #-----------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
