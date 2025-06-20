if status is-interactive
    # Commands to run in interactive sessions can go here

    set -gx EDITOR nvim
    # Aliases
    alias fetch="pfetch"
    alias paci="sudo pacman -S"
    alias pacl="pacman -sS"
    alias pacsu="sudo pacman -Syu"
    alias pacu="sudo pacman -Su"
    alias q="exit"
    alias l="lsd -l"
    alias lout="hyprctl dispatch exit"
    alias lgit="lazygit"
    alias sus="systemctl suspend"
    alias gitb="git branch"
    alias gitc="git checkout"
    alias gits="git status"
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

# oh-my-posh
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
oh-my-posh init fish --config ~/dotfiles/oh-my-posh/catppuccin_mocha.omp.json | source

# zoxide
zoxide init fish | source
