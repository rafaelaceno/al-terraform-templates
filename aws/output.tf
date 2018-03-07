// Outputs
output "Threat Manager public IP" {
	value = "${aws_eip.tmc.*.public_ip}"
}

output "Threat Manager private IP" {
	value = "${aws_instance.tmc.private_ip}"
}

output "Threat Manager security group (if needed add this to your EC2 instance outbound rules" {
	value = "${aws_security_group.tmc_sg.id}"
}
