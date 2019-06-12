// Specify the provider and access details below

provider "aws" {
  region     = "${var.aws_region}"
  access_key = "${var.aws_access_key_id}"
  secret_key = "${var.aws_secret_access_key}"
  version    = "~> 1.6"
}

variable "aws_region" {
  description = "The AWS region to deploy the appliance in."
}

variable "aws_access_key_id" {
  description = "The user access key for authentication."
}

variable "aws_secret_access_key" {
  description = "The user secret access key for authentication."
}

// Set main variables

variable "vpc_id" {
  description = "VPC ID where the IDS instance will be deployed in (Check available EIPs when deploying into a public subnet)."
}

variable "subnet_id" {
  description = "Subnet ID where the IDS instance will be dployed in (Must have route to the internet via IGW for public subnet)."
}

variable "instance_type" {
  description = "IDS EC2 instance type (Supported: c4.large, c4.xlarge, c4.2xlarge, c5.large, c5.xlarge, c5.2xlarge)."
}

variable "name_tag" {
  description = "Provide a name tag for your IDS instance."
  default     = "Alert Logic IDS Security Appliance"
}

variable "env_tag" {
  description = "Provide a tag name of the environment where your IDS instance will be deployed in."
  default     = "alertlogic"
}

variable "monitoring_cidr" {
  description = "CIDR netblock to be monitored (Where agents will be installed)."
}

variable "create_eip" {
  description = "Set value to true if you want to deploy it on public subnet, otherwise set to false."
  default     = "false"
}

variable "ids_count" {
  description = "Number of IDS instances to deploy."
  default     = "1"
}

variable "enable_monitoring" {
  description = "Launched IDS instance will have detailed monitoring enabled"
  default     = "true"
}

// Latest AMI as per Mar 2018, contact AlertLogic (support@alertlogic.com) if you want to see the latest AMI per region
// Tag to ver: P13
variable "aws_amis" {
  default = {
    ap-south-1     = "ami-944916fb"
    eu-west-3      = "ami-2d66d050"
    eu-west-2      = "ami-c66480a1"
    eu-west-1      = "ami-c57336bc"
    ap-northeast-2 = "ami-e768c589"
    ap-northeast-1 = "ami-f07e3896"
    sa-east-1      = "ami-72115a1e"
    ca-central-1   = "ami-6d880f09"
    ap-southeast-1 = "ami-1c1e5560"
    ap-southeast-2 = "ami-3edd1b5c"
    eu-central-1   = "ami-aa92ffc5"
    us-east-1      = "ami-5934df24"
    us-east-2      = "ami-e5fdca80"
    us-west-1      = "ami-87e6ede7"
    us-west-2      = "ami-5b9e1623"
    us-gov-west-1  = "ami-89df5ce8"
  }
}
