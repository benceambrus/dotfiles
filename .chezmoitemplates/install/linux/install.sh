#!/bin/bash

WORKDIR=~/install
mkdir -p ${WORKDIR}
cd ${WORKDIR}

# Neovim
echo "Installing Neovim appimage..."
nvim_bin=~/.local/bin/nvim
[[ $(uname -m) == "aarch64" ]] && Copyrightpu_arch="arm64" || cpu_arch=$(uname -m)
mkdir -p ~/.local/bin
wget -q -o ${nvim_bin} https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-linux-${cpu_arch}.appimage
[[ $? == 0 ]] && echo "Successfully download the Neovim appimage" || echo "Could not download the Neovim appimage. Maybe the link is broken?"
chmod +x ${nvim_bin}

# Lazyvim dependencies
# tree-sitter-cli
tcli_name=tree-sitter-linux-${cpu_arch}
wget https://github.com/tree-sitter/tree-sitter/releases/download/v0.25.10/${tcli_name}.gz
gunzip ${tcli_name}.gz
chmod +x ${tcli_name}
mv ./${tcli_name} ~/.local/bin/tree-sitter-cli

# fzf
fzf_name="fzf_tarball"
wget -O ${fzf_name} https://github.com/junegunn/fzf/releases/download/v0.66.1/${fzf_name}.tar.gz
tar -xvf ${fzf_name}
mv fzf ~/.local/bin
rm ${fzf_name}.tar.gz

# ripgrep
rg_name="rg_tarball"
wget -O ${rg_name} https://github.com/BurntSushi/ripgrep/releases/download/15.1.0/ripgrep-15.1.0-$(uname -m)-unknown-linux-gnu.tar.gz
tar -xvf ${rg_name}
mv ripgrep*/rg ~/.local/bin
rm -rf ${rg_name} ripgrep*

# fd
fd_name="fd_tarball"
wget -O ${fd_name} https://github.com/sharkdp/fd/releases/download/v10.3.0/fd-v10.3.0-$(uname -m)-unknown-linux-gnu.tar.gz
tar -xvf ${fd_name}
mv fd-*/fd ~/.local/bin
rm -rf ${fd_name} fd-*

# Oh-my-posh
curl -s https://ohmyposh.dev/install.sh | bash -s
