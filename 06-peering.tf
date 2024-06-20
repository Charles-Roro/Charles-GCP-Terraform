

resource "google_compute_network_peering" "peering1" {
  name         = "manning-europe-america-peering"
  network      = google_compute_network.custom-vpc-tf-europe.self_link
  peer_network = google_compute_network.custom-vpc-tf-america.self_link
}

resource "google_compute_network_peering" "peering2" {
  name         = "manning-america-europe-peering"
  network      = google_compute_network.custom-vpc-tf-america.self_link
  peer_network = google_compute_network.custom-vpc-tf-europe.self_link
}

# resource "google_compute_network" "custom-vpc-tf-europe" {
#   name                    = "foobar"
#   auto_create_subnetworks = "false"
# }

# resource "google_compute_network" "custom-vpc-tf-america" {
#   name                    = "other"
#   auto_create_subnetworks = "false"
# }