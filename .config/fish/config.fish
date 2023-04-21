# Set user variables based on XDG Base Directory Specification.
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_DATA_HOME "$HOME/.local/share"

# Add aqua to the environment variable PATH.
if test -n "$AQUA_ROOT_DIR"
    fish_add_path -p "$AQUA_ROOT_DIR/bin"
else if test -n "$XDG_DATA_HOME"
    fish_add_path -p "$XDG_DATA_HOME/aquaproj-aqua/bin"
else
    fish_add_path -p "$HOME/.local/share/aquaproj-aqua/bin"
end