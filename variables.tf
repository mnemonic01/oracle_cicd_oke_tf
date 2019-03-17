# Provider 

variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "reston_compartment_ocid" {}

variable "region" {
  default = "us-ashburn-1"
}

variable "project_name" {
  type    = "string"
  default = "OKE_CICD"
}

#/*  currenltly not working in pillar tenant 
#
#variable "project_tags" {
#  type        = map(string) 
#  description = "Required Tags from Hubs" 
#  default     = {}
#}
#
#*/

