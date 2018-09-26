<#
.SYNOPSIS
Attempts to expand a given candidate path by appending a wildcard character (*)
to the end of each path segment.

.PARAMETER Candidate
Candidate search string.

.PARAMETER SearchPaths
Set of paths to search in addition to the current directory. $cde.CD_PATH by default.

.PARAMETER File
Limits search results to leaf items.

.PARAMETER Directory
Limits search results to container items.

.EXAMPLE
PS> Expand-Path /win/sys/dr/et -Directory

    Directory: C:\Windows\System32\drivers


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----       21/12/2017  11:50 PM                etc
#>
function Expand-Path {

  [CmdletBinding()]
  param (
    [string] $Candidate,
    [array]  $SearchPaths = $cde.CD_PATH,
    [switch] $File,
    [switch] $Directory
  )

  $multidot = [regex]::Match($Candidate, '^\.{3,}')
  $match = $multidot.Value
  $replacement = ('../' * [Math]::Max(0, $match.LastIndexOf('.'))) -replace '.$'

  [string]$wildcardedPath = $Candidate `
    -replace $match, $replacement `
    -replace '(\w/|\w\\|\w$)', '$0*' `
    -replace '(/\*|\\\*)', ('*' + ${/}) `
    -replace '(/$|\\$)', '$0*' `
    -replace '(\.\w|\w\.$)', '*$0'

  if ($SearchPaths -and -not ($Candidate | IsRootedOrRelative)) {
    # always include the local path, regardeless of whether it was passed
    # in the searchPaths parameter (this differs from the behaviour in bash)
    $wildcardedPaths = @($wildcardedPath) + (
      $SearchPaths | % { Join-Path $_ $wildcardedPath })
  }
  else { $wildcardedPaths = $wildcardedPath }

  WriteLog "`nExpanding $Candidate to: $wildcardedPaths"
  Get-Item $wildcardedPaths -Force -ErrorAction Ignore |
    Where {(!$File -or !$_.PSIsContainer) -and (!$Directory -or $_.PSIsContainer)}
}