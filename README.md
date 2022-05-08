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


install tmux 3.0
https://gist.github.com/muralisc/dbb998a8555acc577ce2cf7aae8cd9fa
(and dracula theme, and tmux config)

install py4

install git

install neovim: follow [these instructions](https://gist.github.com/bombsimon/9e4f5607e01854f9624cf92c486561cf)
(note: this did not work)

install vimrc (see ~/.vimrc in macbook)
install vim dracula theme
```
mkdir -p ~/.vim/pack/themes/start
cd ~/.vim/pack/themes/start
git clone https://github.com/dracula/vim.git dracula
```
