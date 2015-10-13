#!/bin/bash

# To run this, simply cd to the Broken folder and run:

# . build/dailychangelog.sh :) *After syncing the repo.*

_now=$(date +"%m-%d-%Y")
_file=changelog/BrokenChangelog/$_now/Broken-Changelog-$_now.txt

mkdir -p changelog/BrokenChangelog/

mkdir -p changelog/BrokenChangelog/$_now

chmod 777 -R changelog/BrokenChangelog

repo forall -pc git log --oneline --reverse --no-merges --since=1.day.ago >  $_file
