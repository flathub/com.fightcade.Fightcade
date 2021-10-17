#!/bin/sh

WINEERROR=$(cat <<-END
<i>/app/wine/bin/wine</i> is missing.

<b>com.fightcade.Fightcade.Wine</b> is required to run FinalBurn and Snes9x games
END
)

WINEPATH="/app/wine/bin/wine"
export WINEPREFIX=~/.wine64

if [[ -f $(WINEPATH) ]]; then
	/app/wine/bin/wine "$@"
else
	zenity \
	  --warning \
	  --title "Flatpak extension required" \
	  --text "${WINEERROR}"
fi
