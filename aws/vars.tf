# Set variables
variable "vpc_id" {
	description = "VPC into which Threat Manager will be deployed (Must have available EIPs)."
}

variable "subnet_id" {
	description = "ID of a DMZ subnet, with a default route to an IGW, into which Threat Manager will be deployed."
}

variable "instance_type" {
	description = "EC2 Instance Type Threat Manager will be spun up as (Supported: c4.large, c4.xlarge, c4.2xlarge, c5.large, c5.xlarge, c5.2xlarge)."
}

variable "tag_name" {
	description = "Provide a tag name for your Threat Manager instance."
}
variable "claimCIDR" {
	description = "CIDR netblock which will be submitting the web form that the appliance serves for claiming over port 80 (This rule can be removed after the appliance has been claimed)."
}

variable "monitoringCIDR" {
	description = "CIDR netblock to be monitored (Where agents will be installed)."
}

variable "create_eip" {
	description = "Set value to 1(true) if you want to deploy it on public subnet, otherwise set to 0(false)"
}

# Latest AMI as per Mar 2018, contact AlertLogic (support@alertlogic.com) if you want to see the latest AMI per region
# Tag to ver: P13
variable "aws_amis" {
  default = {
		ap-south-1 = "ami-944916fb"
		eu-west-3 = "ami-2d66d050"
		eu-west-2 = "ami-c66480a1"
		eu-west-1 = "ami-c57336bc"
		ap-northeast-2 = "ami-e768c589"
		ap-northeast-1 = "ami-f07e3896"
		sa-east-1 = "ami-72115a1e"
		ca-central-1 = "ami-6d880f09"
		ap-southeast-1 = "ami-1c1e5560"
		ap-southeast-2 = "ami-3edd1b5c"
		eu-central-1 = "ami-aa92ffc5"
		us-east-1 = "ami-5934df24"
		us-east-2 = "ami-e5fdca80"
		us-west-1 = "ami-87e6ede7"
		us-west-2 = "ami-5b9e1623"
		us-gov-west-1 = "ami-89df5ce8"
  }
}
