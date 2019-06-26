#!/usr/bin/zsh


get_term_mode() {
    success=false
    exec < /dev/tty
    oldstty=$(stty -g)
    stty raw -echo min 0
    col=11      # background
    #          OSC   Ps  ;Pt ST
    echo -en "\033]${col};?\033\\" >/dev/tty  # echo opts differ w/ OSes
    result=
    if IFS=';' read -r -d '\' color ; then
        result=$(echo $color | sed 's/^.*\;//;s/[^rgb:0-9a-f/]//g')
        success=true
    fi
    stty $oldstty
    echo $result
    $success
}
#
# Now that it's read we can try and set some vars
get_colorscheme() {
    RGB=$(get_term_mode)
    RR=$(echo "$RGB" | sed -E 's#^rgb:..(..)/..../....#\1#')
    GG=$(echo "$RGB" | sed -E 's#^rgb:..../..(..)/....#\1#')
    BB=$(echo "$RGB" | sed -E 's#^rgb:..../..../..(..)#\1#')
    BRIGHT=$(perl -e "use List::Util qw[min max]; print ((max(hex(@ARGV[0]),hex(@ARGV[1]),hex(@ARGV[2])) + min(hex(@ARGV[0]),hex(@ARGV[1]),hex(@ARGV[2]))) / 510)" $RR $GG $BB)

    echo $(( $BRIGHT < 0.5 ))
}


echo $(get_colorscheme)
