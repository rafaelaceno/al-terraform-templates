#Output results

output "TMC_public_ip" {
  value = "${google_compute_address.external-ip.address}"
}
