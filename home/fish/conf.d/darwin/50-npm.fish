set -q _fish_sourced_npm; and return

set -x npm_config_prefix "$HOME/.pkg/npm"
not test -d "$npm_config_prefix/bin"; and mkdir -p "$npm_config_prefix/bin"
fish_add_path -Pm "$npm_config_prefix/bin"
set -x _fish_sourced_npm
