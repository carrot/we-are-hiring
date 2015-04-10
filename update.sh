#!/bin/bash
TIME_PREFIX="Last Updated:"
TIMESTAMP_FORMAT="%m-%d-%Y %I:%M %p"
FILE_TO_UPDATE="README.md"
GIT_BRANCH="master"
COMMIT_MESSAGE="Still Hiring!"

###################################
# Returns the current time in
# human readable format
###################################
function current_time() {
    epoch=$(date +%s)
    readable=$(date -d @$epoch +"$TIMESTAMP_FORMAT")
    echo $readable
}

###################################
# Replaces the last line of text
# in a file with $2
#
# @param $1: The file to update
# @param $2: The new line of text
###################################
function update_last_line() {
    file="$1"
    new_line="$2"
    head -n -1 "$file" > temp.txt ; mv temp.txt "$file"
    echo "$new_line" >> "$file"
}

###################################
# Updates this repo on git and
# pushes to master
###################################
function git_update() {
    git add .
    git commit -m "$COMMIT_MESSAGE"
    git push origin "$GIT_BRANCH"
}

###################################
# The main function that is
# executed when the script starts
###################################
function main() {
    new_line="$TIME_PREFIX $(current_time)"
    update_last_line "$FILE_TO_UPDATE" "$new_line"
    git_update
}

main
