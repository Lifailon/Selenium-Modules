# Source: https://github.com/Lifailon/Selenium-OpenAPI
# ©2023 Lifailon
function Get-Translate {
param (
    [Parameter(Mandatory,ValueFromPipeline)][string]$Text,
    [ValidateSet("DeepL","Google")][string]$Provider = "DeepL"
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
if ($Provider -eq "DeepL") {
    $Url = "https://deepl.com/translator"
    $Selenium.Navigate().GoToUrl($Url)
    Start-Sleep 1
    $div = $Selenium.FindElements([OpenQA.Selenium.By]::TagName("div"))
    $InTextBox = $div | Where-Object ComputedAccessibleRole -Match "TextBox" | Where-Object ComputedAccessibleLabel -Match "Исходный текст"
    $OutTextBox = $div | Where-Object ComputedAccessibleRole -Match "TextBox" | Where-Object ComputedAccessibleLabel -Match "Переведенный текст"
    $OutTemp = $OutTextBox.Text
    $InTextBox.SendKeys($Text)
    while ($True) {
        if ($OutTextBox.Text -ne $OutTemp) {
            return $OutTextBox.Text 
            break
        }
    }
}
elseif ($Provider -eq "Google") {
    $Url = "https://translate.google.ci/?hl=ru" # select to ru via url
    $Selenium.Navigate().GoToUrl($Url)
    Start-Sleep 1
    $in = $Selenium.FindElements([OpenQA.Selenium.By]::ClassName("er8xn"))
    $in.SendKeys($Text)
    while ($True) {
        $out = $Selenium.FindElements([OpenQA.Selenium.By]::ClassName("ryNqvb"))
        if ($out) {
            return $out.Text
            break
        }
    }
}
}
finally {
$Selenium.Close()
$Selenium.Quit()
}
}

# Example:
# $Result1 = Get-Translate -Provider DeepL -Text "Hello, my friend"
# $Result2 = Get-Translate -Provider Google -Text "Hello, my friend"
# Write-Host $Result1 -ForegroundColor Green
# Write-Host $Result2 -ForegroundColor Green
