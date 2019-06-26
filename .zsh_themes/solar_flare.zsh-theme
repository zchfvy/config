# vim:ft=zsh

cmd_exec_time() {
    [ $elapsed -gt 1 ] && echo "(${elapsed}s)"
}

preexec() {
    cmd_timestamp=`date +%s`
}

solar_flare_precommand_hook() {
    vcs_info

    local stop=`date +%s`
    local start=${cmd_timestamp:-$stop}
    let elapsed=$stop-$start
    cmd_timestamp=''
}

setup_solar_flare() {
    autoload -Uz add-zsh-hook
    autoload -Uz vcs_info

    add-zsh-hook precmd solar_flare_precommand_hook

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' check-for-changes false
    zstyle ':vcs_info:git*' formats '%b'
    zstyle ':vcs_info:git*' actionformats '%b (%a)'
}


# Comamnds to not draw status for
NOSTATUS=(ls clear cd z pwd)


# Powerline symbols
PL_FR="\ue0b0"
PL_TR="\ue0b1"
PL_FL="\ue0b2"
PL_TL="\ue0b3"

build_prompt() {

    # Setup colors
    DARK=$(~/.zsh_themes/is_term_dark.sh)

    if [[ $DARK -ne 0 ]]; then
        C_BG_STD=8
        C_BG_ALT=0
        C_FG_STD=12
        C_FG_DIM=10
        C_FG_STR=14
    else
        C_BG_STD=15
        C_BG_ALT=7
        C_FG_STD=11
        C_FG_DIM=14
        C_FG_STR=10
    fi

    BG_STD="%{%k%}"
    BG_ALT="%{%K{$C_BG_ALT}%}"
    FG_STD="%{%f%}"
    FG_DIM="%{%F{$C_FG_DIM}%}"
    FG_STR="%{%F{$C_FG_STR}%}"

    C_AC_RED=1
    AC_RED="%{%F{$C_AC_RED}%}"
    C_AC_GRN=2
    AC_GRN="%{%F{$C_AC_GRN}%}"
    C_AC_YEL=3
    AC_YEL="%{%F{$C_AC_YEL}%}"
    C_AC_BLU=4
    AC_BLU="%{%F{$C_AC_BLU}%}"
    C_AC_MAG=5
    AC_MAG="%{%F{$C_AC_MAG}%}"
    C_AC_CYA=6
    AC_CYA="%{%F{$C_AC_CYA}%}"
    C_AC_ORJ=9
    AC_ORJ="%{%F{$C_AC_ORJ}%}"
    C_AC_PRP=14
    AC_PRP="%{%F{$C_AC_PRP}%}"

    LAST=$(fc -Iln -1 2>>/dev/null)

    get_prevline() {

        is_sudo() {
            test -n "$(echo $1 | sed -E 's/^(\S+).*/\1/' | grep sudo)"
        }
        strip_sudo() {
            echo "$(echo $1 | sed -E 's/^sudo (.*)/\1/' )"
        }

        if [[ -n $LAST && ${NOSTATUS[(r)$LAST]} != $LAST ]]; then
            if is_sudo "$LAST"; then
                SUDO="$AC_RED SUDO $FG_STD"
                LST=$(strip_sudo "$LAST")
            else
                LST="$LAST"
            fi
            # TODO: Composite command dtection
            # TODO : Better sudo detection
            if test "${LST#*|}" != "$LST"; then
                LAST_CMD="${FG_DIM}composite command${FG_STD}"
            else
                LAST_CMD=$(echo $LST | sed -E 's/^(\S+).*/\1/')
            fi

            EXIT="%(?..[$AC_RED%?$FG_STD])"
            TIME=$(cmd_exec_time)

            echo " $SUDO$LAST_CMD $EXIT $TIME"
        fi
    }

    begin_prompt() {
        echo "$FG_STD $BG_ALT"
    }

    virtualenv_prompt() {
        if [[ -n "$VIRTUAL_ENV" ]]; then
            venv="${VIRTUAL_ENV##*/}"
        else
            venv=''
        fi
        [[ -n "$venv" ]] && echo "($venv) "
    }

    get_prompt() {
        echo " %1~ "
    }

    git_prompt() {
        is_dirty() {
            test -n "$(git status --porcelain --ignore-submodules | grep -v '^??')"
        }
        ref="$vcs_info_msg_0_"

        if [[ -n "$ref" ]]; then
            res="$(git status --porcelain=v2 --branch | awk -f ~/gitstatus.awk)"
            echo "${(e)res}"
            # if is_dirty; then
            #     echo "$AC_RED $ref $FG_STD"
            # else
            #     echo "$AC_GRN $ref $FG_STD"
            # fi
        fi
    }

    end_prompt() {
        echo "$BG_STD%{%F{$C_BG_ALT}%}$PL_FR$FG_STD"
    }

    PREV="$(get_prevline)"
    if [[ -n $PREV ]]; then
        echo "$FG_STD$BG_ALT$PREV$(end_prompt)"
    fi
    echo "$FG_STD$BG_ALT$(virtualenv_prompt)$(get_prompt)$(git_prompt)$(end_prompt) » "
}

setup_solar_flare

export VIRTUAL_ENV_DISABLE_PROMPT=1
PROMPT='$(build_prompt)'
