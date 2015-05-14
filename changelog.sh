#!/bin/bash

# To run this, simply cd to the Broken folder and run:

# . build/changelog.sh :) *After syncing the repo.*

_now=$(date +"%m-%d-%Y")
_file=build/BrokenChangelog/$_now/Broken-Changelog-$_now.txt

mkdir -p build/BrokenChangelog/

mkdir -p build/BrokenChangelog/$_now

chmod 777 -R build/BrokenChangelog

repo forall -pc git log --oneline --reverse --no-merges --since=14.day.ago >  $_file
