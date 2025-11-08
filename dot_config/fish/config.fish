# Path additions
set -x PATH ~/.local/bin $PATH

# Environment variables
if command -q nvim; set -x EDITOR nvim; end

# LFCD alias
alias l=lfcd

# Starship prompt
# starship init fish | source

# Oh-my-posh
oh-my-posh init fish --config ~/.config/oh-my-posh.omp.yml | source
