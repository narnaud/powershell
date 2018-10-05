param([switch]$NoVersionWarn)

if (Get-Module posh-git) { return }

$psv = $PSVersionTable.PSVersion

if ($psv.Major -lt 3 -and !$NoVersionWarn) {
    Write-Warning ("posh-git support for PowerShell 2.0 is deprecated; you have version $($psv).`n" +
    "To download version 5.0, please visit https://www.microsoft.com/en-us/download/details.aspx?id=50395`n" +
    "For more information and to discuss this, please visit https://github.com/dahlbyk/posh-git/issues/163`n" +
    "To suppress this warning, change your profile to include 'Import-Module posh-git -Args `$true'.")
}

& $PSScriptRoot\CheckVersion.ps1 > $null

. $PSScriptRoot\Utils.ps1
. $PSScriptRoot\GitUtils.ps1
. $PSScriptRoot\GitParamTabExpansion.ps1
. $PSScriptRoot\GitTabExpansion.ps1
. $PSScriptRoot\TortoiseGit.ps1

if (!$Env:HOME) { $Env:HOME = "$Env:HOMEDRIVE$Env:HOMEPATH" }
if (!$Env:HOME) { $Env:HOME = "$Env:USERPROFILE" }

Get-TempEnv 'SSH_AGENT_PID'
Get-TempEnv 'SSH_AUTH_SOCK'


$exportModuleMemberParams = @{
    Alias = @('??') # TODO: Remove in 1.0.0
    Function = @(
        'Invoke-NullCoalescing',
        'Add-PoshGitToProfile',
        'Write-GitStatus',
        'Write-VcsStatus',
        'Get-GitBranch',
        'Get-GitStatus',
        'Enable-GitColors',
        'Get-GitDirectory',
        'TabExpansion',
        'Expand-GitCommand',
        'Get-AliasPattern',
        'Get-SshAgent',
        'Start-SshAgent',
        'Stop-SshAgent',
        'Add-SshKey',
        'Get-SshPath',
        'Update-AllBranches',
        'tgit'
    )
}

Export-ModuleMember @exportModuleMemberParams
