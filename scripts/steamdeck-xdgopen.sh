#!/bin/bash
# Shim script for xdg-open.
# Required by Steam Deck Gaming mode, since xdg-open in gaming mode does not
# recognize Flatpak URI associations (for fcade:// URLs.)

# If executing an fcade:// URL, pass directly to fcade-quark
if [[ "$1" == fcade://* ]]; then
  /app/bin/fcade-quark "$@"
  exit 0
fi

# If executing an http:// or https:// URL, open with min-browser
# Should be gated by SteamDeck=1 and XDG_CURRENT_DESKTOP=gamescope
# or XDG_SESSION_DESKTOP=gamescope
if [[ "$1" =~ ^(http|https):// ]]; then
  /app/bin/min-browser "$@"
  exit 0
fi

# Fallback to xdg-open if we don't catch any of the above cases.
/usr/bin/xdg-open "$@"
