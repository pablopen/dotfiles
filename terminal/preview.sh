#!/bin/bash
#
# Opens a Terminal window per profile, each showing its name and fastfetch,
# four per screen with the rest stacked behind (⌘W reveals the next one).
#
#   terminal/preview.sh                       every profile in this folder
#   terminal/preview.sh "OkSolar Dark" Nightfox   only these
#
set -euo pipefail

cd "$(dirname "$0")"

if [[ $# -gt 0 ]]; then
  names=("$@")
else
  names=()
  for f in *.terminal; do names+=("${f%.terminal}"); done
fi

for n in "${names[@]}"; do
  [[ -f "$n.terminal" ]] || { echo "no such profile: $n" >&2; exit 1; }
done

osascript - "${names[@]}" <<'EOF'
on run argv
  tell application "Finder" to set {x0, y0, x1, y1} to bounds of window of desktop
  set slotW to (x1 - x0) div 2
  set slotH to (y1 - y0 - 25) div 2
  tell application "Terminal"
    activate
    -- open in reverse so the first names end up in front
    repeat with i from (count of argv) to 1 by -1
      set n to item i of argv
      set t to do script "clear; echo '==> " & n & "'; fastfetch"
      set current settings of t to settings set n
      set number of columns of t to 100
      set number of rows of t to 36
      set c to (i - 1) mod 2
      set r to ((i - 1) div 2) mod 2
      set position of front window to {x0 + c * slotW, y0 + 25 + r * slotH}
    end repeat
  end tell
end run
EOF
