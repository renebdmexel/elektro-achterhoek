# Eenvoudige lokale webserver voor de website.
# Gebruik:  powershell -ExecutionPolicy Bypass -File serve.ps1
# Open daarna http://localhost:8080 in de browser. Stoppen met Ctrl+C.
param([int]$Port = 8080)

$root = $PSScriptRoot
$types = @{
  ".html" = "text/html; charset=utf-8"; ".css" = "text/css; charset=utf-8"
  ".js" = "application/javascript; charset=utf-8"; ".svg" = "image/svg+xml"
  ".jpg" = "image/jpeg"; ".jpeg" = "image/jpeg"; ".png" = "image/png"
  ".webp" = "image/webp"; ".ico" = "image/x-icon"
}

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$Port/")
$listener.Start()
Write-Host "Website draait op http://localhost:$Port  (Ctrl+C om te stoppen)"

try {
  while ($listener.IsListening) {
    $ctx = $listener.GetContext()
    $path = [Uri]::UnescapeDataString($ctx.Request.Url.AbsolutePath.TrimStart("/"))
    if ($path -eq "" -or $path.EndsWith("/")) { $path += "index.html" }
    $file = [IO.Path]::GetFullPath((Join-Path $root $path))

    if ($file.StartsWith($root) -and (Test-Path $file -PathType Leaf)) {
      $bytes = [IO.File]::ReadAllBytes($file)
      $ext = [IO.Path]::GetExtension($file).ToLower()
      $ctx.Response.ContentType = if ($types[$ext]) { $types[$ext] } else { "application/octet-stream" }
      $ctx.Response.StatusCode = 200
    } else {
      $bytes = [Text.Encoding]::UTF8.GetBytes("404 - Niet gevonden")
      $ctx.Response.StatusCode = 404
    }
    $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
    $ctx.Response.Close()
    Write-Host "$($ctx.Response.StatusCode)  /$path"
  }
} finally {
  $listener.Stop()
}
