# Selenium-Modules

![Image alt](https://github.com/Lifailon/Selenium-Modules/blob/rsa/Images/logo.jpg)

Modules in base **Selenium 💚 via 💙 PowerShell** for free use (without API) **ChatGPT, Text Translation and Internet SpeedTest**.

## 🚀 Quick start

To install or update all dependencies (browser Chromium and drivers), use the command for [deployment](https://github.com/Lifailon/Deploy-Selenium):

```PowerShell
Invoke-Expression(New-Object Net.WebClient).DownloadString("https://raw.githubusercontent.com/Lifailon/Deploy-Selenium/rsa/Deploy-Selenium-Drivers.ps1")
```

## ChatGPT

🐥 The idea is that if you can't get an API key, you can use a third-party 🙏 **[free Chat-GPT web interface](https://chatg.io)** that doesn't require authorization to be able to implement the interface for your scripts or just chat with the bot in the PowerShell console.

### 🚀 Install module

To install the module in the default PowerShell modules directory, run the command in your console:

```PowerShell
Invoke-RestMethod https://raw.githubusercontent.com/Lifailon/Selenium-Modules/rsa/Modules/Get-GPT/Get-GPT.psm1 | Out-File -FilePath "$(New-Item -Path "$($($Env:PSModulePath -split ";")[0])\Get-GPT" -ItemType Directory -Force)\Get-GPT.psm1" -Force
```

### 🎉 Example

```PowerShell
PS C:\Users\lifailon> Import-Module Get-GPT

PS C:\Users\lifailon> "Исполняй роль калькулятора. Посчитай сумму чисел: 22+33"
Конечно! Сумма чисел 22 и 33 равна 55. Чем еще я могу помочь?

PS C:\Users\lifailon> Get-GPT "Исполняй роль интерпретатора PowerShell. Выведи результат команды: Write-Host $(22+33)"
Конечно! Вот результат выполнения команды "Write-Host 55":
55

PS C:\Users\lifailon> Get-GPT "Исполняй роль переводчика. Переведи текст на русский язык: Hi! How can I help you?"
Привет! Как я могу тебе помочь?

PS C:\Users\lifailon> Get-GPT "Напиши код на языке PowerShell, который позволяет получить прогноз погоды"
Конечно! Вот пример кода на языке PowerShell, который использует API OpenWeatherMap для получения прогноза погоды:
# Установка модуля Invoke-RestMethod, если необходимо
if (-not (Get-Module -ListAvailable -Name 'PowerShellGet')) {
    Install-PackageProvider -Name 'NuGet' -Force
}
if (-not (Get-Module -ListAvailable -Name 'PackageManagement')) {
    Install-Module -Name 'PackageManagement' -Force
}
if (-not (Get-Module -ListAvailable -Name 'PowerShellGet')) {
    Install-Module -Name 'PowerShellGet' -Force
}
if (-not (Get-Module -ListAvailable -Name 'Invoke-RestMethod')) {
    Install-Module -Name 'Invoke-RestMethod' -Force
}

# Замените 'YOUR_API_KEY' на ваш ключ API OpenWeatherMap
$apiKey = 'YOUR_API_KEY'

# Замените 'CITY_NAME' на название города, для которого нужен прогноз погоды
$city = 'CITY_NAME'

# Формирование URL-запроса к API OpenWeatherMap
$url = "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey"

# Получение данных о погоде через API
$response = Invoke-RestMethod -Uri $url

# Извлечение нужной информации из ответа API
$temperature = $response.main.temp
$description = $response.weather[0].description

# Вывод информации о погоде
Write-Host "Текущая температура в городе $city: $temperature градусов Цельсия"
Write-Host "Описание погоды: $description"
Не забудьте заменить 'YOUR_API_KEY' на ваш собственный ключ API OpenWeatherMap и 'CITY_NAME' на название города, для которого вы хотите получить прогноз погоды. После запуска скрипта, вы увидите текущую температуру и описание погоды
```

![Image alt](https://github.com/Lifailon/Selenium-Modules/blob/rsa/Images/gpt-example.gif)

## Text Translation

Translation text directly in the PowerShell console.

The module uses 2 providers to choose from:

- **[DeepL](https://www.deepl.com/translator)**
- **[Google](https://translate.google.fi)**

### 🚀 Install module

```PowerShell
Invoke-RestMethod https://raw.githubusercontent.com/Lifailon/Selenium-Modules/rsa/Modules/Get-Translation/Get-Translation.psm1 | Out-File -FilePath "$(New-Item -Path "$($($Env:PSModulePath -split ";")[0])\Get-Translation" -ItemType Directory -Force)\Get-Translation.psm1" -Force
```

### 🎉 Example

```PowerShell
PS C:\Users\lifailon> Get-Translation -Provider DeepL -Text "I translating the text"
Я перевожу текст

PS C:\Users\lifailon> Get-Translation -Provider DeepL -Text "Я перевожу текст"
I'm translating the text

PS C:\Users\lifailon> Get-Translation -Provider Google -Text "I translating the text"
Я переводил текст

PS C:\Users\lifailon> Get-Translation -Provider Google -Text "Я перевожу текст" -Language en
I am translating the text
```

![Image alt](https://github.com/Lifailon/Selenium-Modules/blob/rsa/Images/translation-example.jpg)

## Get-Translate

You can use the [Console-Trsanslate](https://github.com/Lifailon/Console-Translate) module to free translate text without dependencies using the API:

```PowerShell
Invoke-Expression(New-Object Net.WebClient).DownloadString("https://raw.githubusercontent.com/Lifailon/Console-Translate/rsa/Deploy-Console-Translate.ps1")
```

## Internet SpeedTest

The module uses 3 providers to choose from:

- **[LibreSpeed](https://librespeed.org)**
- **[OpenSpeedTest](https://openspeedtest.com)**
- **[Ookla](https://www.speedtest.net)**

📊 The module is debugged on **PowerShell Core** and can be used to collect metrics with output to InfluxDB. As an example, you can use other work **[Ookla-SpeedTest-API](https://github.com/Lifailon/Ookla-SpeedTest-API)**, which alternatively uses **InternetExplorer via COM Interface**.

### 🚀 Install module

```PowerShell
Invoke-RestMethod https://raw.githubusercontent.com/Lifailon/Selenium-Modules/rsa/Modules/Get-SpeedTest/Get-SpeedTest.psm1 | Out-File -FilePath "$(New-Item -Path "$($($Env:PSModulePath -split ";")[0])\Get-SpeedTest" -ItemType Directory -Force)\Get-SpeedTest.psm1" -Force
```

### 🎉 Example

```PowerShell
PS C:\Users\lifailon\Desktop> Get-SpeedTest -Provider Libre

Download Upload    Ping    Jitter
-------- ------    ----    ------
171 Mbps 28.0 Mbps 22.0 ms 1.40 ms

PS C:\Users\lifailon\Desktop> Get-SpeedTest -Provider Open 

Download : 254.68 Mbps
Upload   : 80.24 Mbps
Ping     : 5.6 ms
Jitter   : 0.30 ms
Carrier  : SEVEN-SKY
Server   : Stockholm
Result   : openspeedtest.com/results/63074923
Date     : Jan 9 2024 4:06 PM UTC

PS C:\Users\lifailon\Desktop> Get-SpeedTest -Provider Ookla

date               : 09.01.2024 19:08:23
id                 : 15729550610
connection_icon    : wireless
download           : 272707
upload             : 272986
latency            : 3
distance           : 0
country_code       : RU
server_id          : 53268
server_name        : Moscow
sponsor_name       : City-Telecom ZAO
sponsor_url        :
connection_mode    : multi
isp_name           : Seven Sky
isp_rating         : 3.5
test_rank          : 100
test_grade         : A+
test_rating        : 5
idle_latency       : 4
download_latency   : 50
upload_latency     : 14
additional_servers : {@{server_id=22121; server_name=Moscow; sponsor_name=MosLine Group LLC}, @{server_id=23499; server_name=Moscow; sponsor_name=Марьино.net},
                      @{server_id=11266; server_name=Moscow; sponsor_name=INETCOM LLC}}
path               : result/15729550610
hasSecondary       : True
```

![Image alt](https://github.com/Lifailon/Selenium-Modules/blob/rsa/Images/speedtest-example.jpg)