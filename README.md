# Selenium-Modules

**Free native API for ChatGPT, Translate and SpeedTest use Selenium 💚 via 💙 PowerShell**

## 🚀 Quick start

Install all dependencies using a single script **[Deploy-Selenium](https://github.com/Lifailon/Deploy-Selenium/blob/rsa/Deploy-Selenium-Drivers.ps1)**.

## Get-FreeGPT

🐥 The idea is that if you have no way to get an API key, you can use the 🙏 free web interface without authorization, to be able to implement the API interface for your scripts.

🔔 This is a test case as it has a binding to the **[ChatGPT](https://chat-gpt.org/chat)** provider (10 requests per day, you can find another provider).

### 🎉 Example

The example uses a query to add two numbers and translate the text:

![Image alt](https://github.com/Lifailon/Selenium-Modules/blob/rsa/Example/Get-FreeGPT.gif)

## Get-Translate

Use text translation directly from the PowerShell command line.

### 🎉 Example

![Image alt](https://github.com/Lifailon/Selenium-Modules/blob/rsa/Example/Get-Translate.gif)

The module uses 2 providers to choose from:

- **[DeepL](https://www.deepl.com/translator)**
- **[Google](https://translate.google.fi)**

```PowerShell
>> $Result1 = Get-Translate -Provider DeepL -Text "Hello, my friend"
>> $Result2 = Get-Translate -Provider Google -Text "Hello, my friend"
>> Write-Host $Result1 -ForegroundColor Green
>> Write-Host $Result2 -ForegroundColor Green
Starting ChromeDriver 114.0.5735.90 (386bc09e8f4f2e025eddae123f36f6263096ae49-refs/bron keepinanch-heads/5735@{#1052}) on port 9161
Only local connections are allowed.
...
Здравствуйте, мой друг
Здравствуй, друг      
```

## Get-SpeedTest

The module uses 3 providers to choose from:

- **[LibreSpeed](https://librespeed.org)**
- **[OpenSpeedTest](https://openspeedtest.com)**
- **[Ookla](https://www.speedtest.net)**

📊 The module is debugged on **PowerShell Core** and can be used to collect metrics with output to InfluxDB. As an example, you can use my other work **[Ookla-SpeedTest-API](https://github.com/Lifailon/Ookla-SpeedTest-API)**, which alternatively uses the COM Object InternetExplorer.

### 🎉 Example

```PowerShell
PS C:\Users\lifailon\Desktop> Get-SpeedTest -Provider Libre

Download Upload    Ping    Jitter
-------- ------    ----    ------
279 Mbps 78.3 Mbps 20.9 ms 6.02 ms

PS C:\Users\lifailon\Desktop> Get-SpeedTest -Provider Open 

Download : 308.51 Mbps
Upload   : 71.31 Mbps
Ping     : 5.1 ms
Jitter   : 0.30 ms
Carrier  : SEVEN-SKY
Server   : Stockholm
Result   : openspeedtest.com/results/61834590
Date     : Oct 19 2023 4:10 PM UTC

PS C:\Users\lifailon\Desktop> $Test = Get-SpeedTest -Provider Ookla
PS C:\Users\lifailon\Desktop> $Test | Out-Default

date               : 19.10.2023 19:11:27
id                 : 15398128880
connection_icon    : wireless
download           : 309219
upload             : 202992
latency            : 3
distance           : 0
country_code       : RU
server_id          : 15946
server_name        : Vidnoe
sponsor_name       : vidnoe.net
sponsor_url        : 
connection_mode    : multi
isp_name           : Seven Sky
isp_rating         : 3.5
test_rank          : 100
test_grade         : A+
test_rating        : 5
idle_latency       : 4
download_latency   : 17
upload_latency     : 15
additional_servers : {@{server_id=28482; server_name=Podolsk; sponsor_name=Toc 
                     hka Dostupa}, @{server_id=32229; server_name=Podolsk; spo 
                     nsor_name=P-T-K}, @{server_id=28280; server_name=Odintsov 
                     o; sponsor_name=AO TRC Odintsovo}}
path               : result/15398128880
hasSecondary       : True

PS C:\Users\lifailon\Desktop> $Test.additional_servers

server_id server_name sponsor_name
--------- ----------- ------------
    28482 Podolsk     Tochka Dostupa
    32229 Podolsk     P-T-K
    28280 Odintsovo   AO TRC Odintsovo
```
