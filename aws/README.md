AWS Terraform Template for AlertLogic Threat Manager
=========================================================
Use this template to deploy Alert Logic Threat Manager into your existing AWS infrasturcture.

Requirements
------------
* Alert Logic account and unique registration key (otherwise enable autoclaim -- see notes below)
* Target VPC and public subnet to deploy the Threat Manager appliance

Notes
------
* To enable auto-claim, setup Cloud Defender environment first: https://docs.alertlogic.com/gsg/amazon-web-services-cloud-defender-cross-account-role-config.htm
* You can use template to deploy it in private subnet (set variables create_eip to 0 ) as long there is sufficient outbound route to IP address as specified in the template.


Sample usage
------------
1. Add the required variables and match it to your AWS environment, see detail below for each variables description

2. Apply the terraform template and wait until the Threat Manager appliance launched

3. Identify the internal / external IP from the Terraform state or directly from AWS console

4. open HTTP://external-ip  (or HTTP://internal-ip)

5. enter unique registration code to claim the appliance, or skip this process if you are using auto-claim


Variables
----------
  * claim_CIDR : source IP CIDR that is allowed to perform web claim on port 80, i.e. 0.0.0.0/0 or specific subnet range
  * monitoring_CIDR : CIDR netblock to be monitored (Where agents will be installed)
  * instance_type : minimum recommended size is c4.xlarge
  * tag_name : Provide a tag name for your Threat Manager instance
  * subnet_id : ID of a subnet, with a default route to an IGW or NAT GW, into which Threat Manager will be deployed
  * vpc_id : VPC into which Threat Manager will be deployed
  * create_eip : Set value to 1(true) if you want to deploy it on public subnet, otherwise set to 0(false)

Warning
----------
Please make sure to set versioning internally as needed if you pull this template directly from Alert Logic repository.

As we constantly updates the ami-id for Threat Manager instance, your environment state might be affected if you are using older ami-id.

It's not necessary to re-launch your Threat Manager appliance to match our ami-id, internally all Threat Manager appliance will perform self updates.
