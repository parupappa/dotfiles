# dotfiles

## セットアップ手順

### 1. リポジトリをクローン

```sh
git clone https://github.com/parupappa/dotfiles.git ~/dotfiles
```

### 2. シークレットファイルを作成

コミットされない `.env` ファイルを作成し、シークレットを記載する。

```sh
cat > ~/dotfiles/.env <<'EOF'
# Obsidian MCP Tools の API キー
# Obsidian → 設定 → コミュニティプラグイン → Local REST API で確認
OBSIDIAN_API_KEY=<your-key>
EOF
```

### 3. セットアップスクリプトを実行

```sh
sh ~/dotfiles/setup.sh
```

以下が自動的に行われる：

- シンボリックリンクの作成（`link.sh`）
- Homebrew・パッケージのインストール
- Claude Code の MCP サーバー設定を `~/.claude.json` へ注入（`claude/inject-mcp.py`）

### 4. Git ユーザー情報を設定

```sh
cat > ~/dotfiles/git/user.conf <<'EOF'
[user]
    name = Your Name
    email = your@email.com
EOF
```

### 5. ターミナルを再起動

---

## 管理されているファイル

| dotfiles のパス | リンク先 | 内容 |
|---|---|---|
| `zsh/.zshrc` | `~/.zshrc` | zsh 設定 |
| `zsh/.zprofile` | `~/.zprofile` | zsh プロファイル |
| `zsh/alias.zsh` | `~/.alias.zsh` | エイリアス |
| `git/.gitconfig` | `~/.gitconfig` | Git 設定 |
| `wezterm/.wezterm.lua` | `~/.wezterm.lua` | WezTerm 設定 |
| `hammerspoon/init.lua` | `~/.hammerspoon/init.lua` | Hammerspoon 設定 |
| `starship/starship.toml` | `~/.config/starship.toml` | Starship プロンプト |
| `sheldon/plugins.toml` | `~/.config/sheldon/plugins.toml` | Sheldon プラグイン |
| `mise/config.toml` | `~/.config/mise/config.toml` | mise ツール管理 |
| `homebrew/Brewfile` | `~/Brewfile` | Homebrew パッケージ一覧 |
| `claude/settings.json` | `~/.claude/settings.json` | Claude Code 設定（フック・権限・プラグイン） |
| `claude/mcp-servers.json` | `~/.claude.json` へ注入 | MCP サーバー定義 |
| `claude/mcp-snowflake-config.yaml` | `~/.config/mcp/snowflake-config.yaml` | Snowflake MCP 設定 |

---

## Claude Code / MCP の設定変更方法

### MCP サーバーを追加・変更する

`claude/mcp-servers.json` を編集して、反映スクリプトを実行する。

```sh
# 編集後に実行
python3 ~/dotfiles/claude/inject-mcp.py
```

> `~/.claude.json` にはランタイム状態も混在しているため、直接編集せず必ずこのスクリプト経由で更新する。

### Claude Code の動作設定を変更する

`claude/settings.json` を直接編集する（シンボリックリンクで即時反映）。
フック・デフォルト権限モード・有効プラグインを管理している。

---

## その他のメンテナンス

### Brewfile

```bash
# 現在インストール済みのパッケージを Brewfile に書き出す
brew bundle dump --force

# Brewfile にないパッケージをアンインストールする
brew bundle cleanup

# brewsync エイリアスで同期
brewsync
```

### Sheldon（zsh プラグイン）

```bash
# プラグインをアップデート
sheldon lock --update
```

### mise（言語・ツール管理）

```bash
# config.toml に記載のツールをインストール
mise i

# ツールをアップデート
mise up
```

---

## Reference

- [shirakiya/dotfiles](https://github.com/shirakiya/dotfiles/blob/main/zshrc)
- [Brewfile で Homebrew のライブラリを管理しよう！](https://kakakakakku.hatenablog.com/entry/2020/09/17/124653)
- [言語・ツール・環境変数・タスクランナーの全てを集約する開発環境ツール mise のご紹介](https://zenn.dev/akineko/articles/8fe959a02cb94b)
