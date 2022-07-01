# CI/CD

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
  
Описание действий, которые делает раннер, в файле `.gitlab-ci.yml`
