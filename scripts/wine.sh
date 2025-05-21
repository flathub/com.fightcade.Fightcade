#!/bin/sh

WINEERROR=$(cat <<-END
<i>/app/bin/wine</i> is missing.

Please report this as a bug on Github.
END
)

WINEPATH="/app/bin/wine"
. /app/bin/get-wine-prefix

if [[ -f ${WINEPATH} ]]; then
	/app/bin/wine "$@"
else
	zenity \
	  --warning \
	  --title "Flatpak extension required" \
	  --text "${WINEERROR}"
fi
