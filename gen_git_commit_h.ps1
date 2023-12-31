﻿$commit = try { git rev-parse HEAD } catch { "unknown" }
try { git diff-index --quiet HEAD } catch {}
$dirty = if ($LASTEXITCODE) { "true" } else { "false" }
echo "#pragma once`r`n#define GIT_COMMIT `"$commit`"`r`n#define GIT_DIRTY $dirty" | out-file -encoding ASCII auto/git_info.h.new
if (-not (Test-Path .\auto\git_info.h) -or (Compare-Object $(Get-Content .\auto\git_info.h.new) $(Get-Content .\auto\git_info.h))) {
  mv -Force auto/git_info.h.new auto/git_info.h
} else {
  rm auto/git_info.h.new
}
