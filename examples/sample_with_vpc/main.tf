module "codebuild" {
  source = "../../"

  build_source_location   = "https://github.com/tomarv2/test-cicd"
  source_credential_token = var.source_credential_token
  codebuild_role          = "arn:aws:iam::123456789012:role/codebuild-role"
  git_clone_depth         = "25"
  environment_vars = [
    {
      name  = "AWS_REGION",
      value = "us-east-2",
      type  = "PLAINTEXT"
  }]
  filter_group = [
    {
      filter = [
        {
          exclude_matched_pattern = false
          type                    = "BASE_REF"
          pattern                 = "dev|staging|main"
        },
        {
          exclude_matched_pattern = false
          type                    = "EVENT"
          pattern                 = "PULL_REQUEST_MERGED"
        }
      ]
    }
  ]

  vpc_config = {
    vpc_id             = module.vpc.vpc_id
    subnets            = module.subnets.private_subnet_ids
    security_group_ids = [module.vpc.vpc_default_security_group_id]
  }

  # To configure schedule
  schedule            = "rate(1 minute)"
  deploy_event_rule   = true
  deploy_event_target = true
  #-----------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
