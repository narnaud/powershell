if (Test-Path Function:\TabExpansion) {
    Rename-Item Function:\TabExpansion TabExpansionBackup
}

function TabExpansion($line, $lastWord) {
	$expression = [regex]::split($line, '[|;]')[-1].trimstart()

	if($expression -match "^$(Get-AliasPattern use) (?<fragment>.*)") {
		$tools = Get-Member -InputObject $Global:PsEnvConfig -MemberType NoteProperty |
			ForEach-Object -MemberName 'Name'
		
		return $tools | ForEach-Object {	
			if($_.StartsWith($Matches['fragment'])) {
				#this will output the auto filled key to the screen.
				$_
			}
		}
	}
	else {
		if (Test-Path Function:\TabExpansionBackup) {
			TabExpansionBackup $line $lastWord
		}
	}
}
