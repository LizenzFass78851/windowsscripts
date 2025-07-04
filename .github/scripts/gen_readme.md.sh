#!/bin/bash
set -e # Beende das Skript bei einem Fehler

# Voreinstellungen
#SUCHVERZEICHNIS=
PATCHTHEFILE=README.md

LINKS=/tmp/$PATCHTHEFILE.txt

# Hole die Links
if [ -e "$LINKS" ]; then
  rm "$LINKS"
fi

find ./ -name '*' -type d -maxdepth 1 \
  | sed 's#^./##g' \
  | sed 's# #%20#g' \
  | sed -e '1d' \
  | grep -v '.git' \
  | sort >> $LINKS


# Lösche die Datei
rm $PATCHTHEFILE


# Erstelle die Datei
# Schicht 1
cat <<EOF | tee $PATCHTHEFILE
# Windows Scripts


Contains scripts and files for retrofitting certain functions under windows

## Overview of the scripts and tools:
EOF

# Die Links
while read line; do
    echo "- [$(echo $line | sed 's#%20# #g')](./$line)" >> $PATCHTHEFILE
done < $LINKS
