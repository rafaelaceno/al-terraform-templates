#Set variables
variable "target_project" {
  description = "GCloud project name"
}

variable "target_region" {
  description = "Target region for deployment"
}

variable "target_zone" {
  description = "Target zone for deployment"
}

variable "network_name" {
  description = "Existing network for deployment"
}

variable "sub_network" {
  description = "Existing sub network for deployment"
}

variable "monitoring_CIDR" {
  description = "CIDR netblock to be monitored (where AL Agent will be installed)"
}

variable "claim_CIDR" {
  description = "CIDR netblock that is allowed to access Threat Manager appliance claim web-page "
}

variable "instance_name" {
  description = "Label name for the Threat Manager appliance"
}

variable "instance_type" {
  description = "Set instance type for Threat Manager appliance, minimum n1-standard-4"
}

variable "image_name" {
  description = "Google compute image name copied from Alert Logic"
}

variable "tag_name" {
  description = "Tag label for network firewall rules tagging"
}