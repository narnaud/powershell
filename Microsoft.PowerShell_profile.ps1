$HomeDir = "C:\nicolas"
(Get-PsProvider 'FileSystem').home = $HomeDir
Set-Location $HomeDir

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
}

$AliasHash = @{
	e     = 'ii .'                      # Open explorer in the current directory
	cc11  = 'clang++ -std=gnu++11'
	cc14  = 'clang++ -std=gnu++14'
	cc17  = 'clang++ -std=gnu++1z'
	n     = 'start "C:\Program Files\Notepad++\notepad++.exe"'
	qtc   = 'C:\Qt\Tools\QtCreator\bin\qtcreator.exe -client'
	sh    = 'C:\Users\nicolas\scoop\apps\git-with-openssh\current\bin\sh.exe'
	bash  = 'C:\Users\nicolas\scoop\apps\git-with-openssh\current\bin\bash.exe'
	tools = 'start "C:\Program Files\\Notepad++\notepad++.exe" $ToolsFile'
	hash  = 'Get-FileHash'
}
Import-Module posh-alias
$AliasHash.GetEnumerator() | ForEach-Object{ Add-Alias $_.key $_.value }

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
