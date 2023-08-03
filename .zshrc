# 補完機能を有効にする
autoload -Uz compinit
compinit -u
if [ -e /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi


# git
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# プロンプトカスタマイズ
PROMPT='[%F{cyan}@%n%f%F{green}%~%f]%F{cyan}$vcs_info_msg_0_%f
$ '


export PATH="/opt/homebrew/bin:$PATH"

##### zsh の設定 #####
 
# zsh-completions の設定。コマンド補完機能
autoload -U compinit && compinit -u
autoload -U +X bashcompinit && bashcompinit

# コマンドのスペルを訂正する
setopt correct



# . /opt/homebrew/opt/asdf/asdf.sh

# alias
alias tf='terraform'
alias k='kubectl'

# k8s
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
source <(helm completion zsh)

# AWS CLIのプロファイル切り替え
# ref: https://devops-blog.virtualtech.jp/entry/2022/01/28/145425
function switch_aws() {
    config=$(aws configure list-profiles | sort | fzf --reverse)
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
    export AWS_PROFILE=$config
}

# Google Cloudのプロジェクト切り替え
function switch_gcloud() {
  local selected=$(
    gcloud config configurations list --format='table[no-heading](is_active.yesno(yes="[x]",no="[_]"), name, properties.core.account, properties.core.project.yesno(no="(unset)"))' \
      | fzf --select-1 --query="$1" \
      | awk '{print $2}'
  )
  if [ -n "$selected" ]; then
    gcloud config configurations activate $selected
  fi
}
