function Get-Translation {
    <#
    .SYNOPSIS
    Module for text translation
    .DESCRIPTION
    Examples:
    Get-Translation -Provider DeepL -Text "I translating the text"
    Get-Translation -Provider Google -Text "I translating the text"
    .LINK
    https://github.com/Lifailon/Selenium-Modules
    https://deepl.com/translator
    https://translate.google.ci
    #>
    param (
        [Parameter(Mandatory,ValueFromPipeline)][string]$Text,
        [ValidateSet("DeepL","Google")][string]$Provider = "DeepL"
    )
    $path = "$home\Documents\Selenium\"
    $log = "$path\ChromeDriver.log"
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
    $ChromeDriverService = [OpenQA.Selenium.Chrome.ChromeDriverService]::CreateDefaultService($ChromeDriver)
    $ChromeDriverService.HideCommandPromptWindow = $True
    $ChromeDriverService.LogPath = $log
    $ChromeDriverService.EnableAppendLog = $False
    $ChromeDriverService.EnableVerboseLogging = $False
    $Selenium = New-Object OpenQA.Selenium.Chrome.ChromeDriver($ChromeDriverService, $ChromeOptions)
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