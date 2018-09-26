#!/bin/sh

TERM=/usr/bin/kitty
LIST_PROC=(
    "code-1"
    "code-2"
    "code-3"
    "code-4"
    "code-5"
    "code-6"
)

clear_env() {
    local old_term=$(ps aux | grep -i "${TERM} --name=code" | awk '{print $2}')
    for i in ${old_term[@]} ; do
        echo "clear process $i"
        kill -9 $i
    done
}

launch_proc() {
    for i in ${LIST_PROC[@]} ; do
        echo "launch proc $i"
        $TERM --name="$i" &
        sleep .2
    done
}

clear_env
trap "launch_proc" EXIT
