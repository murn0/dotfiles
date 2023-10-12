# Set user variables based on XDG Base Directory Specification.
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx FISH_INSTALL_PATH (type -p fish)

# Add aqua to the environment variable PATH.
if [ -n "$AQUA_ROOT_DIR" ]
    fish_add_path -p "$AQUA_ROOT_DIR/bin"
else if [ -n "$XDG_DATA_HOME" ]
    fish_add_path -p "$XDG_DATA_HOME/aquaproj-aqua/bin"
else
    fish_add_path -p "$HOME/.local/share/aquaproj-aqua/bin"
end

# Define configuration files for each platform
switch (uname)
    case Darwin
        set LOCAL_CONFIG_MACOS $XDG_CONFIG_HOME/fish/modules/config-macos.fish
        if [ -e "$LOCAL_CONFIG_MACOS" ]
            source "$LOCAL_CONFIG_MACOS"
        end
    case Linux
        set LOCAL_CONFIG_LINUX $XDG_CONFIG_HOME/fish/modules/config-linux.fish
        if [ -e "$LOCAL_CONFIG_LINUX" ]
            source "$LOCAL_CONFIG_LINUX"
        end
    case '*'
        set LOCAL_CONFIG_WINDOWS $XDG_CONFIG_HOME/fish/modules/config-windows.fish
        if [ -e "$LOCAL_CONFIG_WINDOWS" ]
            source "$LOCAL_CONFIG_WINDOWS"
        end
end

# Define local configuration file
set LOCAL_CONFIG $XDG_CONFIG_HOME/fish/config-local.fish
if [ -e "$LOCAL_CONFIG" ]
    source "$LOCAL_CONFIG"
end

# Loading the Shell Integration File for Wezterm
set WEZTERM_SHELL_INTEGRATION $XDG_CONFIG_HOME/fish/modules/wezterm.fish
if [ -e "$WEZTERM_SHELL_INTEGRATION" ]
    source "$WEZTERM_SHELL_INTEGRATION"
end
