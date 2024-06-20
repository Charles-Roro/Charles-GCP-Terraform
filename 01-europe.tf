resource "google_compute_network" "custom-vpc-tf-europe" {
    name = "manningeurope"
    auto_create_subnetworks = false
  
}

resource "google_compute_subnetwork" "manningeurope" {
  name = "manningeurope1"
  network = google_compute_network.custom-vpc-tf-europe.id
  ip_cidr_range = "10.88.2.0/24"
  region = "europe-west2"
  private_ip_google_access = true
}



resource "google_compute_firewall" "custom-vpc-tf-http" {
  name    = "http-allow"
  network = google_compute_network.custom-vpc-tf-europe.self_link
  
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = [ "10.88.2.0/24", "172.16.88.0/24", "172.16.99.0/24", "192.168.88.0/24"]

}


resource "google_compute_firewall" "custom-vpc-tf-ssh-america" {
  name = "ssh-allow"
  network = google_compute_network.custom-vpc-tf-america.self_link

  allow {
    protocol = "tcp"
    ports = ["22"]
  }
source_ranges = ["172.16.88.0/24", "172.16.99.0/24"]

  
  
}



resource "google_compute_firewall" "custom-vpc-tf" {
  name    = "nrule"
  network = google_compute_network.custom-vpc-tf-america.self_link


  allow {
    protocol = "tcp"
    ports    = ["80", "22"] 
  }


    source_ranges = ["0.0.0.0/0", "35.235.240.0/20"]



  source_tags = ["web"]
}

resource "google_compute_firewall" "custom-vpc-tf-rdp" {
  name    = "rdp"
  network = google_compute_network.custom-vpc-tf-asia.id

    allow{
        protocol = "tcp"
        ports = ["3389"]        
    }

    source_ranges = ["0.0.0.0/0"]

}