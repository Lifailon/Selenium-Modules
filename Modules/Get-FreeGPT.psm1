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
$SupportDriver = "$path\WebDriver.Support.dll"
$Chromium = (Get-ChildItem $path -Recurse | Where-Object Name -like chrome.exe).FullName
Add-Type -Path $WebDriver
Add-Type -Path $SupportDriver
try {
$ChromeOptions = New-Object OpenQA.Selenium.Chrome.ChromeOptions
$ChromeOptions.BinaryLocation = $Chromium
$ChromeOptions.AddArgument("start-maximized")
$ChromeOptions.AcceptInsecureCertificates = $True
$ChromeOptions.AddArgument("headless")
$Selenium = New-Object OpenQA.Selenium.Chrome.ChromeDriver($ChromeDriver, $ChromeOptions)
$Selenium.Navigate().GoToUrl("$Url")
Start-Sleep 1
$Limit = $Selenium.FindElements([OpenQA.Selenium.By]::ClassName("quota-wrapper")).Text
Write-Host "Limit: $Limit" -ForegroundColor Green
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
}
finally {
$Selenium.Close()
$Selenium.Quit()
}
}

# Example 1:
# $Result = Get-FreeGPT -Text "22+33"
# Write-Host $Result -ForegroundColor Green
# Example 2:
# $Eng = "Hello, my friend"
# $Result = Get-FreeGPT -Text "Translate the text into Russian: $Eng"
# Write-Host $Result -ForegroundColor Green
