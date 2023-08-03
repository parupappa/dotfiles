# ------------------------------
# General Settings
# ------------------------------

# コマンドのスペルを訂正する
setopt correct

# zsh-completions の設定。コマンド補完機能
autoload -U compinit && compinit -u
autoload -U +X bashcompinit && bashcompinit

# もしかして機能
setopt correct

# 文字の一部と認識する記号
export WORDCHARS='*?_-[]~=&;!#$%^(){}<>'


# ------------------------------
# complement settings
# ------------------------------

# zsh-completions
# compinit の実行よりも前に記述する
if [ -e ${HOMEBREW_DIR}/share/zsh-completions ]; then
    fpath=(${HOMEBREW_DIR}/share/zsh-completions $fpath)
fi

# 補完機能を有効にする
autoload -Uz compinit
compinit -C

# 補完候補がディレクトリの場合, 末尾に/を追加
setopt auto_param_slash

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# kubectlの補完機能を有効にする
[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
# helmの補完機能を有効にする
source <(helm completion zsh)

# ------------------------------
# Path setting
# ------------------------------

# krewのパスを設定
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
# homebrewのパスを設定
export PATH="/opt/homebrew/bin:$PATH"

# ------------------------------
# Alias setting
# ------------------------------

alias tf='terraform'
alias k='kubectl'

# ------------------------------
# Cloud setting（AWS, GCP）
# ------------------------------

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

# ------------------------------
# Prompt setting
# ------------------------------

# git
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

# Google Cloud
load_current_gcp_config() {
  local config_path="$HOME/.config/gcloud/active_config"
  if [ -f $config_path ]; then
    GCP_PROFILE=$(cat $config_path)
  fi
}

precmd() {
    psvar=()
    load_current_gcp_config
    psvar[1]=$GCP_PROFILE
}

local p_gcp="[gcp:%1v]"


# プロンプトカスタマイズ
PROMPT='[%F{cyan}@%n%f%F{green}%~%f]%F{cyan}$vcs_info_msg_0_%f
$ '
