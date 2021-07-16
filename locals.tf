locals {
  shared_tags = tomap(
    {
      "Name"    = "${var.teamid}-${var.prjid}",
      "team"    = var.teamid,
      "project" = var.prjid
    }
  )
  buildspec_filepath = var.buildspec_filepath != "" ? var.buildspec_filepath : "${path.module}/buildspec.yml"
}
