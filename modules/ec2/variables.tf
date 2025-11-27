variable "project_name" {
  type = string
}
variable "subnet_id" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "key_name" {
  type    = string
  default = ""
}
variable "public_sg_id" {
  type = string
}
variable "user_data" {
  type = string
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
