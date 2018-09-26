function CompleteStack {
  param($commandName, $parameterName, $wordToComplete, $commandAst, $boundParameters)

  $stack = if (
    $commandName -and
    $commandName -match 'Redo' -or
    (
      $aliased = (Get-Alias $commandName -ea Ignore).ResolvedCommandName -and
      $aliased -match 'Redo'
    )
  ) {Get-Stack -Redo}
  else {Get-Stack -Undo}

  if (-not $stack) { return }

  filter Completions {
    @{
      short = $_;
      long  = $_;
      index = [array]::IndexOf($stack, $_) + 1
    }
  }

  @($stack) -match ($wordToComplete | RemoveSurroundingQuotes | RemoveTrailingSeparator | Escape) |
    Completions |
    IndexedComplete
}