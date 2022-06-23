# Outputs for the YC ID

output "cloud_id" {
  value = data.yandex_client_config.me.cloud_id
}
output "folder_id" {
  value = data.yandex_client_config.me.folder_id
}

# Outputs for network

output "public-ip-for-ingress" {
  value = yandex_compute_instance.nginx[0].network_interface[0].nat_ip_address
}

