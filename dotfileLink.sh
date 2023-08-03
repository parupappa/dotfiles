# シンボリックリンク（ショートカット）を設定するファイル
# 管理対象にしたらパスを通す
# 使い方: sh dotfileLink.sh

#!/bin/sh

ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
ln -sf ~/dotfiles/.zprofile ~/.zprofile

