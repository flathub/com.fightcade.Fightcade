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
mkdir -p ${DATADIR}/ROMs/flycast

# Emulator writable files & directories
# FBNeo
mkdir -p ${DATADIR}/config/fcadefbneo
cp -n /app/fightcade/Fightcade/emulator/fbneo/config/fcadefbneo.default.ini ${DATADIR}/config/fcadefbneo/fcadefbneo.ini
# Snes9x
mkdir -p ${DATADIR}/config/snes9x
mkdir -p ${DATADIR}/config/snes9x/Saves
cp -n /app/fightcade/Fightcade/emulator/snes9x/fcadesnes9x.default.conf ${DATADIR}/config/snes9x/fcadesnes9x.conf
echo "N" > ${DATADIR}/config/snes9x/Valid.Ext
touch ${DATADIR}/config/snes9x/stdout.txt
touch ${DATADIR}/config/snes9x/stderr.txt
# Flycast
mkdir -p ${DATADIR}/config/flycast
mkdir -p ${DATADIR}/config/flycast/mappings
touch ${DATADIR}/config/flycast/emu.cfg

# Boot Fightcade frontend
/app/bin/zypak-wrapper /app/fightcade/Fightcade/fc2-electron/fc2-electron
