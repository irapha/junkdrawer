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
