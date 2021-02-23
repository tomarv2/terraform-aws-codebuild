## aws-codebuild module

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| add\_eventrule | n/a | `bool` | `false` | no |
| add\_eventtarget | n/a | `bool` | `false` | no |
| aws\_region | n/a | `any` | n/a | yes |
| badge\_enabled | Generates a publicly-accessible URL for the projects build badge. Available as badge\_url attribute when enabled | `bool` | `false` | no |
| branch | n/a | `any` | n/a | yes |
| build\_artifact\_type | n/a | `string` | `"NO_ARTIFACTS"` | no |
| build\_source\_location | n/a | `any` | n/a | yes |
| build\_source\_type | n/a | `any` | n/a | yes |
| build\_timeout | n/a | `string` | `"60"` | no |
| buildspec\_filepath | n/a | `any` | n/a | yes |
| codebuild\_role | service role to be used by CICD | `any` | n/a | yes |
| compute\_type | n/a | `string` | `"BUILD_GENERAL1_SMALL"` | no |
| container\_type | n/a | `string` | `"LINUX_CONTAINER"` | no |
| description | n/a | `string` | `"codebuild pipeline"` | no |
| email | email address to be used for tagging (suggestion: use group email address) | `any` | n/a | yes |
| environment\_vars | A list of maps, that contain both the key 'name' and the key 'value' to be used as additional environment variables for the build | <pre>list(object({<br>      name  = string<br>      value = string<br>      type = string<br>  }))</pre> | <pre>[<br>  {<br>    "name": "NO_ADDITIONAL_BUILD_VARS",<br>    "type": "PLAINTEXT",<br>    "value": "TRUE"<br>  }<br>]</pre> | no |
| git\_clone\_depth | n/a | `number` | `1` | no |
| image\_repo\_name | (Optional) ECR repository name to store the Docker image built by this module. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html | `string` | `"UNSET"` | no |
| image\_tag | (Optional) Docker image tag in the ECR repository, e.g. 'latest'. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html | `string` | `"latest"` | no |
| override\_artifact\_name | n/a | `bool` | `false` | no |
| private\_repository | Set to true to login into private repository with credentials supplied in source\_credential variable. | `bool` | `false` | no |
| privileged\_mode | n/a | `any` | n/a | yes |
| prjid | (Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply' | `any` | n/a | yes |
| profile\_to\_use | Getting values from ~/.aws/credentials | `any` | n/a | yes |
| queued\_timeout | n/a | `string` | `"30"` | no |
| schedule | n/a | `any` | `null` | no |
| source\_credential\_auth\_type | The type of authentication used to connect to a GitHub, GitHub Enterprise, or Bitbucket repository. | `string` | `"PERSONAL_ACCESS_TOKEN"` | no |
| source\_credential\_server\_type | The source provider used for this project. | `string` | `"GITHUB"` | no |
| source\_credential\_token | For GitHub or GitHub Enterprise, this is the personal access token. For Bitbucket, this is the app password. | `string` | `""` | no |
| source\_credential\_user\_name | The Bitbucket username when the authType is BASIC\_AUTH. This parameter is not valid for other types of source providers or connections. | `string` | `""` | no |
| source\_version | n/a | `string` | `"main"` | no |
| teamid | (Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply' | `any` | n/a | yes |
| trigger\_timeout | n/a | `number` | `60` | no |

## Outputs

| Name | Description |
|------|-------------|
| codebuild\_project\_arn | The ARN of the CodeBuild project. |
| codebuild\_project\_name | The name of the AWS codebuild. |
