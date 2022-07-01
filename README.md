# devops-netology
## Вячеслав Сухарев

### Дипломная работа

#### Данный набор скриптов:

1. Готовит инфраструктуру с помощью Terraform на базе облачного провайдера YandexCloud.
1. Настраивает внешний Reverse Proxy на основе Nginx и LetsEncrypt.
1. Настраивает кластер MySQL.
1. Устанавливает WordPress.
1. Развертывает Gitlab CE.
1. Настраивает мониторинг инфраструктуры с помощью стека: Prometheus, Alert Manager и Grafana.  

Про CI/CD ![здесь](/cicd/)  

Что **необходимо** для запуска:  
1. Учетная запись в Yandex.Cloud
2. Домен, делегированный на `ns1.yandexcloud.net` и `ns1.yandexcloud.net` . Чтобы не ждать, можно эти же сервера прописать у себя в DNS на компе. Имя домена - в переменную `fqdn` в файле `variables.tf`
3. Создать облако. ID облака - в переменную `cloud_id` в файле `variables.tf` 
4. Создать каталог в облаке. ID каталога - в переменную `folder_id` в файле `variables.tf`
5. Создать Object Storage (bucket). 
