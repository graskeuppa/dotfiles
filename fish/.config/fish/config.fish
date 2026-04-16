if status is-interactive
    # Commands to run in interactive sessions can go here

    set -gx EDITOR nvim
    # zoxide
    zoxide init fish | source
    fish_add_path (brew --prefix)/opt/openjdk@21/bin
    set -gx JAVA_HOME (brew --prefix)/opt/openjdk@21
    fish_add_path (brew --prefix)/opt/openjdk@21/bin
    set fish_greeting

    #    set -gx JAVA_HOME /usr/lib/jvm/java-21-openjdk
    #set -gx PATH $JAVA_HOME/bin $PATH
    #echo "fish_add_path (brew --prefix)/opt/openjdk@21/bin" >>~/.config/fish/config.fish
    #echo "set -gx JAVA_HOME (brew --prefix)/opt/openjdk@21" >>~/.config/fish/config.fish

    ## Common shortcuts
    alias q="exit"
    alias l="lsd --blocks date,name"
    alias n="nvim"
    alias c="clear"
    alias s="spotatui"

    ## Git
    alias lg="lazygit"
    alias gtb="git branch"
    alias gtch="git checkout"
    alias gts="git status"
    alias gtpu="git pull"
    alias gtp="git push"
    alias gtc="git commit -m"

    ## WM
    alias float='pkill -f "AeroSpace|borders|sketchybar" '

    # Wrap yazi with y and change cwd when exited
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

    starship init fish | source

end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
set -gx PATH $HOME/.cabal/bin /Users/gras/.ghcup/bin $PATH # ghcup-env

fish_add_path /Users/gras/.spicetify

# Set up fzf key bindings
fzf --fish | source
