# Installation
Clone the repository:
```sh
git clone https://github.com/parupappa/dotfiles.git
```

Run the setup script:
```sh
sh setup.sh
```

# Brewfile
```bash
# Execute 'dotfiles/homebrew'

# Generate Brewfile
$ brew bundle dump

# brew uninstallを実行しなくても、Brewfileのエントリーを削除して、以下を実行する
$ brew bundle cleanup

# brewsyncでcheck-and-sync-brewfile.zsh を実行する
$ brewsync
```

# Sheldon
```bash
# plugins update
$ sheldon lock --update
```

# mise
```bash
# mise update
$ mise install terraform

```
[言語・ツール・環境変数・タスクランナーの全てを集約する開発環境ツール mise のご紹介](https://zenn.dev/akineko/articles/8fe959a02cb94b)
[mise ではじめる開発環境構築](https://zenn.dev/takamura/articles/dev-started-with-mise)

# Reference
- [shirakiya/dotfiles/zshrc](https://github.com/shirakiya/dotfiles/blob/main/zshrc)
- [zsh-kubectl-prompt](https://github.com/superbrothers/zsh-kubectl-prompt)
- [Brewfile で Homebrew のライブラリを管理しよう！](https://kakakakakku.hatenablog.com/entry/2020/09/17/124653)
- [2024年度 わたしのdotfilesを紹介します](https://zenn.dev/smartcamp/articles/f20a72910bde40#%E3%81%93%E3%82%8C%E3%81%AA%E3%81%AB%EF%BC%9F)