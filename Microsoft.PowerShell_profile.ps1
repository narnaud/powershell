$HomeDir = "C:\nicolas"

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

$AliasHash = @{
	e     = 'ii .'                      # Open explorer in the current directory
	cc11  = 'clang++ -std=gnu++11'
	cc14  = 'clang++ -std=gnu++14'
	cc17  = 'clang++ -std=gnu++1z'
	n     = 'start "C:\Program Files\Notepad++\notepad++.exe"'
	qtc   = 'C:\Qt\Tools\QtCreator\bin\qtcreator.exe -client'
	sh    = 'C:\Users\nicolas\scoop\apps\git\current\bin\sh.exe'
	bash  = 'C:\Users\nicolas\scoop\apps\git\current\bin\bash.exe'
	tools = 'code $ToolsFile'
	hash  = 'Get-FileHash'
	l     = 'git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --date=relative'
	s     = 'git status'
	d     = 'git diff'
	xhost = 'sudo code C:\Windows\System32\Drivers\etc\hosts'
}
Import-Module posh-alias
$AliasHash.GetEnumerator() | ForEach-Object{ Add-Alias $_.key $_.value }

$cde = @{
	NOARG_CD = $HomeDir
	CD_PATH = "$HomeDir\dev"
}
Import-Module cd-extras

Import-Module PSColor
$global:PSColor.File.Code.Pattern = '\.(java|c|cpp|cs|js|css|html|ui|h|hpp)$'

Import-Module posh-git

Import-Module oh-my-posh
Set-Theme MyTheme

$ToolsFile = "C:\nicolas\Config\tools\tools.json"
Import-Module ps-env
Set-PsEnvConfig $ToolsFile

Start-Service ssh-agent

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
