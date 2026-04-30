set -q _fish_sourced_bun; and return
not test -d "$HOME/.bun/bin"; and return

set -x BUN_INSTALL "$HOME/.bun"
fish_add_path -Pm "$BUN_INSTALL/bin"
set -x _fish_sourced_bun
