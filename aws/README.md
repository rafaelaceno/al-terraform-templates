# AWS Terraform Template for Alert Logic IDS with CloudWatch Monitoring Feature

Use this template to deploy Alert Logic IDS into your existing AWS infrasturcture.

## Requirements

- Alert Logic account and unique registration key (otherwise enable autoclaim -- see notes below)
- Target VPC and public subnet to deploy the IDS appliance

## Notes

- To enable auto-claim, setup Cloud Defender environment first: <https://legacy.docs.alertlogic.com/gsg/amazon-web-services-cloud-defender-cross-account-role-config.htm>
- You can use template to deploy it in private subnet (set variables create_eip to 0 ) as long there is sufficient outbound route to IP address as specified in the template.

## Sample usage

1. Add the required variables and match it to your AWS environment, see detail below for each variables description

2. Apply the terraform template and wait until the IDS appliance launched

3. Identify the internal / external IP from the Terraform state or directly from AWS console (Optional for manual claim)

4. open <http://external-ip> (or <http://internal-ip)> (Optional for manual claim)

5. enter unique registration code to claim the appliance, or skip this process if you are using auto-claim (Optional for manual claim)

## Variables

```text
vpc_id = "VPC into which IDS will be deployed"
subnet_id = "Subnet ID where the IDS instance will be dployed in (Must have route to the internet via IGW for public subnet)"
availability_zone = "Availablity zone where the IDS instance will be deployed in"
monitoring_cidr = "CIDR netblock to be monitored (Where agents will be installed or VPC CIDR)"
instance_type = "IDS EC2 instance type (Supported: c4.large, c4.xlarge, c4.2xlarge, c5.large, c5.xlarge, c5.2xlarge)"
name_tag = "Provide a name tag for your IDS instance"
env_tag = "Provide a tag name of the environment where your IDS instance will be deployed in"
create_eip = "Set value to true if you want to deploy it on public subnet, otherwise set to false"
ids_count = "Number of IDS instances to deploy"
enable_monitoring = "Set value to true if you want launched IDS instance to have detailed monitoring enabled, otherwise set to false"
```

## Warning

Please make sure to set versioning internally as needed if you pull this template directly from Alert Logic repository.

As we constantly updates the ami-id for IDS instance, your environment state might be affected if you are using older ami-id.

It's not necessary to re-launch your IDS appliance to match our ami-id, internally all IDS appliance will perform self updates.
