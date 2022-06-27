data "yandex_client_config" "me" {}

# Создаем сеть
resource "yandex_vpc_network" "mtsh-net" {
  name = "mtsh"
}

# Создаем правило маршрутизации - все на ingress
resource "yandex_vpc_route_table" "nat-int" {
  network_id = "${yandex_vpc_network.mtsh-net.id}"

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = var.ingress_ip
  }
}

# Создаем подсети в разных зонах доступности
resource "yandex_vpc_subnet" "mtsh-subnet-a" {
  v4_cidr_blocks = ["10.202.0.0/24"]
  zone           = "${var.zone}a"
  network_id     = "${yandex_vpc_network.mtsh-net.id}"
  route_table_id = "${yandex_vpc_route_table.nat-int.id}"
}

resource "yandex_vpc_subnet" "mtsh-subnet-b" {
  v4_cidr_blocks = ["10.202.1.0/24"]
  zone           = "${var.zone}b"
  network_id     = "${yandex_vpc_network.mtsh-net.id}"
  route_table_id = "${yandex_vpc_route_table.nat-int.id}"
}

