#!/bin/bash

logbasedir=~/
logdir="$logbasedir"/$(date +%F)

mkdir -p "$logdir"

tmpfile="/tmp/breakinattempts.txt"

logfile="$logdir/invalid_passwords.txt"
zgrep -i -v "Failed password for invalid user" /var/log/auth.log.* | grep -i "Failed password" >"$tmpfile"
cat "$tmpfile" | cut -d " " -f 10 | sort | uniq | while read line ; do
    echo -n "$line "; cat "$tmpfile" | grep "$line" | wc -l;
done | sort -n -k 2 >"$logfile"
rm "$tmpfile"
echo "Created $logfile with the absolute frequency of break-in attempts with an existing user name but an invalid password."


logfile="$logdir/invalid_users.txt"
zgrep -i "Failed password for invalid user" /var/log/auth.log.* >"$tmpfile"
cat "$tmpfile" | cut -d " " -f 11 | sort | uniq | while read line ; do
    echo -n "$line "; cat "$tmpfile" | grep "$line" | wc -l;
done | sort -n -k 2 >"$logfile"
rm "$tmpfile"
echo "Created $logfile with the absolute frequency of break-in attempts with a non-existing user name."
