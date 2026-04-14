$file = Join-Path $PSScriptRoot 'index.html'
$content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

$devSkip = @"

  <!-- ============================================================ -->
  <!-- DEV SKIP NAV - REMOVE BEFORE PRODUCTION RELEASE             -->
  <!-- ============================================================ -->
  <div id="dev-skip-container" style="
    position: fixed;
    bottom: 16px;
    left: 50%;
    transform: translateX(-50%);
    z-index: 99999;
    display: flex;
    align-items: center;
    gap: 6px;
    background: rgba(20, 20, 30, 0.92);
    border: 2px solid #ff4444;
    border-radius: 999px;
    padding: 6px 14px;
    box-shadow: 0 4px 20px rgba(255, 68, 68, 0.4);
    font-family: monospace;
    font-size: 12px;
    color: #ff4444;
    letter-spacing: 0.05em;
  ">
    <span style="font-weight:bold; margin-right:4px;">DEV SKIP:</span>
    <button id="dev-skip-0" onclick="showSlide(0)" title="Slide 0: Splash/Lobby" style="background:#ff4444;color:#fff;border:none;border-radius:999px;padding:4px 11px;font-family:monospace;font-weight:bold;font-size:12px;cursor:pointer;">S0</button>
    <button id="dev-skip-1" onclick="showSlide(1)" title="Slide 1: Name Entry" style="background:#ff4444;color:#fff;border:none;border-radius:999px;padding:4px 11px;font-family:monospace;font-weight:bold;font-size:12px;cursor:pointer;">S1</button>
    <button id="dev-skip-2" onclick="showSlide(2)" title="Slide 2: Mode Select" style="background:#ff4444;color:#fff;border:none;border-radius:999px;padding:4px 11px;font-family:monospace;font-weight:bold;font-size:12px;cursor:pointer;">S2</button>
    <button id="dev-skip-3" onclick="showSlide(3)" title="Slide 3: Character Select" style="background:#ff4444;color:#fff;border:none;border-radius:999px;padding:4px 11px;font-family:monospace;font-weight:bold;font-size:12px;cursor:pointer;">S3</button>
    <button id="dev-skip-4" onclick="showSlide(4)" title="Slide 4: Instructions" style="background:#ff4444;color:#fff;border:none;border-radius:999px;padding:4px 11px;font-family:monospace;font-weight:bold;font-size:12px;cursor:pointer;">S4</button>
    <button id="dev-skip-5" onclick="showSlide(5)" title="Slide 5: Game" style="background:#ff4444;color:#fff;border:none;border-radius:999px;padding:4px 11px;font-family:monospace;font-weight:bold;font-size:12px;cursor:pointer;">S5</button>
    <button id="dev-skip-6" onclick="showSlide(6)" title="Slide 6: Results/End" style="background:#ff4444;color:#fff;border:none;border-radius:999px;padding:4px 11px;font-family:monospace;font-weight:bold;font-size:12px;cursor:pointer;">S6</button>
    <span style="margin-left:4px;opacity:0.6;font-size:10px;">remove before release</span>
  </div>
  <!-- ============================================================ -->
  <!-- END DEV SKIP NAV                                             -->
  <!-- ============================================================ -->

"@

$newContent = $content.Replace('</body>', $devSkip + '</body>')

if ($newContent -eq $content) {
    Write-Host 'ERROR: </body> tag not found. No changes made.'
    exit 1
} else {
    [System.IO.File]::WriteAllText($file, $newContent, [System.Text.Encoding]::UTF8)
    Write-Host 'SUCCESS: Dev skip nav injected before </body>.'
}
