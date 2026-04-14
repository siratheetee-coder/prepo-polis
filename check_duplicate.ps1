$lines = [System.IO.File]::ReadAllLines('index.html', [System.Text.Encoding]::UTF8)
for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($lines[$i] -match 'dev-skip-container') {
        $preview = $lines[$i].Substring(0, [Math]::Min(80, $lines[$i].Length))
        Write-Host "Line $($i+1): $preview"
    }
}
