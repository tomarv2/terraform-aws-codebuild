email                                 = "demo@demo.com"
profile_to_use                        = "default"
build_source_type                     = "GITHUB"
build_source_location                 = "https://github.com/tomarv2/demo.git"
branch                                = "develop"
buildspec_filepath                    = "provisioning/build-pipeline.yml"
codebuild_role                        = "arn:aws:iam::123456789012:role/DemoRole"
aws_region                            = "us-east-2"
image_env                             = "python"
image_version                         = "3.6"
schedule                              = "rate(1 day)"
service_role                          = "arn:aws:iam::123456789012:role/service-role/demo-s3-bucket-us-east-2-role"
description                           = "codebuild deployment"
environment_vars                      = [{name = "BUILD_ROLE", value = "arn:aws:iam::xxxx:role/DemoRole", type = "PLAINTEXT"},
                                        {name = "AWS_REGION", value = "us-east-2"},
                                        {name = "SAS_TOKEN", value = "?sv=2019-12-12xxxxxxx", type = "PARAMETER_STORE"}]
#-------------------------------------------------------------------
# Note: Do not change teamid and prjid once set.
teamid                                = "rumse"
prjid                                 = "demo-codebuild"


