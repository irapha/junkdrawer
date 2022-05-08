# junkdrawer
A place for all the things that didn't fit anywhere else

## Setting up a new box
```bash
cd ~
mkdir dev
cd dev

# create ssh keys
ssh-keygen -t rsa -b 4096 -C "raphaelgontijolopes@gmail.com"
eval "$(ssh-agent -s)"
ssh-add -K ~/.ssh/id_rsa || ssh-add ~/.ssh/id_rsa
# copy contents of ~/.ssh/id_rsa.pub into github

git clone git@github.com:iRapha/junkdrawer.git
cd junkdrawer
bash ./install.sh
```

## Setting up new aws dev box
WIP instructions

[add new user with ssh access](https://aws.amazon.com/premiumsupport/knowledge-center/new-user-accounts-linux-instance/) (note: default user is `ubuntu`, or `ec2-user`)
[add the user to sudoers](https://linuxize.com/post/how-to-add-user-to-sudoers-in-ubuntu/)

[install zsh](https://www.tecmint.com/install-zsh-in-ubuntu/) (add ~/.zshrc from this repo)

the aws deep learning amis should already come with tmux, git and py3 (add ~/tmux.conf from this repo)
to install tmux plugins (including dracula theme), install tpm:
`git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
then launch tmux and run ctr+a+I

[install neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)

add init.vim (from this repo) into `~/.config/nvim/init.vim`
install vim dracula theme
```
mkdir -p ~/.local/share/nvim/site/pack/themes/opt/
cd ~/.local/share/nvim/site/pack/themes/opt/
git clone https://github.com/dracula/vim.git dracula
```

install jupyter `sudo apt install jupyter`
[configure instance](https://dataschool.com/data-modeling-101/running-jupyter-notebook-on-an-ec2-server/) to allow jupyter notebooks over https

