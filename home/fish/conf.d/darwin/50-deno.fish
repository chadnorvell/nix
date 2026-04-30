set -q _fish_sourced_deno; and return
not test -e "$HOME/.deno/env.fish"; and return

source "$HOME/.deno/env.fish"
set -x _fish_sourced_deno
