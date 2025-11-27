variable "project_name" {
  description = "Project name for tagging"
  type        = string
}
variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}
variable "public_subnet_cidr" {
  description = "Public subnet CIDR"
  type        = string
}
variable "private_subnet_cidr" {
  description = "Private subnet CIDR"
  type        = string
}