#! /bin/bash

IMAGE=myoungone/vim:0.1.1

# volume mount file directory to container /home
VOL=$PWD
if [[ -n $1 ]]
then
    VOL="$(cd "$(dirname "$1")" && pwd -P)"
fi

# volume mount .flake8 file (if exists in parent paths) to container /
FLAKE8_DIR=$VOL  
FLAKE8_MOUNT=""  
while [[ "$FLAKE8_DIR" != "/" ]]; do
    if [[ -f "$FLAKE8_DIR/.flake8" ]]; then
        FLAKE8_MOUNT="-v $FLAKE8_DIR/.flake8:/.flake8"
        break
    fi
    FLAKE8_DIR=$(dirname "$FLAKE8_DIR")
done

# set current UID and GID for creating new file
CUID=$(id -u)
CGID=$(id -g)

# compose command 
VIM="docker run --rm -ti --user $CUID:$CGID -e TERM=xterm-256color $FLAKE8_MOUNT -v $VOL:/home $IMAGE"
if [[ -n $1 ]]
then
    VIM+=" $(basename $1)"
fi

# execute
eval $VIM
