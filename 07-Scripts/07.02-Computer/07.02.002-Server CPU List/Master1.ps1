Import-Module ActiveDirectory
$pingConfig = @{
    "count" = 1
    "bufferSize" = 15
    "delay" = 1
    "EA" = 0 }
$computer = $cn = $null
#$cred = Get-Credential
 Get-ADComputer -Filter {OperatingSystem -Like "Windows Server*"}  |
 ForEach-Object {
                 if(Test-Connection -ComputerName $_.dnshostname @pingconfig)
                   { $computer += $_.dnshostname + "`r`n"} }
$computer = $computer -split "`r`n"
$property = "systemname","maxclockspeed","addressWidth",
            "numberOfCores", "NumberOfLogicalProcessors"
$Liste=foreach($cn in $computer)
{
 if($cn -match $env:COMPUTERNAME)
   {
   Get-WmiObject -class win32_processor -Property  $property |
   Select-Object -Property $property }
 elseif($cn.Length -gt 0)
  {
   Get-WmiObject -class win32_processor -Property $property -cn $cn  |
   Select-Object -Property $property } } 
   
$Liste | Export-Csv -Path "C:\_Scripts\Server CPU List\CPUListe.csv"