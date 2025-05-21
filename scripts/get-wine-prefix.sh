#!/bin/sh

PREFIX_DIR=/var/data/wineprefixes

# Create our wineprefix subdirectory if it doesn't exist
mkdir -p ${PREFIX_DIR}

WINE_VERSION=$(/app/bin/wine --version)
export WINEPREFIX=${PREFIX_DIR}/${WINE_VERSION}
