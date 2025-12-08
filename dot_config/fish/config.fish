# Path additions
set -x PATH ~/.local/bin $PATH

# Environment variables
if command -q nvim
    set -x EDITOR nvim
end

# Yazi cd
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# Starship prompt
# starship init fish | source

# Oh-my-posh
oh-my-posh init fish --config ~/.config/oh-my-posh.omp.yml | source

# Aliases
## Check if commands are available before setting the aliases
function using
    type -q $argv[1]
end

## eza
if using eza
    alias ls eza
    alias ll "eza -lh"
end
