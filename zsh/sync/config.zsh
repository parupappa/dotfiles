#!/bin/zsh

# ------------------------------
# General settings
# ------------------------------

# 環境変数
export LANG=ja_JP.UTF-8

# パスを直接入力してもcdする
setopt auto_cd

# コマンドのスペルを訂正する
setopt correct

# 文字の一部と認識する記号
export WORDCHARS='*?_-[]~=&;!#$%^(){}<>'

# カラーの有効化
autoload -U colors && colors

# ------------------------------
# History settings
# ------------------------------

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=30000

# shellcheck disable=SC2034
SAVEHIST=30000

# 他のzshと履歴を共有
setopt inc_append_history
setopt share_history

# 直前のコマンドの重複を削除
setopt hist_ignore_dups

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# historyに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# ------------------------------
# Complement settings
# ------------------------------
# cd-<tab>で以前移動したディレクトリを表示
setopt auto_pushd

# 環境変数を補完
setopt auto_param_keys

# 補完候補がディレクトリの場合, 末尾に/を追加
setopt auto_param_slash

# 補完候補一覧でファイルの種別を識別マーク表示
setopt list_types

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# zsh-completions の設定。コマンド補完機能
autoload -U compinit && compinit -u
autoload -U +X bashcompinit && bashcompinit

# zsh-completions
# compinit の実行よりも前に記述する
if [ -e ${HOMEBREW_DIR}/share/zsh-completions ]; then
    fpath=(${HOMEBREW_DIR}/share/zsh-completions $fpath)
fi

# 補完機能を有効にする
autoload -Uz compinit
compinit -C

# kubectlの補完機能を有効にする
[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
# helmの補完機能を有効にする
source <(helm completion zsh)
