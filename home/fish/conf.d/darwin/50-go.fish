set -q _fish_sourced_go; and return

set -x GOPATH "$HOME/.pkg/go"
not test -d $GOPATH; and mkdir -p $GOPATH
fish_add_path -Pm $GOPATH
set -x _fish_sourced_go
