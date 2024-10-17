#!/bin/bash

DOTFILES_DIR=~/dotfiles

echo "シンボリックリンクを作成します"

# dotfilesディレクトリ内の二つ下のディレクトリにあるファイルに対してループ
for file in "$DOTFILES_DIR"/*/.[^.]*; do
    # '.' と '..' はスキップ
    if [[ $file == "$DOTFILES_DIR/." || $file == "$DOTFILES_DIR/.." ]]; then
        continue
    fi

    # ホームディレクトリ直下に作成するパスを計算
    link_name=~/${file#"$DOTFILES_DIR"/*/}

    # シンボリックリンクの作成
    ln -sfn "$file" "$link_name"

    # 作成したシンボリックリンクを出力
    echo "リンクを作成: $file -> $link_name"
done

# Brewfileのシンボリックリンクを作成
# 上記スクリプトでは、'.'から始まるファイルを対象にしているため、Brewfileは対象外. brew bundle --cleanupを実行するには、'Brefile'でないとけないため
brewfile_target="$DOTFILES_DIR/homebrew/Brewfile"
brewfile_link="$HOME/Brewfile"

if [ -e "$brewfile_link" ]; then
    echo "シンボリックリンク $brewfile_link は既に存在します。"
else
    ln -s "$brewfile_target" "$brewfile_link"
    echo "シンボリックリンク $brewfile_link を作成しました。"
fi

# .hammerspoon/init.luaのシンボリックリンクを作成
hammerspoon_target="$DOTFILES_DIR/hammerspoon/init.lua"
hammerspoon_link="$HOME/.hammerspoon/init.lua"

if [ -e "$hammerspoon_link" ]; then
    echo "シンボリックリンク $hammerspoon_link は既に存在します。"
else
    ln -s "$hammerspoon_target" "$hammerspoon_link"
    echo "シンボリックリンク $hammerspoon_link を作成しました。"
fi


echo "シンボリックリンクがホームディレクトリ直下に作成されました"
