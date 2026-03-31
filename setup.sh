#!/bin/bash

echo "セットアップを開始します"

# dotfilesのシンボリックリンクを作成する
source ~/dotfiles/link.sh

# homebrewがインストールされていない場合はインストール
if ! type brew >/dev/null 2>&1; then
    echo "Homebrewをインストールします"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (
        echo
        echo "eval \"$(/opt/homebrew/bin/brew shellenv)\""
    ) >>"$HOME"/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrewはすでにインストールされています"
fi

# Brewfileに記載されているパッケージをインストール
source ~/dotfiles/brew-init.sh

# zshをbrewのものに置き換え
source ~/dotfiles/replace-zsh.sh

# gitをbrewのものに置き換え
source ~/dotfiles/replace-git.sh

# kubectl argo rollouts completion (一度だけ実行)
if ! [ -f /usr/local/bin/kubectl_complete-argo-rollouts ]; then
    cat <<'EOF' >/tmp/kubectl_complete-argo-rollouts
#!/usr/bin/env sh
kubectl argo rollouts __complete "$@"
EOF
    chmod +x /tmp/kubectl_complete-argo-rollouts
    sudo mv /tmp/kubectl_complete-argo-rollouts /usr/local/bin/
fi

# Claude Code の MCP サーバー設定を ~/.claude.json に注入
echo "Claude Code MCP サーバー設定を注入します"
python3 ~/dotfiles/claude/inject-mcp.py

echo "セットアップが完了しました"
echo "Next..."
echo "1. .envを追加し、環境変数を設定してください。"
echo "   OBSIDIAN_VAULT=<vault-dir>  # Obsidian Vault のディレクトリパス"
echo "   OBSIDIAN_API_KEY=<your-key>  # ~/.obsidian/plugins/mcp-tools の設定画面で確認"
echo "2. git/user.confを追加し、ユーザー情報を設定してください。"
echo "3. ターミナルを再起動してください。"
