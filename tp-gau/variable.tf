variable "region" {
  type    = string
  default = "us-east-1"
}
variable "bucket_name" {
  type    = string
  default = "zoulouterie-static-website"
}
variable "file_site_dir" {
  type    = string
  default = "./site/"
}
variable "domaine_name" {
  type    = string
  default = "www.zoulouterie.link"
}
