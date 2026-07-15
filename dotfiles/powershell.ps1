Set-Alias vim nvim
Set-PSReadLineOption -PredictionSource None

Remove-Item Alias:ls
function ls {
    param (
        [string]$Path = "."
    )
    $items = Get-ChildItem -Path $Path | Sort-Object Name
    if (-not $items) { return }
    $maxWidth = $Host.UI.RawUI.WindowSize.Width
    $maxLength = ($items | ForEach-Object { $_.Name.Length }) | Measure-Object -Maximum | Select-Object -ExpandProperty Maximum
    $colWidth = $maxLength + 2
    $columns = [math]::Max(1, [math]::Floor($maxWidth / $colWidth))
    $rows = [math]::Ceiling($items.Count / $columns)
    for ($row = 0; $row -lt $rows; $row++) {
        for ($col = 0; $col -lt $columns; $col++) {
            $idx = $col * $rows + $row
            if ($idx -ge $items.Count) {
                $name = "{0,-$colWidth}" -f ""
                Write-Host $name -NoNewLine
            } else {
                $item = $items[$idx]
                $name = "{0,-$colWidth}" -f $item.Name
                if ($item.PSIsContainer) {
                    Write-Host $name -ForegroundColor DarkCyan -NoNewline
                } else {
                    Write-Host $name -ForegroundColor Gray -NoNewline
                }
            }
        }
        Write-Host
    }
    if ($columnCount -gt 0) {
        Write-Host
    }
}

function Get-GitRoot {
    $gitRoot = git rev-parse --show-toplevel 2>$null
    if ($gitRoot) {
        return $gitRoot.Replace("/","\")
    } else {
        return ""
    }
}

function Folder-Name{
    param ($path)
    if ($path.Length -eq 0) {
        return ""
    }
    $parts = $path -split '\\'
	return $parts[-1]
}

function Shorten-Path {
    param ($path)
    $root = Get-GitRoot
    $folder = Folder-Name ($root)
    if ($root.Length -gt 0) {
        $path = "$path".Replace("$root", "$folder")
    }
    return $path
}

function Prompt {
    $p = $executionContext.SessionState.Path.CurrentLocation
    $osc7 = ""
    if ($p.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $p.ProviderPath -Replace "\\", "/"
        $osc7 = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}${ansi_escape}\"
    }
    $cwd = (Get-Location)
    $git = Write-VcsStatus
    if ($git.Length -gt 0) {
        $gitpath = Shorten-Path $cwd
		$git = $git.Substring(1)
        Write-Host "$git " -NoNewline
        Write-Host "$gitpath/`n".Replace("\", "/") -ForegroundColor DarkGreen -NoNewline
    } else {
        Write-Host "$cwd/`n".Replace("\", "/") -ForegroundColor DarkGreen -NoNewline
    }
	Write-Host ">>>" -ForegroundColor DarkMagenta -NoNewline
    return "${osc7} "
}
