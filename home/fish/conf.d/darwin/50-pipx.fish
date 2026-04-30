set -q _fish_sourced_pipx; and return

set -x PIPX_HOME "$HOME/.pkg/pipx"
set -x PIPX_BIN_DIR "$HOME/.pkg/pipx"
not test -d $PIPX_BIN_DIR; and mkdir -p $PIPX_BIN_DIR
fish_add_path -Pm $PIPX_BIN_DIR
set -x _fish_sourced_pipx
