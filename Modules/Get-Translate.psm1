# Source: https://github.com/Lifailon/Selenium-OpenAPI
# ©2023 Lifailon
function Get-Translate {
param (
    [Parameter(Mandatory,ValueFromPipeline)][string]$Text,
    $Url = "https://deepl.com/translator"
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
$Selenium.Navigate().GoToUrl($Url)
Start-Sleep 1
$div = $Selenium.FindElements([OpenQA.Selenium.By]::TagName("div"))
$InTextBox = $div | Where-Object ComputedAccessibleRole -Match "TextBox" | Where-Object ComputedAccessibleLabel -Match "Исходный текст"
$OutTextBox = $div | Where-Object ComputedAccessibleRole -Match "TextBox" | Where-Object ComputedAccessibleLabel -Match "Переведенный текст"
$OutTemp = $OutTextBox.Text
$InTextBox.SendKeys($text)
while ($True) {
    if ($OutTextBox.Text -ne $OutTemp) {
        return $OutTextBox.Text 
        break
    }
}
}
finally {
$Selenium.Close()
$Selenium.Quit()
}
}

# Example:
# $Result = Get-Translate -Text "Hello, my friend"
# Write-Host $Result -ForegroundColor Green
