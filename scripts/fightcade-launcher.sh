#!/bin/sh

DATADIR=/var/data

# Tell the user that the wine prefix may take some time to create.
# On first boot it can seem like the application is silently hanging since
# on slower systems creating the wine prefix can take upwards of 2
# minutes (tested on a 2-core Fedora Silverblue VM)
echo "Creating or updating wine prefix (/var/data/winepfx), this may take a minute..."

# Silently create/update Wine prefix
WINEPREFIX=/var/data/winepfx WINEDEBUG=-all DISPLAY=:invalid wineboot -u

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
cp -n /app/fightcade/Fightcade/emulator/fbneo/config/fcadefbneo.default.ini ${DATADIR}/config/fcadefbneo/fcadefbneo.ini 2> /dev/null
# FBNeo training mode
mkdir -p ${DATADIR}/fbneo-training-mode-configs
for game in /app/fightcade/Fightcade/emulator/fbneo/fbneo-training-mode/games/*
do
  touch ${DATADIR}/fbneo-training-mode-configs/${game##*/}.lua
done
# FBNeo saved overlays
mkdir -p ${DATADIR}/config/fcadefbneo/fightcade
# Snes9x
mkdir -p ${DATADIR}/config/snes9x
mkdir -p ${DATADIR}/config/snes9x/Saves
cp -n /app/fightcade/Fightcade/emulator/snes9x/fcadesnes9x.default.conf ${DATADIR}/config/snes9x/fcadesnes9x.conf 2> /dev/null
touch ${DATADIR}/config/snes9x/stdout.txt
touch ${DATADIR}/config/snes9x/stderr.txt
# Snes9x: Valid.Ext needs a specific value inside or it will cause a crash at runtime.
echo "N" > ${DATADIR}/config/snes9x/Valid.Ext
# Flycast
mkdir -p ${DATADIR}/config/flycast
touch ${DATADIR}/config/flycast/emu.cfg
mkdir -p ${DATADIR}/config/flycast/mappings
mkdir -p ${DATADIR}/config/flycast/data
touch ${DATADIR}/logs/flycast.log
# Flycast: copy back in the save states the emulator ships with. If newer ones are available
# they will be automatically downloaded at runtime.
cp -R /app/fightcade/Fightcade/emulator/flycast/data_orig/* ${DATADIR}/config/flycast/data

# Boot Fightcade frontend
/app/bin/zypak-wrapper /app/fightcade/Fightcade/fc2-electron/fc2-electron
