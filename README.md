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
    <a href="https://discord.gg/XH975bzN" alt="chat on Discord">
        <img src="https://img.shields.io/discord/813961944443912223?logo=discord"></a>
    <a href="https://twitter.com/intent/follow?screen_name=varuntomar2019" alt="follow on Twitter">
        <img src="https://img.shields.io/twitter/follow/varuntomar2019?style=social&logo=twitter"></a>
</p>

# Terraform module for AWS CodeBuild

## Versions

- Module tested for Terraform 1.0.1.
- AWS provider version [3.47.0](https://registry.terraform.io/providers/hashicorp/aws/latest).
- `main` branch: Provider versions not pinned to keep up with Terraform releases.
- `tags` releases: Tags are pinned with versions (use <a href="https://github.com/tomarv2/terraform-aws-codebuild/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-aws-codebuild" /></a>).

## Usage

### Option 1:

```
terrafrom init
terraform plan -var='teamid=tryme' -var='prjid=project1'
terraform apply -var='teamid=tryme' -var='prjid=project1'
terraform destroy -var='teamid=tryme' -var='prjid=project1'
```
**Note:** With this option please take care of remote state storage

### Option 2:

#### Recommended method (stores remote state in S3 using `prjid` and `teamid` to create directory structure):

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

**NOTE:**

- Read more on [tfremote](https://github.com/tomarv2/tfremote)
---

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
        pattern                 = "test"
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
