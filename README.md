<p align="center">
    <a href="https://github.com/tomarv2/terraform-aws-codebuild/actions/workflows/pre-commit.yml" alt="Pre Commit">
        <img src="https://github.com/tomarv2/terraform-aws-codebuild/actions/workflows/pre-commit.yml/badge.svg?branch=main" /></a>
    <a href="https://www.apache.org/licenses/LICENSE-2.0" alt="license">
        <img src="https://img.shields.io/github/license/tomarv2/terraform-aws-codebuild" /></a>
    <a href="https://github.com/tomarv2/terraform-aws-codebuild/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-aws-codebuild" /></a>
    <a href="https://github.com/tomarv2/terraform-aws-codebuild/pulse" alt="Activity">
        <img src="https://img.shields.io/github/commit-activity/m/tomarv2/terraform-aws-codebuild" /></a>
    <a href="https://stackoverflow.com/users/6679867/tomarv2" alt="Stack Exchange reputation">
        <img src="https://img.shields.io/stackexchange/stackoverflow/r/6679867"></a>
    <a href="https://twitter.com/intent/follow?screen_name=varuntomar2019" alt="follow on Twitter">
        <img src="https://img.shields.io/twitter/follow/varuntomar2019?style=social&logo=twitter"></a>
</p>

## Terraform module for AWS CodeBuild

### Versions

