resource "google_compute_network" "custom-vpc-tf-america" {
    name = "manningamericamain"
    auto_create_subnetworks = false
  
}

resource "google_compute_subnetwork" "manningamerica1" {
  name = "manningamerica1"
  network = google_compute_network.custom-vpc-tf-america.id
  ip_cidr_range = "172.16.88.0/24"
  region = "us-central1"
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "manningamerica2" {
  name = "manningamerica2"
  network = google_compute_network.custom-vpc-tf-america.id
  ip_cidr_range = "172.16.99.0/24"
  region = "us-east1"
  private_ip_google_access = true
}
