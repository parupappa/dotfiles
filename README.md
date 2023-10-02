# Installation
Clone the repository:
```sh
git clone https://github.com/parupappa/dotfiles.git
```

Create symbolic links:
```sh
cd dotfiles
sh dotfilesLink.sh
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
# Reference

- [shirakiya/dotfiles/zshrc](https://github.com/shirakiya/dotfiles/blob/main/zshrc)
- [zsh-kubectl-prompt](https://github.com/superbrothers/zsh-kubectl-prompt)
- [Brewfile で Homebrew のライブラリを管理しよう！](https://kakakakakku.hatenablog.com/entry/2020/09/17/124653)