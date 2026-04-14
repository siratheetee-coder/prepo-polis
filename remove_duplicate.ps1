param()

$file = Join-Path $PSScriptRoot 'index.html'
$lines = [System.IO.File]::ReadAllLines($file, [System.Text.Encoding]::UTF8)

# Find all line indices with dev-skip-container
$hits = @()
for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($lines[$i] -match 'dev-skip-container') {
        $hits += $i
    }
}

Write-Host "Found $($hits.Count) hit(s) at line(s): $($hits -join ', ')"

if ($hits.Count -le 1) {
    Write-Host 'Nothing to remove.'
    exit 0
}

# First hit line index (0-based)
$firstHit = $hits[0]

# Walk backwards to find the DEV SKIP NAV comment start
$blockStart = $firstHit
while ($blockStart -gt 0 -and $lines[$blockStart] -notmatch 'DEV SKIP NAV') {
    $blockStart--
}
# Step back one more if the opening separator comment is the line before
if ($blockStart -gt 0 -and $lines[$blockStart - 1] -match '====') {
    $blockStart--
}

Write-Host "Block starts at line $($blockStart + 1)"

# Walk forward from firstHit to find END DEV SKIP NAV comment end
$blockEnd = $firstHit
while ($blockEnd -lt $lines.Count - 1 -and $lines[$blockEnd] -notmatch 'END DEV SKIP NAV') {
    $blockEnd++
}
# Move past the closing separator too
while ($blockEnd -lt $lines.Count - 1 -and $lines[$blockEnd] -match '(END DEV SKIP|====)') {
    $blockEnd++
}

Write-Host "Block ends at line $($blockEnd + 1)"

# Remove lines from blockStart to blockEnd (inclusive)
$newLines = [System.Collections.Generic.List[string]]::new()
for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($i -lt $blockStart -or $i -gt $blockEnd) {
        $newLines.Add($lines[$i])
    }
}

[System.IO.File]::WriteAllLines($file, $newLines, [System.Text.Encoding]::UTF8)
Write-Host "Done: removed lines $($blockStart+1) to $($blockEnd+1)."
