#User variables
$ToolsFile = "C:\nicolas\Config\tools\tools.json"
$HomeDir = "C:\nicolas"
$AliasHash = @{
	e     = 'ii .'                      # Open explorer in the current directory
	s     = 'Start-NewWindow $pwd.Path' # Start a new powershell window
	cc11  = 'clang++ -std=gnu++11'
	cc14  = 'clang++ -std=gnu++14'
	cc17  = 'clang++ -std=gnu++1z'
	n     = 'start "C:\\Program Files\\Notepad++\\notepad++.exe"'
	qtc   = 'C:\\Qt\\Tools\\QtCreator\\bin\\qtcreator.exe -client'
	sh    = 'C:\\Users\\nicolas\\scoop\\apps\\git-with-openssh\\current\\bin\\sh.exe'
	bash  = 'C:\\Users\\nicolas\\scoop\\apps\\git-with-openssh\\current\\bin\\bash.exe'
	tools = 'start "C:\\Program Files\\Notepad++\\notepad++.exe" $ToolsFile'
}

# PSReadline customization
# Set-PSReadlineKeyHandler -Key Tab -Function Complete # Unix completion
Set-PSReadlineOption -BellStyle None # Remove the bell

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
Set-Location $HomeDir

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
$AliasHash.GetEnumerator() | ForEach-Object{ Add-Alias $_.key $_.value }

# Ps-Env
Import-Module ps-env
Set-PsEnvConfig $ToolsFile

# Posh-Git
Import-Module posh-git
Start-SshAgent -Quiet

# Cd-extra
Import-Module cd-extras

# Change the ~ location - $env:HOME is still C:\Users\nicolas
# Usefull for cd without arguments
(Get-PsProvider 'FileSystem').home = 'C:\nicolas'

# Prompt improvement
# Rewrite the path so it displays only 2 items, and '~' if it's the Filesystem hom (may be different from $home)
function Get-EnhancedPromptPath {
	#$HomeDir = (Get-PsProvider 'FileSystem').home
	if($pwd -like $HomeDir) { return '~' }

	$currentPath = split-path $pwd -leaf
	$parent_pwd = split-path $pwd -parent
	if($currentPath -imatch '[a-z]:\\') { return '\' }

	if($parent_pwd) {
		if($parent_pwd -like $HomeDir)
		{
			$parent = '~'
		} else {
			$parent = split-path $parent_pwd -leaf
		}

		if( $parent -imatch '[a-z]:\\') {
			$currentPath = "\$currentPath"
		} else {
			$currentPath = "$parent\$currentPath"
		}
	}

	return $currentPath
}
$GitPromptSettings.DefaultPromptPath = ''
function prompt {
    # Your non-prompt logic here
    $prompt = Write-Prompt $(Get-PsEnvToolName) -ForegroundColor ([ConsoleColor]::Magenta)
    $prompt = Write-Prompt $(Get-EnhancedPromptPath) -ForegroundColor ([ConsoleColor]::Gray)
    $prompt += & $GitPromptScriptBlock
    if ($prompt) { "$prompt " } else { " " }
}