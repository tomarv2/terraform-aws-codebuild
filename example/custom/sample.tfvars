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
description                           = "demo: azure-demo policy deployment"
environment_vars                      = [{name = "BUILD_ROLE", value = "arn:aws:iam::xxxx:role/DemoRole", type = "PLAINTEXT"},
                                        {name = "AWS_REGION", value = "us-east-2"},
                                        {name = "BLOB_OUTPUT", value = "s3://demo-s3-bucket/executions/{policy_name}/{account_id}/{now:%Y/%m/%d}/{uuid}"},
                                        {name = "SAS_TOKEN", value = "?sv=2019-12-12xxxxxxx"type = "PARAMETER_STORE"},
                                        {name = "AZURE_CLIENT_ID", value = "xxxxxxx"},
                                        {name = "AZURE_TENANT_ID", value = "xxxxxxxxx"},
                                        {name = "AZURE_CLIENT_SECRET", value = "xxxxxxx", type = "PARAMETER_STORE"},
                                        {name = "AZURE_SUBSCRIPTION_ID", value = "xxxxxxxx"},
                                        {name = "STORAGE_ACCOUNT_NAME", value = "xxxxxxxxx"},
                                        {name = "CONTAINER_NAME", value = "demo-aci-policies"}]
#-------------------------------------------------------------------
# Note: Do not change teamid and prjid once set.
teamid                                = "rumse"
prjid                                 = "demo-build"


