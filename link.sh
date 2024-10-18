#!/bin/bash

DOTFILES_DIR=~/dotfiles

echo "シンボリックリンクを作成します"

# ------------------------------------------------------------
# .から始まるファイルに対してシンボリックリンクを作成
# ------------------------------------------------------------

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

# ------------------------------------------------------------
# .から始まらないファイルに対してもシンボリックリンクを作成
# ------------------------------------------------------------

# シンボリックリンクを作成する関数
create_symlink() {
    local target=$1
    local link_name=$2

    if [ -e "$link_name" ]; then
        echo "シンボリックリンク $link_name は既に存在します。"
    else
        ln -s "$target" "$link_name"
        echo "シンボリックリンク $link_name を作成しました。"
    fi
}

# Brewfileのシンボリックリンクを作成
create_symlink "$DOTFILES_DIR/homebrew/Brewfile" "$HOME/Brewfile"

# .hammerspoon/init.luaのシンボリックリンクを作成
create_symlink "$DOTFILES_DIR/hammerspoon/init.lua" "$HOME/.hammerspoon/init.lua"

# starship/starship.tomlのシンボリックリンクを作成
create_symlink "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"

# sheldon
create_symlink "$DOTFILES_DIR/sheldon/plugins.toml" "$HOME/.config/sheldon/plugins.toml"

echo "シンボリックリンクがホームディレクトリ直下に作成されました"
