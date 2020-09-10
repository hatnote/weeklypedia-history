#!/bin/bash

function log_and_die { logger $1; exit 1; }

DATE_STR="$(date '+%l:%M%P  %B %e, %Y')"

cd /home/hatnote/weeklypedia/static
git pull
if [ "$(git status -s)" ]
  then
    git add .
    git commit -a -m "autocommit $DATE_STR" || log_and_die "WPH: Failed to commit ($DATE_STR)"
    COMMIT_ID="$(git rev-parse HEAD)"
    git push origin master || log_and_die "WPH: Failed to push ($DATE_STR)"
    logger "WPH: Successfully committed/pushed '$COMMIT_ID' ($DATE_STR)."
  else
    logger "WPH: No tracked/trackable files updated. ($DATE_STR)"
fi
