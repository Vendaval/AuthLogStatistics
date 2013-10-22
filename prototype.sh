#!/bin/bash

#
# *  Copyright 2013 Alberto Rodriguez Sanchez (A.K.A Vendaval)
# *  ars AT correo DOT azc DOT uam DOT mx 
# *
# *  This file is part of AuthLogStatistics. 
# *  AuthLogStatistics is free software: you can redistribute it and/or modify
# *  it under the terms of the GNU General Public License as published by
# *  the Free Software Foundation, either version 3 of the License, or
# *  (at your option) any later version.
# *
# *  Foobar is distributed in the hope that it will be useful, 
# *  but WITHOUT ANY WARRANTY; without even the implied warranty of 
# *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# *  GNU General Public License for more details.
# *
# *  You should have received a copy of the GNU General Public License
# *  along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
# *


logbasedir=~/data/logical
logdir="$logbasedir"/$(date +%F)

mkdir -p "$logdir"

tmpfile="/tmp/breakinattempts.txt"

logfile="$logdir/invalid_passwords.txt"
zgrep -i -v "Failed password for invalid user" $logbasedir/auth.log* | grep -i "Failed password" | sed 's/^.*for //' > "$tmpfile"
cat "$tmpfile" | cut -d " " -f 1 | sort | uniq | while read line ; do
    echo -n "$line "; cat "$tmpfile" | grep "$line" | wc -l;
done | sort -n -k 2 >"$logfile"
rm $tmpfile
echo "Created $logfile with the absolute frequency of break-in attempts with an existing user name but an invalid password."

echo "Wait...for...it"

logfile="$logdir/invalid_users.txt"
zgrep -i "Failed password for invalid user" $logbasedir/auth.log* | sed 's/^.*user //' > "$tmpfile"
cat "$tmpfile" | cut -d " " -f 1 | sort | uniq | while read line ; do
    echo -n "$line "; cat "$tmpfile" | grep "$line" | wc -l;
done | sort -n -k 2 >"$logfile"
rm "$tmpfile"
echo "Created $logfile with the absolute frequency of break-in attempts with a non-existing user name."

echo "Interlude"

logfile="$logdir/ip_attempts.txt"
zgrep -i "sshd" $logbasedir/auth.log*  | grep -i "authentication failure" | sed 's/^.*rhost=//' > "$tmpfile"
cat "$tmpfile" | cut -d " " -f 1 | sort | uniq | while read line ; do
    echo -n "$line "; cat "$tmpfile" | grep "$line" | wc -l;
done | sort -n -k 2 >"$logfile"
rm $tmpfile
echo "Created $logfile with the absolute frequency of break-in attempts from ip address."

#echo "Interlude ... 3"
#logfile="$logdir/perCountry_attempts.txt"
#zgrep -i "sshd" $logbasedir/auth.log*  | grep -i "authentication failure" | sed 's/^.*rhost=//' > "$tmpfile"
#cat "$tmpfile" | cut -d " " -f 1 | sort | uniq | while read line ; do
#    echo -n "$line "; cat "$tmpfile" | grep "$line" | wc -l;
#done | sort -n -k 2 >"$logfile"
#rm $tmpfile
#echo "Created $logfile with the absolute frequency of break-in attempts with an existing user name but an invalid password."
