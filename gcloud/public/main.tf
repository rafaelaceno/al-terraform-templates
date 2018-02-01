# TerraForm Template for Alert Logic Threat Manager Appliance
#
# Pre-requisite:
# 1. copy the al-threat-appliance from Alert Logic storage by running the following command
#    gcloud compute images create al-threat-appliance --source-uri=https://storage.googleapis.com/threat/al-threat-appliance.tar.gz
# 2. gcloud project with network and public subnet created


#Set one external IP to be allocated for Threat Manager appliance
resource "google_compute_address" "external-ip" {
  name = "${var.instance_name}-external-ip"
}

#Threat Manager appliance resource
resource "google_compute_instance" "tmc" {
  name = "${var.instance_name}"
  machine_type = "${var.instance_type}"
  zone = "${var.target_zone}"

  tags = ["${var.tag_name}"]

  boot_disk {
    initialize_params {
      image = "projects/${var.target_project}/global/images/${var.image_name}"
    }
  }

  network_interface {
    network = "${var.network_name}"

    access_config {
      nat_ip = "${google_compute_address.external-ip.address}"
    }
  }
}

#Firewall rules configuration (inbound only)
resource "google_compute_firewall" "inbound-22" {
  name    = "${var.instance_name}-inbound-22"
  network = "${var.network_name}"

  allow {
    protocol = "tcp"
    ports    = ["22", "4849"]
  }

  source_ranges = ["208.71.209.32/27", "204.110.218.96/27", "204.110.219.96/27", "185.54.124.0/24"]
  target_tags   = ["${var.tag_name}"]
}

resource "google_compute_firewall" "inbound-80" {
  name    = "${var.instance_name}-inbound-80"
  network = "${var.network_name}"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["${var.claim_CIDR}"]
  target_tags   = ["${var.tag_name}"]
}

resource "google_compute_firewall" "inbound-agent" {
  name    = "${var.instance_name}-inbound-agent"
  network = "${var.network_name}"

  allow {
    protocol = "tcp"
    ports    = ["7777", "443"]
  }

  source_ranges = ["${var.monitoring_CIDR}"]
  target_tags   = ["${var.tag_name}"]
}

resource "google_compute_firewall" "egress-alertlogic" {
  name    = "${var.instance_name}-egress-alertlogic"
  network = "${var.network_name}"
  direction = "EGRESS"
  allow {
    protocol = "tcp"
    ports    = ["4138", "443"]
  }

  destination_ranges = ["208.71.209.32/27", "204.110.218.96/27", "204.110.219.96/27", "185.54.124.0/24"]
  target_tags   = ["${var.tag_name}"]
}

resource "google_compute_firewall" "egress-dns" {
  name    = "${var.instance_name}-egress-dns"
  network = "${var.network_name}"
  direction = "EGRESS"
  allow {
    protocol = "tcp"
    ports    = ["4138", "443"]
  }

  destination_ranges = ["8.8.8.8/32", "8.8.4.4/32"]
  target_tags   = ["${var.tag_name}"]
}
