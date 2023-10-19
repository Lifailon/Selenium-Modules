# Source: https://github.com/Lifailon/Selenium-OpenAPI
# ©2023 Lifailon
function Get-SpeedTest {
param (
    [ValidateSet("Ookla","Open","Libre")][string]$Provider = "Ookla"
)
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
$Selenium = New-Object OpenQA.Selenium.Chrome.ChromeDriver($ChromeDriver, $ChromeOptions)
if ($Provider -eq "Ookla") {
    $Url = "https://www.speedtest.net/"
    $Selenium.Navigate().GoToUrl($Url)
    Start-Sleep 1
    $UrlTemp = $Selenium.Url
    $span = $Selenium.FindElements([OpenQA.Selenium.By]::TagName("span"))
    $Button = $span | Where-Object Text -Match "GO"
    $Button.Click()
    while ($True) {
        if ($Selenium.Url -ne $UrlTemp) {
            $UrlResult = $Selenium.Url
            break
        }
    }
    ### Parsing Web Content (JSON)
    $Cont = Invoke-RestMethod $UrlResult
    $Data = ($Cont -split "window.OOKLA.")[3] -replace "(.+ = )|(;)" | ConvertFrom-Json
    ### Convert Unix Time
    $EpochTime = [DateTime]"1/1/1970"
    $TimeZone = Get-TimeZone
    $UTCTime = $EpochTime.AddSeconds($Data.result.date)
    $Data.result.date = $UTCTime.AddMinutes($TimeZone.BaseUtcOffset.TotalMinutes)
    return $Data.result
}
if ($Provider -eq "Open") {
    $Url = "https://openspeedtest.com/"
    $Selenium.Navigate().GoToUrl($Url)
    Start-Sleep 1
    $UrlTemp = $Selenium.Url
    $Button = $Selenium.FindElements([OpenQA.Selenium.By]::CssSelector("#OpenSpeedtest"))
    $Button.Click()
    while ($True) {
        if ($Selenium.Url -ne $UrlTemp) {
            $UrlResult = $Selenium.Url
            break
        }
    }
    ### Parsing Web Content (HTML)
    $Cont = Invoke-RestMethod $UrlResult
    $Cont = $Cont -replace '.+<text id="downResult"','<text id="downResult"'
    $Cont = $Cont -replace '</text> </symbol><symbol.+','</text>'
    $cont = $cont -split "</text>"
    $down       = $cont[0] -replace '.+class="rtextnum">'
    $downType   = $cont[1] -replace '.+class="rtextmbms">'
    $up         = $cont[2] -replace '.+class="rtextnum">'
    $upType     = $cont[3] -replace '.+class="rtextmbms">'
    $ping       = $cont[4] -replace '.+class="rtextnum">'
    $pingType   = $cont[5] -replace '.+class="rtextmbms">'
    $jitter     = $cont[6] -replace '.+class="rtextnum">'
    $jitterType = $cont[7] -replace '.+class="rtextmbms">'
    $carrier    = $cont[8] -replace '.+<tspan x=0>|</tspan>'
    $server     = $cont[9] -replace '.+<tspan x=0>|</tspan>.+'
    $ResultLink = $cont[9] -replace '.+class="rtextnum">'
    $date       = $cont[10] -replace '.+class="rtextnum">'
    $Collections = New-Object System.Collections.Generic.List[System.Object]
    $Collections.Add([PSCustomObject]@{
        Download = "$down $downType";
        Upload   = "$up $upType";
        Ping     = "$ping $pingType";
        Jitter   = "$jitter $jitterType";
        Carrier  = $carrier;
        Server   = $server;
        Result   = $ResultLink;
        Date     = $date
    })
    return $Collections
}
if ($Provider -eq "Libre") {
    $Url = "https://librespeed.org/"
    $Selenium.Navigate().GoToUrl($Url)
    Start-Sleep 1
    while ($True) {
        $Button = $Selenium.FindElements([OpenQA.Selenium.By]::CssSelector("#startStopBtn"))
        if ($Button.ComputedAccessibleRole -eq "generic") {
            break
        }
    }
    $Button.Click()
    while ($true) {
        if ($Selenium.FindElements([OpenQA.Selenium.By]::CssSelector("#shareArea")).Text.Length -gt 1) {
            $Temp = "$path\temp.txt"
            $Selenium.PageSource > $Temp
            $cont = Get-Content $Temp
            break
        }
    }
    $ping   = ($cont | Select-String 'id="pingText"' -Raw) -replace "</div>" -replace ".+>"
    $jitter = ($cont | Select-String 'id="jitText"' -Raw) -replace "</div>" -replace ".+>"
    $down   = ($cont | Select-String 'id="dlText"' -Raw) -replace "</div>" -replace ".+>"
    $up     = ($cont | Select-String 'id="ulText"' -Raw) -replace "</div>" -replace ".+>"
    $Collections = New-Object System.Collections.Generic.List[System.Object]
    $Collections.Add([PSCustomObject]@{
        Download = "$down Mbps";
        Upload   = "$up Mbps";
        Ping     = "$ping ms";
        Jitter   = "$jitter ms";
    })
    return $Collections
}
$Selenium.Close()
$Selenium.Quit()
}

# Example:
# Get-SpeedTest -Provider Ookla
# Get-SpeedTest -Provider Open
# Get-SpeedTest -Provider Libre