#!/bin/sh

PARAM=${1+"$@"}

export WINEDEBUG=-all

echo "======" >> /var/data/fcade.log
echo ${PARAM} >> /var/data/fcade_output
echo "======" >> /var/data/fcade_output

# split 'fcade://play/ssfxj2' into an array split by '/'
IFS='/' read -r -a fcadecmd <<< "$PARAM"

# If we're doing a checkrom we call frm manually, otherwise
# we forward to fcasde.
if [ ${fcadecmd[2]} = "checkrom" ]; then
    # Use script to log so that joining multiple channels doesn't cause the logs to clash with each other.
    script -a -c "/app/fightcade/Fightcade/emulator/frm ${fcadecmd[3]} ${fcadecmd[4]}" /var/data/frm.log
else
    /app/fightcade/Fightcade/emulator/fcade ${PARAM} 2>&1 &
fi
