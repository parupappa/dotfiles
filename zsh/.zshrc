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

# カラーの有効化
autoload -U colors && colors

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

# -----------------------------
# Software setting
# -----------------------------
eval "$(rbenv init - zsh)"
# mise
eval "$(/opt/homebrew/bin/mise activate zsh)"

# ------------------------------
# Path setting
# ------------------------------

# krewのパスを設定
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
# homebrewのパスを設定
export PATH="/opt/homebrew/bin:$PATH"
# gcloudのパスを設定
export PATH=$PATH:/opt/homebrew/share/google-cloud-sdk/bin
# gke-gcloud-auth-pluginの使用を設定
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
# GOのPATHを設定
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
export GOPATH=$HOME/go

# ------------------------------
# Alias setting
# ------------------------------

alias tf='terraform'
alias k='kubectl'
alias ll='ls -laG'
alias c='clear'

# colordiff
if [[ -x $(which colordiff) ]]; then
  alias diff='colordiff'
fi

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
    gcloud config configurations list --format='table[no-heading](is_active.yesno(yes="[x]",no="[_]"), name, properties.core.account, properties.core.project.yesno(no="(unset)"))' |
      fzf --select-1 --query="$1" |
      awk '{print $2}'
  )
  if [ -n "$selected" ]; then
    gcloud config configurations activate $selected
  fi
}

# ------------------------------
# Cloud Native Eco System setting
# ------------------------------
# Argo Rollouts
cat <<EOF >kubectl_complete-argo-rollouts
#!/usr/bin/env sh

# Call the __complete command passing it all arguments
kubectl argo rollouts __complete "\$@"
EOF

chmod +x kubectl_complete-argo-rollouts
sudo mv ./kubectl_complete-argo-rollouts /usr/local/bin/

# ------------------------------
# Prompt setting
# ------------------------------

# git
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "!"
zstyle ':vcs_info:git:*' unstagedstr "+"
zstyle ':vcs_info:*' formats "%c%u[%b]"
zstyle ':vcs_info:*' actionformats '[%b|%a]'

# gitのステータスに応じて色を変える関数
set_git_prompt_color() {
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    if [[ $(git status --porcelain 2>/dev/null) = "" ]]; then
      # ワーキングディレクトリがクリーンなら緑色
      GIT_PROMPT_COLOR="%F{green}"
    else
      # 変更があるなら赤色
      GIT_PROMPT_COLOR="%F{magenta}"
    fi
  else
    # Gitリポジトリでない場合は、色をリセット
    GIT_PROMPT_COLOR=""
  fi
}

# Google Cloud
load_current_gcp_config() {
  local config_path="$HOME/.config/gcloud/active_config"
  if [ -f $config_path ]; then
    GCP_PROFILE=$(cat $config_path)
  fi
}

# kubernetes context
load_current_k8s_context() {
  K8S_CONTEXT=$(kubectl config current-context 2>/dev/null)
}

precmd() {
  set_git_prompt_color
  vcs_info
  load_current_gcp_config
  load_current_k8s_context
  psvar=()
  psvar[1]=$vcs_info_msg_0_
  psvar[2]=$GCP_PROFILE
  psvar[3]=$K8S_CONTEXT
}

local p_git="%1v"
local p_gcp="[gcp:%2v]"
local p_k8s="k8s:%3v"

# プロンプトカスタマイズ
PROMPT='[%F{cyan}@%n%f%F{green}%~%f]'${GIT_PROMPT_COLOR}$p_git'%f$p_gcp %{$fg[cyan]%}($p_k8s)%{$reset_color%}
$ '
