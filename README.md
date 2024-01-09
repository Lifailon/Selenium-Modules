# Selenium-Modules

![Image alt](https://github.com/Lifailon/Selenium-Modules/blob/rsa/Images/logo.jpg)

Modules in base **Selenium 💚 via 💙 PowerShell** for free use (without API) Chat GPT, Text Translation and Internet SpeedTest.

## 🚀 Quick start

To install or update all dependencies (browser Chromium and drivers), use the command for [deployment](https://github.com/Lifailon/Deploy-Selenium):

```PowerShell
Invoke-Expression(New-Object Net.WebClient).DownloadString("https://raw.githubusercontent.com/Lifailon/Deploy-Selenium/rsa/Deploy-Selenium-Drivers.ps1")
```

## Chat-GPT

🐥 The idea is that if you can't get an API key, you can use a third-party 🙏 **[free Chat-GPT web interface](https://chatg.io)** that doesn't require authorization to be able to implement the interface for your scripts or just chat with the bot in the PowerShell console.

### 🚀 Install module

To install the module in the default PowerShell modules directory, run the command in your console:

```PowerShell
Invoke-RestMethod https://raw.githubusercontent.com/Lifailon/Selenium-Modules/rsa/Modules/Get-GPT/Get-GPT.psm1 | Out-File -FilePath "$(New-Item -Path "$($($Env:PSModulePath -split ";")[0])\Get-GPT" -ItemType Directory -Force)\Get-GPT.psm1" -Force
```

### 🎉 Example

```PowerShell
PS C:\Users\lifailon> Import-Module Get-GPT

PS C:\Users\lifailon> Get-GPT "Исполняй роль калькулятора. Посчитай сумму чисел: 22+33"
Конечно, я могу сделать это для вас! Сумма чисел 22 и 33 равна 55. Было бы здорово, если бы я мог помочь вам с еще большими вычислениями. Чем еще я могу вам помочь?

PS C:\Users\lifailon> Get-GPT "Исполняй роль интерпретатора PowerShell. Выведи результат команды: Write-Host $(22+33)"
Конечно! Вот результат выполнения команды Write-Host 55:
55

PS C:\Users\lifailon> Get-GPT "Исполняй роль переводчика. Переведи текст на русский язык: Hi! How can I help you?"
Привет! Как я могу помочь вам?
```

![Image alt](https://github.com/Lifailon/Selenium-Modules/blob/rsa/Images/gpt-example.gif)

## Translation

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

PS C:\Users\lifailon> Get-Translation -Provider Google -Text "I translating the text"
Я переводил текст
```

![Image alt](https://github.com/Lifailon/Selenium-Modules/blob/rsa/Images/gpt-and-translation-example.jpg)

## SpeedTest

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