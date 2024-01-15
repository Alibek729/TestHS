# Test4iOSJunior

## Установка

Для установки проекта выполните следующие шаги:

1. Склонируйте репозиторий: `git clone https://github.com/Alibek729/TestHS.git`
2. Перейдите в директорию проекта: `cd ваш-проект`
3. Запустите скрипт установки SwiftLint: `./install_swiftlint.sh`
4. Откройте проект в Xcode: `open ваш-проект.xcodeproj`

## SwiftLint

Для поддержания стиля кодирования используется инструмент SwiftLint. Конфигурационные параметры указаны в файле `.swiftlint.yml`. Вы можете запустить SwiftLint с помощью скрипта:
```
export PATH="$PATH:/opt/homebrew/bin"
if which swiftlint > /dev/null; then
  swiftlint
else 
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
  exit 1
fi
```
## Размеры и стили

Размеры и стили используются для унификации внешнего вида элементов интерфейса. Вы можете настроить их в файле Size.swift.

## Цвета и изображения

Общие цвета и изображения определены в GlobalUtils. Обратите внимание на использование именованных ресурсов, таких как pinkText, pinkBackground, и т.д.

## Архитектура

Проект реализован с использованием архитектуры Clean Swift (VIP). Включает в себя следующие основные компоненты:

MenuWorker: Класс, отвечающий за выполнение запросов и преобразование URL-строки в изображение.
MenuInteractor: Компонент, выполняющий бизнес-логику. Он взаимодействует с MenuWorker и передает результаты презентеру.
MenuPresenter: Отвечает за представление данных. Получает информацию от интерактора и обновляет представление.
MenuViewController: Основной контроллер, отвечающий за отображение пользовательского интерфейса и взаимодействие с пользователем.

## Пример использования

Пример использования компонентов архитектуры Clean Swift:
```
// Инициализация репозитория и получение списка напитков
let repository: IMenuRepository = MenuRepository()
let drinksRequests = repository.getDrinks()

// Создание интерактора и презентера
let worker = MenuWorker()
let presenter = MenuPresenter(viewController: self)
let interactor = MenuInteractor(worker: worker, presenter: presenter)

// Вызов метода интерактора для загрузки данных
interactor.fetchDrinks(requests: drinksRequests)
```

## Запросы к API

Проект использует открытое API "TheCocktailDB" для получения данных о напитках. API-запросы выполняются с использованием MenuWorker. 
Обратите внимание, что для использования API требуется доступ к интернету.

