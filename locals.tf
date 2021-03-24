locals {
  shared_tags = map(
    "Name", "${var.teamid}-${var.prjid}",
    "team", var.teamid,
    "project", var.prjid
  )
  buildspec_filepath = var.buildspec_filepath != "" ? var.buildspec_filepath : file("${path.module}/buildspec.yml")
}
