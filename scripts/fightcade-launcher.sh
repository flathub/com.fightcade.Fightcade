#!/bin/sh

DATADIR=/var/data

# Tell the user that the wine prefix may take some time to create.
# On first boot it can seem like the application is silently hanging since
# on slower systems creating the wine prefix can take upwards of 2
# minutes (tested on a 2-core Silverblue VM)
echo "Creating or updating wine prefix (~/.wine64), this may take a minute..."

# Silently create/update Wine prefix
WINEPREFIX=~/.wine64 WINEDEBUG=-all DISPLAY=:invalid wineboot -u

# Log file Fightcade expects to be able to write to
mkdir -p /var/data/logs
touch ${DATADIR}/logs/fcade-errors.log
touch ${DATADIR}/logs/fcade.log
touch ${DATADIR}/logs/fcade.log.1
touch ${DATADIR}/logs/fcade.log.2
touch ${DATADIR}/logs/fcade.log.3

# Create persistent ROM folders if they don't exist
mkdir -p ${DATADIR}/ROMs/fbneo
mkdir -p ${DATADIR}/ROMs/ggpofba
mkdir -p ${DATADIR}/ROMs/snes9x

# Emulator config directory
mkdir -p ${DATADIR}/config/fcadefbneo
cp -n /app/fightcade/Fightcade/emulator/fbneo/config/fcadefbneo.default.ini ${DATADIR}/config/fcadefbneo/fcadefbneo.ini

# Boot Fightcade frontend
/app/bin/zypak-wrapper /app/fightcade/Fightcade/fc2-electron/fc2-electron
