@{
	ModuleVersion = '1.0'
	Author = 'Kierr Dugan - Updated by Nicolas Arnaud-Cormos'
	Description = 'A simple PowerShell module that allows specific tools to be added to the current environment by updating environment variables from a JSON file'
	Copyright  =  'MIT'

	ModuleToProcess = 'ps-env.psm1'
	
	# Functions to export from this module
	FunctionsToExport = @(
		'Set-PsEnvConfig',
		'Use-Tool',
		'TabExpansion',
		'use'
	)
}
