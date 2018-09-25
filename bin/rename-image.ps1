Get-ChildItem *.JPG | foreach { jhead -autorot -n%Y-%m-%d_%H%M%S $_.FullName }
Get-ChildItem *.jpg | foreach { jhead -autorot -n%Y-%m-%d_%H%M%S $_.FullName }
Get-ChildItem *.mov | Rename-Item -newname {$_.LastWriteTime.toString("yyyy-MM-dd_HHmmss") + ".mov"}
Get-ChildItem *.mp4 | Rename-Item -newname {$_.LastWriteTime.toString("yyyy-MM-dd_HHmmss") + ".mp4"}
