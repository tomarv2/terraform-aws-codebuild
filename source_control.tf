resource "aws_codebuild_source_credential" "authorization" {
  count       = var.private_repository ? 1 : 0

  auth_type   = var.source_credential_auth_type
  server_type = var.source_credential_server_type
  token       = var.source_credential_token
  user_name   = var.source_credential_user_name
}
