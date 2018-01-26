Gcloud Terraform Template for AlertLogic Threat Manager
=========================================================
Use this template to deploy Alert Logic Threat Manager into your existing GCloud infrasturcture.

Requirements
------------
* copy the al-threat-appliance from Alert Logic storage
* Gcloud project with network and subnet created
* Alert Logic account and unique registration key

Notes
------
* Gcloud firewall rules for egress still in beta, so it's not yet included


Sample usage
------------
1. First you must run this command to copy Alert Logic Threat Manager image to your Gcloud storage ::

    gcloud compute images create al-threat-appliance --source-uri=https://storage.googleapis.com/threat/al-threat-appliance.tar.gz

2. Add the required variables on the tfvars file and match it to your Gcloud project, plan and then apply the Terraform template

3. Grab the public / external IP from the Terraform state or directly from Gcloud console

4. open HTTP://external-ip

5. enter unique registration code to claim the appliance


Variables
----------
  * target_project : target project name to deploy this appliance
  * target_region : target region to deploy this appliance, i.e. us-central1
  * target_zone : zone for the TM appliance, i.e. us-central1-a
  * network_name : network name where the TM appliance will be deployed
  * sub_network : subnet name inside the network 
  * monitoring_CIDR : network CIDR for the TM appliance (not subnet / sub network CIDR)
  * claim_CIDR : source IP CIDR that is allowed to perform web claim on port 80, i.e. 0.0.0.0/0 or specific subnet range
  * instance_name : free form label to name the TM appliance
  * instance_type : minimum size is n1-standard4
  * image_name : image name for Threat Appliance  
  * tag_name : target tag to be assigned for firewall rules

License and Authors
===================
License:
Distributed under the Apache 2.0 license.

Authors: 
Welly Siauw (welly.siauw@alertlogic.com)