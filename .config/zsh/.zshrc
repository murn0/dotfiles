source "$ZSETTINGS/base.zsh"

case ${OSTYPE} in
    darwin*)
    source "$ZSETTINGS/setting-macos.zsh"
    ;;
    linux*)
    ;;
esac