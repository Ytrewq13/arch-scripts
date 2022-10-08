#!/bin/sh

#set -xe

# Check we are root
[ "$(id -u)" -eq 0 ] || {
    echo "Error: must be run as root" 1>&2
    exit 1
}

# Replaces every occurrence of $regexp in $path with $line, or places $line
# after every occurrence of $insertafter, or places $line at the top of the
# file, in that order (whichever matches first)
lineinfile() {
    # TODO: should we only replace the first occurrence?
    path="$1"
    regexp="$2"
    line="$3"
    insertafter="$4"

    SED_OPTS="-i"

    [ -f "$path" ] || return

    # Scenario 1: We find the regex - replace the matching line
    if [ -n "$regexp" ] && grep -qE "$regexp" "$path"; then
        sed $SED_OPTS "/$regexp/c $line" "$path"
    # Scenario 2: We find the line "insertafter" - append after the matching
    # line
    elif [ -n "$insertafter" ] && grep -qE "$insertafter" "$path"; then
        sed $SED_OPTS "/$insertafter/a $line" "$path"
    # Schenario 3: Can't find either regex or insertafter line - put the line
    # at the top of the file
    else
        sed $SED_OPTS "1i $line" "$path"
    fi
}

# /etc/pacman.conf - Package manager global configuration
#
# [options]
# ...
# Color                                 (Colorise output)
# ILoveCandy                            (Pacman animations for progress bars)
# ParallelDownloads = 5                 (5 simultaneous downloads)
# #TODO (bottom of the file):
# [custom]
# SigLevel = Optional TrustAll
# Server = file:///custom/repository/archive.tgz
#
lineinfile /etc/pacman.conf "ParallelDownloads" "ParallelDownloads = 5" "[options]"
lineinfile /etc/pacman.conf "Color" "Color" "[options]"
lineinfile /etc/pacman.conf "ILoveCandy" "ILoveCandy" "[options]"

# TODO: configure more stuff here (/etc/ssh/sshd_config?)
