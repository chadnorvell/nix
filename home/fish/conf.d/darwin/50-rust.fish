set -q _fish_sourced_cargo; and return
not test -e "$HOME/.cargo/env.fish"; and return

source "$HOME/.cargo/env.fish"
set -x _fish_sourced_cargo

