# vim:ft=zsh

# This block tries to read the current background color from the
# terminal
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

cmd_exec_time() {
    local stop=`date +%s`
    local start=${cmd_timestamp:-$stop}
    let local elapsed=$stop-$start
    [ $elapsed -gt 5 ] && echo "(${elapsed}s)"
}

preexec() {
    cmd_timestamp=`date +%s`
}


PL_FR="\ue0b0"
PL_TR="\ue0b1"
PL_FL="\ue0b2"
PL_TL="\ue0b3"

get_prompt() {
    DARK=$(get_colorscheme)

    if [[ $DARK -ne 0 ]]; then
        BG_STD=8
        BG_ALT=0
        FG_STD=12
        FG_DIM=10
        FG_STR=14
    else
        BG_STD=15
        BG_ALT=7
        FG_STD=11
        FG_DIM=14
        FG_STR=10
    fi

    AC_RED=1
    AC_GRN=2
    AC_YEL=3
    AC_BLU=4
    AC_MAG=5
    AC_CYA=6
    AC_ORJ=9
    AC_PRP=14

    LAST=$(fc -Iln -1 2>>/dev/null)
    if [[ -n $LAST && $LAST != 'clear' ]]; then
    # TODO: Composite command dtection
    # TODO : Better sudo detection
        LAST_CMD=$(echo $LAST | sed -E 's/^(\S+).*/\1/')
        if [[ $LAST_CMD == 'sudo' ]]; then
            SUDO="%{%B%}%{%F{$AC_RED}%}${PL_TR}SUDO${PL_TR}%{%f%}%{%b%} "
        fi
        echo "%{%K{$BG_ALT}%} - $SUDO$LAST_CMD ($($?)) - %{%k%}%{%F{$BG_ALT}%}$PL_FR"
    fi
    echo "%{%f%}%{%K{$BG_ALT}%} %~ >>%{%k%}%{%F{$BG_ALT}%}$PL_FR%{%f%}"
}

PROMPT='$(get_prompt)'
