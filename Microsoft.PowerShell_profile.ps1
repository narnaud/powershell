# Add personal scripts path
$env:Path += ";" + $PSScriptRoot + "\bin"

# PSReadline customization
# Set-PSReadlineKeyHandler -Key Tab -Function Complete # Unix completion
Set-PSReadlineOption -BellStyle None # Reove the bell

# Make sure to replace && with ; when copying git commands
Set-PSReadlineKeyHandler -Key Ctrl+V `
                         -BriefDescription SpecialGerritCopy `
                         -LongDescription "Replace && with ; in git specific command line" `
                         -ScriptBlock {
    $text = Get-Clipboard

    if ($text -ne $null) {
        # check if it's a git command
        if ($text -like "git*") {
            [Microsoft.PowerShell.PSConsoleReadLine]::Insert($text.replace("&&", ";"))
        } else {
            [Microsoft.PowerShell.PSConsoleReadLine]::Insert($text)
        }
    }
}

#Set-Location "~"
Set-Location C:\nicolas

# Chocolatey profile
#$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
#if (Test-Path($ChocolateyProfile)) {
#  Import-Module "$ChocolateyProfile"
#}

# Start a new powershell window in a specific directory
function Start-NewWindow([String]$Path)
{
    $cline = "`"/c start powershell.exe -noexit -c `"Set-Location '{0}'" -f $Path
    cmd $cline
}

# Posh-Alias module
Import-Module posh-alias
Add-Alias e 'ii .'
Add-Alias s 'Start-NewWindow $pwd.Path'
Add-Alias cc11 'clang++ -std=gnu++11'
Add-Alias cc14 'clang++ -std=gnu++14'
Add-Alias cc17 'clang++ -std=gnu++1z'
Add-Alias n 'start "C:\\Program Files\\Notepad++\\notepad++.exe"'
Add-Alias qtc 'C:\\Qt\\Tools\\QtCreator\\bin\\qtcreator.exe -client'
Add-Alias sh 'C:\\Users\\nicolas\\scoop\\apps\\git-with-openssh\\current\\bin\\sh.exe'
Add-Alias bash 'C:\\Users\\nicolas\\scoop\\apps\\git-with-openssh\\current\\bin\\bash.exe'

# Ps-Env
Import-Module ps-env
Set-PsEnvConfig "C:\nicolas\Config\tools\tools.json"

# Posh-Git
Import-Module posh-git
Start-SshAgent -Quiet

# Cd-extra
Import-Module cd-extras

# Change the ~ location - $env:HOME is still C:\Users\nicolas
# Usefull for cd without arguments
(Get-PsProvider 'FileSystem').home = 'C:\nicolas'

# Prompt improvement
# $GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
$GitPromptSettings.DefaultPromptPrefix = '$(Get-PsEnvToolName)'