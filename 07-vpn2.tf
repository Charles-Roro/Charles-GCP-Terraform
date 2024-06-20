### Original error was I didnt label the VON forwarding rules correctly. I gave both ends the same name

resource "google_compute_vpn_gateway" "asia_gateway" {
  name    = "manningasia1-vpn-gateway"
  network = google_compute_network.custom-vpc-tf-asia.id
  region  = "asia-southeast1"
}

resource "google_compute_address" "vpn_static_ip_asia" {
  name   = "vpn-static-ip-asia"
  region = "asia-southeast1"
}


resource "google_compute_forwarding_rule" "fr_esp_asia" {
  name        = "fr-esp-asia"
  ip_protocol = "ESP"
  ip_address  = google_compute_address.vpn_static_ip_asia.address
  target      = google_compute_vpn_gateway.asia_gateway.self_link
  region      = "asia-southeast1"
}

resource "google_compute_forwarding_rule" "fr_udp500" {
  name        = "fr-udp500"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = google_compute_address.vpn_static_ip_asia.address
  target      = google_compute_vpn_gateway.asia_gateway.self_link
  region      = "asia-southeast1"
}

resource "google_compute_forwarding_rule" "fr_udp4500" {
  name        = "fr-udp4500"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = google_compute_address.vpn_static_ip_asia.address
  target      = google_compute_vpn_gateway.asia_gateway.self_link
  region      = "asia-southeast1"
}

resource "google_compute_vpn_gateway" "europe_gateway" {
  name    = "manningeurope1-vpn-gateway"
  network = google_compute_network.custom-vpc-tf-europe.id
  region  = "europe-west2"
}

resource "google_compute_address" "vpn_static_ip_europe" {
  name   = "vpn-static-ip-europe"
  region = "europe-west2"
}


resource "google_compute_forwarding_rule" "fr_esp_europe" {
  name        = "fr-esp-europe"
  ip_protocol = "ESP"
  ip_address  = google_compute_address.vpn_static_ip_europe.address
  target      = google_compute_vpn_gateway.europe_gateway.self_link
  region      = "europe-west2"
}

resource "google_compute_forwarding_rule" "fr_udp500_2" {
  name        = "fr-udp500"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = google_compute_address.vpn_static_ip_europe.address
  target      = google_compute_vpn_gateway.europe_gateway.self_link
  region      = "europe-west2"
}

resource "google_compute_forwarding_rule" "fr_udp4500_2" {
  name        = "fr-udp4500"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = google_compute_address.vpn_static_ip_europe.address
  target      = google_compute_vpn_gateway.europe_gateway.self_link
  region      = "europe-west2"
}


resource "google_compute_vpn_tunnel" "manningasia1_vpn_tunnel" {
  name                  = "manningasia1-vpn-tunnel"
  peer_ip               = google_compute_address.vpn_static_ip_europe.address 
  shared_secret         = sensitive("a secret message")
  local_traffic_selector  = ["192.168.88.0/24"]
  remote_traffic_selector = ["10.88.2.0/24"]
  target_vpn_gateway    = google_compute_vpn_gateway.asia_gateway.self_link

 depends_on = [
    google_compute_forwarding_rule.fr_esp_asia,
    google_compute_forwarding_rule.fr_udp500,
    google_compute_forwarding_rule.fr_udp4500,
  ]

}

resource "google_compute_vpn_tunnel" "manningeurope1_vpn_tunnel" {
  name                  = "manningeurope1-vpn-tunnel"
  peer_ip               = google_compute_address.vpn_static_ip_asia.address 
  shared_secret         = sensitive("a secret message")
  local_traffic_selector  = ["10.88.2.0/24"]
  remote_traffic_selector = ["192.168.88.0/24"]
  target_vpn_gateway    = google_compute_vpn_gateway.europe_gateway.self_link




  depends_on = [
    google_compute_forwarding_rule.fr_esp_europe,
    google_compute_forwarding_rule.fr_udp500_2,
    google_compute_forwarding_rule.fr_udp4500_2,
  ]


}

# Routes
resource "google_compute_route" "asia_route" {
  name       = "asia-route"
  network    = google_compute_network.custom-vpc-tf-asia.self_link
  dest_range = "10.88.2.0/24"
  priority   = 1000
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.manningasia1_vpn_tunnel.id
}

resource "google_compute_route" "europe_route" {
  name       = "europe-route"
  network    = google_compute_network.custom-vpc-tf-europe.self_link
  dest_range = "192.168.88.0/24"
  priority   = 1000
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.manningeurope1_vpn_tunnel.id
}