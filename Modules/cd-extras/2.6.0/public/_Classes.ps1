class IndexedPath {
  [byte] $n
  [string] $Name
  [string] $Path
}

class CdeOptions {
  [array] $CD_PATH = @()
  [bool] $AUTO_CD = $true
  [bool] $CDABLE_VARS = $false
  [string] $NOARG_CD = '~'
  [UInt16] $MaxCompletions = 99
  [UInt16] $MaxMenuLength = 60
  [array] $DirCompletions = @('Set-Location', 'Set-LocationEx', 'Push-Location')
  [array] $PathCompletions = @('Get-ChildItem', 'Get-Item', 'Invoke-Item', 'Expand-Path')
  [array] $FileCompletions = @()
  [bool] $ColorCompletion = $false
  [bool] $IndexedCompletion = $null -ne (Get-Module PSReadLine) -and (
    Get-PSReadLineKeyHandler -Bound | ? Function -eq MenuComplete
  )
}
