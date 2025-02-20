[![Stars](https://img.shields.io/github/stars/Razdolie/monitor.svg?label=Github%20%E2%98%85&a)](https://github.com/Razdolie/monitor/stargazers)
[![Release](https://img.shields.io/github/v/release/Razdolie/monitor?include_prereleases&label=last%20release&style=badge)](https://github.com/Razdolie/monitor/releases/latest)
[![OpenYellow](https://img.shields.io/endpoint?url=https://openyellow.org/data/badges/6/909930936.json)](https://openyellow.org/grid?data=top&repo=909930936)

[razdolie.github.io/dev-rules](https://razdolie.github.io/dev-rules/)

# monitor

> Библиотека разработана в рамках мастер-класса "[От базовой библиотеки до полного расцвета с ОСенью. Разработка базовой версии](https://infostart.ru/1c/articles/2275659/)"

Библиотека `monitor` предназначена для выполнения мониторинга различных системных параметров с гибкой настройкой через JSON-конфигурацию.

---

## Возможности
- Мониторинг дисков, процессора, оперативной памяти.
- Гибкая конфигурация через файл `config.json`.
- Поддержка добавления пользовательских проверок через интерфейсы.
- Уведомления о результатах мониторинга (Telegram, Email и др.).
- Логирование выполнения и ошибок.

---

## Использование
1. Создайте файл `config.json` на основе `example_config.json`.
2. Укажите параметры для каждой проверки:
   ```json
   {
       "Проверки": {
           "ПроверкаДисков": {
                "Использовать": true,	
                "Диски": ["C", "D"],
                "Порог": 20
           }
       }
   }
   ```

---

## Расширение библиотеки
Для добавления новой проверки:
1. Создайте файл проверки в папке `Модули` с именем `Проверка<Название>.os`.
2. Реализуйте процедуру `ВыполнитьПроверку(ПараметрыПроверки) Экспорт`.
3. Добавьте новую проверку в функцию `ДоступныеПроверки()` модуля `Мониторинг.os`.

---

## Контрибьюция
Мы будем рады вашим предложениям и улучшениям!  
1. Создайте fork репозитория.  
2. Сделайте изменения.  
3. Отправьте pull request.  

---

## Обратная связь
Если у вас есть вопросы или предложения, пишите нам через Issues или создавайте pull request!
