#!/bin/bash

tmux-project() {
    local session="$1"
    shift

    if [[ -z "$session" ]]; then
        echo "Usage: tmux-project <session_name> <locationA> <commandA> [locationB] [commandB] ..." >&2
        return 1
    fi

    if ! tmux has-session -t "$session" 2>/dev/null; then
        local locs=()
        local cmds=()

        while [[ $# -ge 2 ]]; do
            locs+=("$1")
            cmds+=("$2")
            shift 2
        done

        if [[ ${#locs[@]} -eq 0 ]]; then
            echo "Error: At least one location/command pair required" >&2
            return 1
        fi

        local tmux_cmd="tmux new-session -s $session -c ${locs[0]} -n 'nvim' '${cmds[0]}' \\;"

        for i in $(seq 1 $((${#locs[@]} - 1))); do
            local win_name="win$i"
            if [[ $i -eq 1 ]]; then
                win_name="server"
            fi
            tmux_cmd="$tmux_cmd new-window -t $session -n $win_name -c ${locs[$i]} '${cmds[$i]}' \\;"
        done

        tmux_cmd="$tmux_cmd select-window -t $session:nvim"

        eval "$tmux_cmd"
    else
        tmux attach-session -t "$session"
    fi
}

dev() {
    local session="$1"
    shift

    if [[ -z "$session" ]]; then
        echo "Usage: dev <session_name> <locationA> <commandA> [locationB] <commandB> ..." >&2
        return 1
    fi

    tmux-project "$session" "$@"
}
