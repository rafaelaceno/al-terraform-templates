// Outputs
output "ids_instance_id" {
  value = "${aws_instance.ids_instance.*.id}"
}

output "ids_public_ip" {
  value = "${aws_eip.ids_eip.*.public_ip}"
}

output "ids_private_ip" {
  value = "${aws_instance.ids_instance.*.private_ip}"
}

output "ids_sg_id" {
  value = "${aws_security_group.ids_sg.id}"
}
