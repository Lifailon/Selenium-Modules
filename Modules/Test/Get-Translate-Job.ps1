function Get-Translate {
    param (
        [Parameter(Mandatory, ValueFromPipeline)][string]$Text,
        [ValidateSet("DeepL","Google")][string]$Provider = "DeepL"
    )
    $ScriptBlock = {
        param($Text, $Provider)
        $path = "$home\Documents\Selenium\"
        $ChromeDriver = "$path\ChromeDriver.exe"
        $WebDriver = "$path\WebDriver.dll"
        $SupportDriver = "$path\WebDriver.Support.dll"
        $Chromium = (Get-ChildItem $path -Recurse | Where-Object Name -like chrome.exe).FullName
        Add-Type -Path $WebDriver
        Add-Type -Path $SupportDriver
        $ChromeOptions = New-Object OpenQA.Selenium.Chrome.ChromeOptions
        $ChromeOptions.BinaryLocation = $Chromium
        $ChromeOptions.AddArgument("start-maximized")
        $ChromeOptions.AcceptInsecureCertificates = $True
        #$ChromeOptions.AddArgument("headless")
        $ChromeOptions.AddExcludedArgument("--enable-logging")
        $Selenium = New-Object OpenQA.Selenium.Chrome.ChromeDriver($ChromeDriver, $ChromeOptions)
        try {
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
        }
        finally {
            $Selenium.Close()
            $Selenium.Quit()
        }
    }
    $Job = Start-Job -ScriptBlock $ScriptBlock -ArgumentList $Text,$Provider
    $Result = Receive-Job -Job $Job -Wait
    Remove-Job -Job $job
    return $Result
}