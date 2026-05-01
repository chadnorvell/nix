function _prompt_timestamp
    if test -n "$TMUX"
        string join '' -- (set_color brblack) (date '+%H:%M') (set_color normal) ' '
    end
end

function _prompt_hostname
    if test -z "$TMUX"
        string join '' -- (set_color -o bryellow) (prompt_hostname) (set_color normal) ' '
    end
end

function _prompt_distrobox_container
    if test -n "$CONTAINER_ID"
        string join '' -- (set_color brblack) "$CONTAINER_ID" (set_color normal) ' '
    end
end

function _delta_info
    set -l delta_path "$HOME/Δ/"
    if string match -q "$delta_path*" "$PWD"
        set -l rel (string replace "$delta_path" "" "$PWD")
        string split -m 1 / "$rel"
    end
end

function _prompt_delta_worktree
    set -l info (_delta_info)
    if set -q info[1]
        string join '' -- (set_color -o brblue) $info[1] (set_color normal) ' '
    end
end

function _prompt_pwd
    set -l info (_delta_info)
    if set -q info[2]
        set -l subpath $info[2]
        if test -z "$subpath"
            set subpath "."
        end
        string join '' -- (set_color -o brcyan) "$subpath" (set_color normal) ' '
    else if set -q info[1]
        string join '' -- (set_color -o brcyan) "." (set_color normal) ' '
    else
        string join '' -- (set_color -o brcyan) (prompt_pwd) (set_color normal) ' '
    end
end

function _prompt_git
    set -g __fish_git_prompt_showdirtystate 1
    set -g __fish_git_prompt_showstashstate 1
    set -g __fish_git_prompt_showuntrackedfiles 1
    set -g __fish_git_prompt_char_stateseparator ' '
    set -g __fish_git_prompt_char_dirtystate '•'
    set -g __fish_git_prompt_char_invalidstate '~'
    set -g __fish_git_prompt_char_stagedstate '±'
    set -g __fish_git_prompt_char_untrackedfiles '×'
    set -g __fish_git_prompt_char_stashstate '†'
    set -g __fish_git_prompt_char_upstream_ahead '›'
    set -g __fish_git_prompt_char_upstream_behind '‹'
    set -g __fish_git_prompt_char_upstream_diverged '‹›'
    set -g __fish_git_prompt_char_upstream_equal '='

    set -l git_info (fish_git_prompt)
    set git_info (string trim $git_info)
    set git_info (string replace '(' '' $git_info)
    set git_info (string replace ')' '' $git_info)

    set -l info (_delta_info)
    if set -q info[1]
        set -l worktree $info[1]
        set -l branch (git branch --show-current 2>/dev/null)
        if test "$branch" = "$worktree"
            set git_info (string replace -r "^$branch" "" "$git_info" | string trim)
        end
    end

    if test -n "$git_info"
        string join '' -- (set_color -o brmagenta) $git_info (set_color normal) ' '
    end
end

function fish_prompt
    set -l last_status $status
    set -l prompt_symbol (string join '' (set -q IN_NIX_SHELL; and echo '»'; or echo '›') ' ' (set_color normal))

    set -l jobs (jobs | count)

    if test "$jobs" -gt 0
        set prompt_symbol (string join '' "$jobs$prompt_symbol")
    end

    if test $last_status -ne 0
        set prompt_symbol (string join '' (set_color -o brred) "[$last_status] $prompt_symbol")
    else
        set prompt_symbol (string join '' (set_color -o brgreen) $prompt_symbol)
    end

    string join '' -- \
        (_prompt_timestamp) \
        (_prompt_hostname) \
        (_prompt_distrobox_container) \
        (_prompt_delta_worktree) \
        (_prompt_pwd) \
        (_prompt_git) \
        $prompt_symbol
end
