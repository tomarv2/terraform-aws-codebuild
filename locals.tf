locals {
  buildspec_filepath = var.buildspec_filepath != "" ? var.buildspec_filepath : "${path.module}/buildspec.yml"
}
