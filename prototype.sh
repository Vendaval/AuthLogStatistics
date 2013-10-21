#!/bin/bash

logbasedir=~/data/logical
logdir="$logbasedir"/$(date +%F)

mkdir -p "$logdir"

tmpfile="/tmp/breakinattempts.txt"
rm $tmpfile

#logfile="$logdir/invalid_passwords.txt"
#zgrep -i -v "Failed password for invalid user" $logbasedir/auth.log* | grep -i "Failed password" > "$tmpfile"
#cat "$tmpfile" | cut -d " " -f 10 | sort | uniq | while read line ; do
#    echo -n "$line "; cat "$tmpfile" | grep "$line" | wc -l;
#done | sort -n -k 2 >"$logfile"
#rm $tmpfile
#echo "Created $logfile with the absolute frequency of break-in attempts with an existing user name but an invalid password."

echo "Interlude ..."

#logfile="$logdir/invalid_users.txt"
#zgrep -i "Failed password for invalid user" $logbasedir/auth.log* > "$tmpfile"
#cat "$tmpfile" | cut -d " " -f 11 | sort | uniq | while read line ; do
#    echo -n "$line "; cat "$tmpfile" | grep "$line" | wc -l;
#done | sort -n -k 2 >"$logfile"
#rm "$tmpfile"
#echo "Created $logfile with the absolute frequency of break-in attempts with a non-existing user name."

echo "Interlude ... 2"

#logfile="$logdir/ip_attempts.txt"
#zgrep -i "sshd" $logbasedir/auth.log*  | grep -i "authentication failure" | sed 's/^.*rhost=//' > "$tmpfile"
#cat "$tmpfile" | cut -d " " -f 1 | sort | uniq | while read line ; do
#    echo -n "$line "; cat "$tmpfile" | grep "$line" | wc -l;
#done | sort -n -k 2 >"$logfile"
#rm $tmpfile
#echo "Created $logfile with the absolute frequency of break-in attempts with an existing user name but an invalid password."

echo "Interlude ... 3"
logfile="$logdir/perCountry_attempts.txt"
zgrep -i "sshd" $logbasedir/auth.log*  | grep -i "authentication failure" | sed 's/^.*rhost=//' > "$tmpfile"
cat "$tmpfile" | cut -d " " -f 1 | sort | uniq | while read line ; do
    echo -n "$line "; cat "$tmpfile" | grep "$line" | wc -l;
done | sort -n -k 2 >"$logfile"
#rm $tmpfile
echo "Created $logfile with the absolute frequency of break-in attempts with an existing user name but an invalid password."
