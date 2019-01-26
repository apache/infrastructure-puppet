#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Need to specify a project name as an arg: exiting."
exit 1;
fi

MOINDATA="/usr/local/etc/moin-to-cwiki/universal-wiki-converter/projects"
PROJECT=$1

echo "Syncing up data for the $1 project..."
sleep 1

cd $MOINDATA

  rsync -av --progress --password-file=/root/.pw-moin \
    --include data/pages         \
    --include data/user         \
    --exclude data/event-log \
    --exclude data/edit-log \
    --exclude data/intermap.txt \
    --exclude /\*\*/cache  \
    --exclude .svn \
    --exclude data/meta \
    --exclude data/plugin \
    rsync://apb-moin@moin-vm/moin/$PROJECT $MOINDATA

