#!/bin/sh

WINEERROR=$(cat <<-END
<i>/app/bin/wine</i> is missing.

<b>org.winehq.Wine</b> is required to run FinalBurn and Snes9x games
END
)

WINEPATH="/app/bin/wine"
export WINEPREFIX=~/.wine64

if [[ -f ${WINEPATH} ]]; then
	/app/bin/wine "$@"
else
	zenity \
	  --warning \
	  --title "Flatpak extension required" \
	  --text "${WINEERROR}"
fi
