#Access token
variable "token" {
  type      = string
  sensitive = true
}

#ID облака
variable "cloud_id" {
  type    = string
  default = "b1g3ub80oi6o4m21td0m"
}

#ID каталога
variable "folder_id" {
  type    = string
  default = "b1gcu7t3og1h7vjcd40j"
}

#Зона доступности
variable "zone" {
  type    = string
  default = "ru-central1-"
}

#Доменное имя
variable "fqdn" {
  type    = string
  default = "mtsh.site"
}

#Фиксированный серый IP для ingress
variable "ingress_ip" {
  type    = string
  default = "10.202.0.100"
}


#Параметры ВМ
variable "hosts" {
    type = map(map(map(string)))
    default = {
      stage = {
        vm1 = {
          name = "db01"
          cores = "2"
          memory = "2"
          core_fraction = "20"
        }
        vm2 = {
          name = "db02"
          cores = "2"
          memory = "2"
          core_fraction = "20"
        }
        vm3 = {
          name = "app"
          cores = "2"
          memory = "2"
          core_fraction = "20"
        }
#        vm4 = {
#          name = "gitlab-stage.local"
#          cores = "4"
#          memory = "4"
#          core_fraction = "20"
#        }
#        vm5 = {
#          name = "monitoring-stage.local"
#          cores = "4"
#          memory = "4"
#          core_fraction = "20"
#        }

    }
      prod = {
    }
    }
}
