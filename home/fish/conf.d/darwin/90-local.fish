set -q _fish_sourced_local_bin; and return

not test -d "$HOME/.local/bin"; and mkdir -p "$HOME/.local/bin"
fish_add_path -Pm "$HOME/.local/bin"
set -x _fish_sourced_local_bin
