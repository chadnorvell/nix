set -q __ETC_PROFILE_NIX_SOURCED; or set -l should_prepend_paths

if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
end

# Ensure the Nix paths are at the front regardless of evaluation order.
if set -q should_prepend_paths
    fish_add_path --move --prepend $HOME/.nix-profile/bin /nix/var/nix/profiles/default/bin
end

if status is-interactive
    # Add completions from tools installed via Homebrew.
    if type -q brew
        set -l brew_prefix (brew --prefix)
        set -gp fish_complete_path $brew_prefix/share/fish/vendor_completions.d
        set -gp fish_complete_path $brew_prefix/share/fish/completions
    end
end
