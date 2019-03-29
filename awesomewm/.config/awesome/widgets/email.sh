#!/bin/sh

gmaildir=~/.mails/gmail/INBOX
count=0
offlineimap_bin=/usr/bin/offlineimap
log_file=/tmp/grab_email.log

if [ "$1" == "get" ] ; then
  if [ -x $offlineimap_bin ] ; then
    $offlineimap_bin 2>/dev/null
    if [ $? -ne 0 ] ; then
      echo "$(date) - failed to get email" >> $log_file
      exit 1
    fi
  else
    echo "$(date) - $offlineimap_bin no found" >> $log_file
    exit 1
  fi

  if [ -d $gmaildir ] ; then
    echo $(ls $gmaildir/new | wc -l)
  else
    echo "$(date) - Directory $gmaildir no found..." >> $log_file
    exit 1
  fi
elif [ "$1" == "show" ] ; then
  echo "$(grep -i "^from" $gmaildir/new/* | awk '{print $2,$3}' | sort -u)"
fi
