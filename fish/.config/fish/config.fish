if status is-interactive
    # Commands to run in interactive sessions can go here

    set -gx EDITOR nvim
    #    set -gx JAVA_HOME /usr/lib/jvm/java-21-openjdk
    #set -gx PATH $JAVA_HOME/bin $PATH
    echo "fish_add_path (brew --prefix)/opt/openjdk@21/bin" >>~/.config/fish/config.fish
    echo "set -gx JAVA_HOME (brew --prefix)/opt/openjdk@21" >>~/.config/fish/config.fish

    # Aliases
    alias q="exit"
    alias l="lsd -l"
    alias lgit="lazygit"
    alias sus="systemctl suspend"
    alias gtb="git branch"
    alias gtch="git checkout"
    alias gts="git status"
    alias gtpu="git pull"
    alias gtp="git push"
    alias gtc="git commit -m"
    alias snow="shutdown now"
    alias n="nvim"
    alias c="clear"
    # Wrap yazi with y and change cwd when exited
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

end

# zoxide
zoxide init fish | source
fish_add_path (brew --prefix)/opt/openjdk@21/bin
set -gx JAVA_HOME (brew --prefix)/opt/openjdk@21
fish_add_path (brew --prefix)/opt/openjdk@21/bin
set -gx JAVA_HOME (brew --prefix)/opt/openjdk@21
