**💛 Free native API for ChatGPT, Translate and SpeedTest use Selenium via PowerShell**

## 🚀 Quick start

Install all dependencies using a single script **[Deploy-Selenium](https://github.com/Lifailon/Deploy-Selenium/blob/rsa/Deploy-Selenium-Drivers.ps1)**.

Run the **[Get-GPT](https://github.com/Lifailon/Get-GPT/blob/rsa/Get-GPT.psm1) module** and pass your question to the **Text parameter**.

## Get-GPT

🐥 The idea is that if you have no way to get an API key, you can use the 🙏 free web interface without authorization, to be able to implement the API interface for your scripts.

🔔 This is a test case as it has a binding to the ChatGPT vendor (10 requests per day, you can find another vendor).

### 🎉 Example

![Image alt](https://github.com/Lifailon/Get-GPT/blob/rsa/Example.gif)

## Get-Translate

### 🎉 Example

## Get-SpeedTest

The module uses 3 different providers to choose from.

### 🎉 Example

```PowerShell
PS C:\Users\lifailon\Desktop> Get-SpeedTest -Provider Libre

Download Upload    Ping    Jitter
-------- ------    ----    ------
274 Mbps 80.2 Mbps 22.2 ms 2.90 ms

PS C:\Users\lifailon\Desktop> Get-SpeedTest -Provider Open 

Download : 313.16 Mbps
Upload   : 60.45 Mbps
Ping     : 4.7 ms
Jitter   : 0.60 ms
Carrier  : SEVEN-SKY
Server   : Stockholm
Result   : openspeedtest.com/results/61830155
Date     : Oct 19 2023 11:39 AM UTC

PS C:\Users\lifailon\Desktop> Get-SpeedTest -Provider Ookla

date               : 19.10.2023 14:40:37
id                 : 15396980690
connection_icon    : wireless
download           : 304368
upload             : 355236
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
idle_latency       : 3
download_latency   : 9
upload_latency     : 10
additional_servers : {@{server_id=25680; server_name=Troitsk; sponsor_name=MosLine Group LLC}, @{server_id=28280; server_name=Odintsovo; sponsor_name=AO T 
                     RC Odintsovo}, @{server_id=7328; server_name=Podolsk; sponsor_name=Quartz Telecom}}
path               : result/15396980690
hasSecondary       : True
```
