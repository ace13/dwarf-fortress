#!/bin/sh

RESET_XHOST=false
if [ $(xhost | head -n1 | awk '{print $3}') == "enabled," ]; then
    xhost +
    RESET_XHOST=true
fi

mkdir -p "$HOME/.dwarf-fortress"
docker run --rm -it \
    -e UID=`id -u` -e GID=`id -g` \
    -e DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /dev/snd:/dev/snd \
    -v "$HOME/.dwarf-fortress/data:/df_linux/data" \
    -v "$HOME/.dwarf-fortress/scripts:/df_linux/hack/scripts" \
    dwarf-fortress:43_03

if $RESET_XHOST; then
    xhost -
fi
