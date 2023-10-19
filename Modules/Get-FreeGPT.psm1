# Source: https://github.com/Lifailon/Selenium-OpenAPI
# ©2023 Lifailon
function Get-FreeGPT {
param (
    $Text,
    $Url = "https://chat-gpt.org/chat"
)
$path = "$home\Documents\Selenium\"
$ChromeDriver = "$path\ChromeDriver.exe"
$WebDriver = "$path\WebDriver.dll"
$Chromium = (Get-ChildItem $path -Recurse | Where-Object Name -like chrome.exe).FullName
Add-Type -Path $WebDriver
$ChromeOptions = New-Object OpenQA.Selenium.Chrome.ChromeOptions
$ChromeOptions.BinaryLocation = $Chromium
$ChromeOptions.AddArgument("start-maximized")
$ChromeOptions.AcceptInsecureCertificates = $True
$ChromeOptions.AddArgument("headless")
$Selenium = New-Object OpenQA.Selenium.Chrome.ChromeDriver($ChromeDriver, $ChromeOptions)
$Selenium.Navigate().GoToUrl("$Url") > $null
Start-Sleep 1
$textarea = $Selenium.FindElements([OpenQA.Selenium.By]::TagName("textarea"))
$textarea.SendKeys($text)
$button = $Selenium.FindElements([OpenQA.Selenium.By]::TagName("button"))
$OutputTemp = $Selenium.FindElements([OpenQA.Selenium.By]::TagName("p"))[-1].Text
$Enter = $button | Where-Object ComputedAccessibleLabel -Match "Отправить"
$Enter.Click()
while ($True) {
    $Output = $Selenium.FindElements([OpenQA.Selenium.By]::TagName("p"))[-1].Text
    if (($Output -ne $OutputTemp) -and ($Output -ne $Text) -and ($Output -ne "Печатает ...")) {
        return $Output
        break
    }
}
$Selenium.Close()
$Selenium.Quit()
}

$Result = Get-FreeGPT -Text "22+33"
$Eng = "Hello, my friend"
$Result = Get-FreeGPT -Text "Translate the text into Russian: $Eng"
Write-Host $Result -ForegroundColor Green
