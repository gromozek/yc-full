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

Что **необходимо** для запуска:  
1. Учетная запись в Yandex.Cloud
2. Домен, делегированный на `ns1.yandexcloud.net` и `ns1.yandexcloud.net` . Чтобы не ждать, можно эти же сервера прописать у себя в DNS на компе. Имя домена - в переменную `fqdn` в файле `variables.tf`
3. Создать облако. ID облака - в переменную `cloud_id` в файле `variables.tf` 
4. Создать каталог в облаке. ID каталога - в переменную `folder_id` в файле `variables.tf`
5. Создать Object Storage (bucket). Добавить имя бакета в файл `backend.conf` `bucket     = <your-bucket-name>`
6. Создать сервисный аккаунт с ролью `editor`. Сгенерировать статический ключ доступа для этого аккаунта. ID и секрет ключа записать в соответствующие параметры в файл `backend.conf`: `access_key = <your-access-key>` `secret_key = <your-secret-key>`
7. Получить OAuth токен по инструкции [здесь](https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token) 
8. Запуск происходит в workspace `stage`, его надо создать, команды ниже.
  
Запуск:
```bash
$ export TF_VAR_token=<ваш OAuth токен>
$ cd terraform
$ terraform workspace new stage
$ terraform workspace select stage 
$ terraform init -backend-config=backend.conf
$ terraform plan
$ terraform apply
```

Что **можно** поменять:
1. Параметры создаваемых ВМ. Они описаны в переменной `hosts` в файле `variables.tf`
2. Выставить `preemptible = false` в файле `compute.tf`, чтобы ВМ не отключались каждые 24 часа. Сейчас стоит true для экономии денег.
3. Выставить время ожидания поднятия ВМ в файле `ansible.tf` `command = "sleep <time>"`. Или вообще переименовать этот файл в `.bak` и запускать Ansible часть вручную `ansible-playbook -i ../ansible/inventory.yml ../ansible/play.yml`
4. Изменить тип выдаваемого сертификата в `ansible/roles/nginx/defaults/main.yml`, поставить `letsencrypt_staging: true` для отладочных целей.

Действия, совершаемые скриптами, описаны в комментариях в соответствующих файлах.  

#### Скриншоты
Основной сайт  
![](/screenshots/web1.png)  
  
Prometheus (выключил одну машину, чтобы было видно, как отрабатывают алерты) 
![](/screenshots/prometheus1.png)  
  
Prometheus - алерты
![](/screenshots/prometheus2.png)  
  
Prometheus - инфо
![](/screenshots/prometheus3.png)  
  
Алертменеджер - состояние
![](/screenshots/alertmanager1.png)  
  
Алертменеджер - инфо
![](/screenshots/alertmanager2.png)  
  
Графана - список бордов
![](/screenshots/grafana1.png)  
  
Графана - работющая борда Node Exporter и список хостов. 
![](/screenshots/grafana2.png)  

#### CI/CD  

Заходим в локальный gitlab.  
Создаем новый публичный репозиторий.  
Копируем любым доступным способом в этот репозиторий файлы из каталога `cicd`  
В настройках CI/CD, во разделе Runners, находим и копируем токен доступа, вписываем его в параметр `runner_token` в файле `prepare.yml` 

Для запуска пайплайнов необходимо подготовить машину, развернув на ней gitlab-runner и wp-cli
```bash
$ cd ansible
$ ansible-playbook ../cicd/prepare.yml -i inventory.yml -l app 
```
Для демонстрации CI/CD на Wordpress изменим главную тему. Сейчас при наведении курсора на ссылку она подчеркивается пунктиром:
  
![](/screenshots/cicd1.png)  

Изменим файл `wp-content/themes/mytheme/style.css`. Поменяем `text-decoration-style` на `waved`
  
![](/screenshots/cicd2.png)  
  
После коммита ждем отработки задачи
  
![](/screenshots/cicd3.png)  
  
Обновляем страницу и видим, что ссылка стала подчеркиваться волнистой линией.
  
![](/screenshots/cicd4.png)
  
Описание действий, которые делает раннер, в комментариях в файле `.gitlab-ci.yml`