- Module tested for Terraform 1.0.1.
- AWS provider version [3.74](https://registry.terraform.io/providers/hashicorp/aws/latest).
- `main` branch: Provider versions not pinned to keep up with Terraform releases.
- `tags` releases: Tags are pinned with versions (use <a href="https://github.com/tomarv2/terraform-aws-codebuild/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-aws-codebuild" /></a>).

### Usage

#### Option 1:

```
terrafrom init
terraform plan -var='teamid=tryme' -var='prjid=project1'
terraform apply -var='teamid=tryme' -var='prjid=project1'
terraform destroy -var='teamid=tryme' -var='prjid=project1'
```
**Note:** With this option please take care of remote state storage

#### Option 2:

##### Recommended method (stores remote state in S3 using `prjid` and `teamid` to create directory structure):

- Create python 3.6+ virtual environment
```
python3 -m venv <venv name>
```

- Install package:
```
pip install tfremote --upgrade
```

- Set below environment variables:
```
export TF_AWS_BUCKET=<remote state bucket name>
export TF_AWS_BUCKET_REGION=us-west-2
export TF_AWS_PROFILE=<profile from ~/.ws/credentials>
```

or

- Set below environment variables:
```
export TF_AWS_BUCKET=<remote state bucket name>
export TF_AWS_BUCKET_REGION=us-west-2
export AWS_ACCESS_KEY_ID=<aws_access_key_id>
export AWS_SECRET_ACCESS_KEY=<aws_secret_access_key>
```

- Updated `examples` directory with required values.

- Run and verify the output before deploying:
```
tf -c=aws plan -var='teamid=foo' -var='prjid=bar'
```

- Run below to deploy:
```
tf -c=aws apply -var='teamid=foo' -var='prjid=bar'
```

- Run below to destroy:
```
tf -c=aws destroy -var='teamid=foo' -var='prjid=bar'
```

**Note:** Read more on [tfremote](https://github.com/tomarv2/tfremote)
### CodeBuild
```
module "codebuild" {
  source = "git::git@github.com:tomarv2/terraform-aws-codebuild.git"

  build_source_location   = "https://github.com/tomarv2/test-cicd"
  source_credential_token = var.source_credential_token
  codebuild_role          = "arn:aws:iam::123456789012:role/codebuild-role"
  environment_vars = [
    {
      name  = "AWS_REGION",
      value = "us-east-2",
      type  = "PLAINTEXT"
  }]
  filter_group = [{
    filter = [{
      exclude_matched_pattern = false
      type                    = "EVENT"
      pattern                 = "PUSH"
      },
      {
        exclude_matched_pattern = false
        type                    = "HEAD_REF"
        pattern                 = "dev" # branch name
    }]
  }]

  # To configure schedule
  schedule            = "rate(1 minute)"
  deploy_event_rule   = true
  deploy_event_target = true
  #-----------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
```

Please refer to example directory [link](examples) for references.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.74 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.74 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudwatch"></a> [cloudwatch](#module\_cloudwatch) | git::git@github.com:tomarv2/terraform-aws-cloudwatch.git | v0.0.7 |
| <a name="module_cloudwatch_event"></a> [cloudwatch\_event](#module\_cloudwatch\_event) | git::git@github.com:tomarv2/terraform-aws-cloudwatch-events.git | v0.0.4 |

## Resources

| Name | Type |
|------|------|
| [aws_codebuild_project.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codebuild_source_credential.authorization](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_source_credential) | resource |
| [aws_codebuild_source_credential.source_credentials](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_source_credential) | resource |
| [aws_codebuild_webhook.codebuild_webook](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_webhook) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_badge_enabled"></a> [badge\_enabled](#input\_badge\_enabled) | Generates a publicly-accessible URL for the projects build badge. Available as badge\_url attribute when enabled | `bool` | `false` | no |
| <a name="input_branch"></a> [branch](#input\_branch) | cloudwatch event branch | `string` | `"main"` | no |
| <a name="input_build_artifact_type"></a> [build\_artifact\_type](#input\_build\_artifact\_type) | Build output artifact's type. Valid values: CODEPIPELINE, NO\_ARTIFACTS, S3. | `string` | `"NO_ARTIFACTS"` | no |
| <a name="input_build_container_image"></a> [build\_container\_image](#input\_build\_container\_image) | Docker image to use for this build project. Valid values include Docker images provided by CodeBuild (e.g aws/codebuild/standard:2.0). | `string` | `"aws/codebuild/amazonlinux2-x86_64-standard:3.0"` | no |
| <a name="input_build_source_location"></a> [build\_source\_location](#input\_build\_source\_location) | Information about the build output artifact location. If type is set to CODEPIPELINE or NO\_ARTIFACTS, this value is ignored. If type is set to S3, this is the name of the output bucket. | `string` | `null` | no |
| <a name="input_build_source_type"></a> [build\_source\_type](#input\_build\_source\_type) | Type of repository that contains the source code to be built. Valid values: CODECOMMIT, CODEPIPELINE, GITHUB, GITHUB\_ENTERPRISE, BITBUCKET or S3 | `string` | `"GITHUB"` | no |
| <a name="input_build_timeout"></a> [build\_timeout](#input\_build\_timeout) | Number of minutes, from 5 to 480 (8 hours), for AWS CodeBuild to wait until timing out any related build that does not get marked as completed. The default is 60 minutes. | `string` | `"60"` | no |
| <a name="input_build_type"></a> [build\_type](#input\_build\_type) | The type of build this webhook will trigger. Valid values for this parameter are: BUILD, BUILD\_BATCH. | `string` | `"BUILD"` | no |
| <a name="input_buildspec_filepath"></a> [buildspec\_filepath](#input\_buildspec\_filepath) | Build specification to use for this build project's related builds. | `string` | `""` | no |
| <a name="input_cloudwatch_logs_status"></a> [cloudwatch\_logs\_status](#input\_cloudwatch\_logs\_status) | Current status of logs in CloudWatch Logs for a build project. Valid values: ENABLED, DISABLED. Defaults to ENABLED. | `string` | `"ENABLED"` | no |
| <a name="input_cloudwatch_path"></a> [cloudwatch\_path](#input\_cloudwatch\_path) | Name of the log group | `string` | `"/codebuild"` | no |
| <a name="input_codebuild_role"></a> [codebuild\_role](#input\_codebuild\_role) | Service role to be used by cicd | `string` | n/a | yes |
| <a name="input_compute_type"></a> [compute\_type](#input\_compute\_type) | Information about the compute resources the build project will use. Valid values: BUILD\_GENERAL1\_SMALL, BUILD\_GENERAL1\_MEDIUM, BUILD\_GENERAL1\_LARGE, BUILD\_GENERAL1\_2XLARGE. BUILD\_GENERAL1\_SMALL is only valid if type is set to LINUX\_CONTAINER. When type is set to LINUX\_GPU\_CONTAINER, compute\_type must be BUILD\_GENERAL1\_LARGE. | `string` | `"BUILD_GENERAL1_MEDIUM"` | no |
| <a name="input_concurrent_build_limit"></a> [concurrent\_build\_limit](#input\_concurrent\_build\_limit) | Specify a maximum number of concurrent builds for the project. The value specified must be greater than 0 and less than the account concurrent running builds limit. | `number` | `1` | no |
| <a name="input_container_type"></a> [container\_type](#input\_container\_type) | Type of build environment to use for related builds. Valid values: LINUX\_CONTAINER, LINUX\_GPU\_CONTAINER, WINDOWS\_CONTAINER (deprecated), WINDOWS\_SERVER\_2019\_CONTAINER, ARM\_CONTAINER. For additional information, see the CodeBuild User Guide. | `string` | `"LINUX_CONTAINER"` | no |
| <a name="input_custom_tags"></a> [custom\_tags](#input\_custom\_tags) | Custom extra tags | `any` | `null` | no |
| <a name="input_deploy_event_rule"></a> [deploy\_event\_rule](#input\_deploy\_event\_rule) | Deploy cloudwatch event rule | `bool` | `false` | no |
| <a name="input_deploy_event_target"></a> [deploy\_event\_target](#input\_deploy\_event\_target) | Deploy cloudwatch event trigger | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | Short description of the project. | `string` | `null` | no |
| <a name="input_environment_vars"></a> [environment\_vars](#input\_environment\_vars) | A list of maps, that contain both the key 'name' and the key 'value' to be used as additional environment variables for the build | <pre>list(object({<br>    name  = string<br>    value = string<br>    type  = string<br>  }))</pre> | <pre>[<br>  {<br>    "name": "NO_ADDITIONAL_BUILD_VARS",<br>    "type": "PLAINTEXT",<br>    "value": "TRUE"<br>  }<br>]</pre> | no |
| <a name="input_filter_group"></a> [filter\_group](#input\_filter\_group) | nested block: NestingSet, min items: 0, max items: 0 | <pre>set(object(<br>    {<br>      filter = list(object(<br>        {<br>          exclude_matched_pattern = bool<br>          pattern                 = string<br>          type                    = string<br>        }<br>      ))<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_git_clone_depth"></a> [git\_clone\_depth](#input\_git\_clone\_depth) | Truncate git history to this many commits. Use 0 for a Full checkout which you need to run commands like git branch --show-current. See AWS CodePipeline User Guide: Tutorial: Use full clone with a GitHub pipeline source for details. | `number` | `1` | no |
| <a name="input_override_artifact_name"></a> [override\_artifact\_name](#input\_override\_artifact\_name) | Whether a name specified in the build specification overrides the artifact name. | `bool` | `false` | no |
| <a name="input_private_repository"></a> [private\_repository](#input\_private\_repository) | Set to true to login into private repository with credentials supplied in source\_credential variable. | `bool` | `true` | no |
| <a name="input_privileged_mode"></a> [privileged\_mode](#input\_privileged\_mode) | Whether to enable running the Docker daemon inside a Docker container. Defaults to false. | `bool` | `false` | no |
| <a name="input_prjid"></a> [prjid](#input\_prjid) | Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply' | `string` | n/a | yes |
| <a name="input_queued_timeout"></a> [queued\_timeout](#input\_queued\_timeout) | Number of minutes, from 5 to 480 (8 hours), a build is allowed to be queued before it times out. The default is 8 hours. | `string` | `"30"` | no |
| <a name="input_schedule"></a> [schedule](#input\_schedule) | cloudwatch event schedule | `string` | `null` | no |
| <a name="input_source_credential_auth_type"></a> [source\_credential\_auth\_type](#input\_source\_credential\_auth\_type) | The type of authentication used to connect to a GitHub, GitHub Enterprise, or Bitbucket repository. | `string` | `"PERSONAL_ACCESS_TOKEN"` | no |
| <a name="input_source_credential_server_type"></a> [source\_credential\_server\_type](#input\_source\_credential\_server\_type) | The source provider used for this project. | `string` | `"GITHUB"` | no |
| <a name="input_source_credential_token"></a> [source\_credential\_token](#input\_source\_credential\_token) | For GitHub or GitHub Enterprise, this is the personal access token. For Bitbucket, this is the app password. | `string` | n/a | yes |
| <a name="input_source_credential_user_name"></a> [source\_credential\_user\_name](#input\_source\_credential\_user\_name) | Bitbucket username when the authType is BASIC\_AUTH. This parameter is not valid for other types of source providers or connections. | `string` | `""` | no |
| <a name="input_source_version"></a> [source\_version](#input\_source\_version) | A string that identifies the action type. | `string` | `null` | no |
| <a name="input_teamid"></a> [teamid](#input\_teamid) | Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply' | `string` | n/a | yes |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | Configuration for the builds to run inside a VPC. | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_codebuild_project_arn"></a> [codebuild\_project\_arn](#output\_codebuild\_project\_arn) | The ARN of the CodeBuild project. |
| <a name="output_codebuild_project_name"></a> [codebuild\_project\_name](#output\_codebuild\_project\_name) | The name of the AWS codebuild. |
<!-- END_TF_DOCS -->
