function Get-GPT {
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
Start-Sleep 2
$textarea = $Selenium.FindElements([OpenQA.Selenium.By]::TagName("textarea"))
$textarea.SendKeys($text)
$button = $Selenium.FindElements([OpenQA.Selenium.By]::TagName("button"))
$Enter = $button | Where-Object ComputedAccessibleLabel -Match "Отправить"
$Enter.Click()
Start-Sleep 5
$Output = $Selenium.FindElements([OpenQA.Selenium.By]::CssSelector("#root > div > div.flex.h-full.flex-1.flex-col.md\:pl-\[260px\] > main > div > div > div > div > div.flex.flex-col.items-center.text-sm.dark\:bg-gray-800.w-full > div:nth-child(3) > div > div.w-\[calc\(100\%-50px\)\] > div > div.markdown.prose.w-full.break-words.dark\:prose-invert.dark > p"))
return $Output.Text
$Selenium.Close()
$Selenium.Quit()
}

#$Result = Get-GPT -Text "22+33"
#$Eng = "I was translated into Russian"
#$Result = Get-GPT -Text "Переведи текст на русский язык: $Eng"
#Write-Host $Result -ForegroundColor Green