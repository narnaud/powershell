$HomeDir = "C:\nicolas"
(get-psprovider 'FileSystem').Home = $HomeDir
$ToolsFile = (Join-Path $Env:USERPROFILE ".tools.json")

$cde = @{
	NOARG_CD = $HomeDir
	AUTO_CD = $false
}
$AliasHash = @{
	e     = 'ii .'                      # Open explorer in the current directory
	cc11  = 'clang++ -std=gnu++11'
	cc14  = 'clang++ -std=gnu++14'
	cc17  = 'clang++ -std=gnu++17'
	cc20  = 'clang++ -std=gnu++20'
	n     = 'start "C:\Program Files\Notepad++\notepad++.exe"'
	qtc   = 'C:\Qt\Tools\QtCreator\bin\qtcreator.exe -client'
	tools = 'code $ToolsFile'
	hash  = 'Get-FileHash'
	l     = 'git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --date=relative'
	s     = 'git status'
	d     = 'git diff'
	xhost = 'sudo code C:\Windows\System32\Drivers\etc\hosts'
}

if ($PSVersionTable.PSVersion.Major -lt 7) {
	# Set-PSReadlineKeyHandler -Key Tab -Function Complete # Unix completion
	Set-PSReadlineOption -BellStyle None # Remove the bell

	# Make sure to replace && with ; when copying git commands
	Set-PSReadlineKeyHandler -Chord Ctrl+v `
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

	Set-PSReadLineKeyHandler -Key f `
							 -BriefDescription rmrfHandling `
							 -LongDescription "Transform unix 'rm -rf' into powershel 'rm -r -fo'" `
							 -ScriptBlock {
		$line = $null
		$cursor = $null
		[Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

		if ($line -eq "rm -r") {
			[Microsoft.PowerShell.PSConsoleReadLine]::Replace(0, 5, "rm -r -fo")
		} else {
			[Microsoft.PowerShell.PSConsoleReadLine]::Insert("f")
		}
	}
}

Import-Module cd-extras

Import-Module posh-git
Start-Service ssh-agent

Import-Module posh-alias
$AliasHash.GetEnumerator() | ForEach-Object{ Add-Alias $_.key $_.value }

Import-Module Get-ChildItemColor
Set-Alias ll Get-ChildItemColorFormatWide -option AllScope

Import-Module ps-env
Set-PsEnvConfig $ToolsFile

Import-Module oh-my-posh
Set-PoshPrompt -Theme  (Join-Path (Split-Path $MyInvocation.MyCommand.Path -Parent) "theme.json")
function Set-EnvVar {
    $env:PS_ENV_TOOL_NAME=$Global:PsEnvToolName
}
New-Alias -Name 'Set-PoshContext' -Value 'Set-EnvVar' -Scope Global -Force

