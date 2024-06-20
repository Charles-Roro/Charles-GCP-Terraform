resource "google_compute_network" "custom-vpc-tf-asia" {
    name = "manningasiamain"
    auto_create_subnetworks = false
  
}

resource "google_compute_subnetwork" "manningasia1" {
    name = "manningasia1"
    network = google_compute_network.custom-vpc-tf-asia.id
    ip_cidr_range = "192.168.88.0/24"
    region = "asia-southeast1"
    private_ip_google_access = true
}