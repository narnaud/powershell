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

function Start-NewWindow([String]$Path)
{
    <#
    .SYNOPSIS
        Start a new powershell window in a sepecif directory
    .DESCRIPTION
        The Start-NewWindow creates a new powershell window, starting in the directory pass as parameter.
    #>
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

# Posh-Git
Import-Module posh-git
Start-SshAgent -Quiet

# Ps-Env
Import-Module ps-env
Set-PsEnvConfig "C:\nicolas\Config\tools\tools.json"

# Cd-extra
Import-Module cd-extras
