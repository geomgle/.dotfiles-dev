# Update dotfiles
git pull

# Locale
sudo cp linux/archlinux/ko_KR /usr/share/i18n/locales/
sudo ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
sudo hwclock --systohc
sudo sed -i \
    -e 's/^#\(en_US.UTF-8.*\)/\1/' \
    -e 's/^#\(ko_KR.UTF-8.*\)/\1/' \
    /etc/locale.gen
sudo locale-gen
sudo sed -i "s/\(LANG=\).*/\1en_US.UTF-8/" /etc/locale.conf
sudo ln -sf $HOME/.dotfiles/linux/archlinux/xorg.conf /etc/X11/xorg.conf
sudo mkinitcpio -p linux-lts

# Make directories
mkdir -p ~/.gnupg
chmod 700 ~/.gnupg
mkdir -p ~/.config/nvim
mkdir -p ~/.virtualenvs

# Stow configs
stow arch
stow lf
stow nvim

# Fzf install
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
echo yes; echo yes; echo no | ~/.fzf/install

# Bash-git-prompt
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

# Nvim plugins install
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# Make vim colorscheme correct
find ~/.local/share/nvim/site/pack/packer/start/nightfox.nvim/. -maxdepth 1 ! -name ".git" -exec rm -rf {} \;
stow colors


