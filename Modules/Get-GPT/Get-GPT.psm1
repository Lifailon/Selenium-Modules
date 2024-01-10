function Get-GPT {
    <#
    .SYNOPSIS
    Module for free communication with chat GTP without using API
    .DESCRIPTION
    Examples:
    Get-GPT "Исполняй роль калькулятора. Посчитай сумму чисел: 22+33"
    Get-GPT "Исполняй роль интерпретатора PowerShell. Выведи результат команды: Write-Host $(22+33)"
    Get-GPT "Исполняй роль переводчика. Переведи текст на русский язык: Hi! How can I help you?"
    Get-GPT "Напиши код на языке PowerShell, который позволяет получить прогноз погоды"
    .LINK
    https://github.com/Lifailon/Selenium-Modules
    https://chatg.io
    #>
    param (
        [Parameter(Mandatory,ValueFromPipeline)][string]$Text
    )
    $url = "https://chatg.io/chat"
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

        $Selenium.Navigate().GoToUrl("$url")
        $Search = $Selenium.FindElements([OpenQA.Selenium.By]::TagName('textarea')) | Where-Object ComputedAccessibleRole -eq textbox
        $Search.SendKeys("$Text")
        $Search.SendKeys([OpenQA.Selenium.Keys]::Enter)
        while ($true) {
            if ($($Selenium.FindElements([OpenQA.Selenium.By]::TagName('button')).Text) -eq "Clear") {
                $Result = $Selenium.FindElements([OpenQA.Selenium.By]::TagName('span'))
                return $($Result[-2].Text)
                break
            }
        }
    }
    finally {
        $Selenium.Close()
        $Selenium.Quit()
    }
}