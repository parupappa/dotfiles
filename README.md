# Installation
Clone the repository:
```sh
git clone https://github.com/parupappa/dotfiles.git
```

Run the setup script:
```sh
sh setup.sh
```

# Usage
When adding a new file for management:

1. Add the file you want to manage with git to the `dotfiles`.
2. In `.zshrc`, add a script that creates a symbolic link to the file.
3. Perform `git add, commit, and push`.
4. Check the files being managed by git.
    ```sh
      # /dotfiles
      git ls-files
    ```


# Brewfile
```bash
# Execute 'dotfiles/homebrew'

# Generate Brewfile
$ brew bundle dump

# brew uninstallを実行しなくても、Brewfileのエントリーを削除して、以下を実行する
$ brew bundle cleanup
```

# Reference
- [shirakiya/dotfiles/zshrc](https://github.com/shirakiya/dotfiles/blob/main/zshrc)
- [zsh-kubectl-prompt](https://github.com/superbrothers/zsh-kubectl-prompt)
- [Brewfile で Homebrew のライブラリを管理しよう！](https://kakakakakku.hatenablog.com/entry/2020/09/17/124653)
- [2024年度 わたしのdotfilesを紹介します](https://zenn.dev/smartcamp/articles/f20a72910bde40#%E3%81%93%E3%82%8C%E3%81%AA%E3%81%AB%EF%BC%9F)