#!/bin/bash

# -----------------------------
# Software setting
# -----------------------------
# rbenv
eval "$(rbenv init - zsh)"
# mise
eval "$(/opt/homebrew/bin/mise activate zsh)"
# starship
eval "$(starship init zsh)"
# sheldon
eval "$(sheldon source)"
# zshの読み込み時間を表示するときはコメントアウトを外す
zmodload zsh/zprof

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

# # git
# autoload -Uz vcs_info
# setopt prompt_subst
# zstyle ':vcs_info:git:*' check-for-changes true
# zstyle ':vcs_info:git:*' stagedstr "!"
# zstyle ':vcs_info:git:*' unstagedstr "+"
# zstyle ':vcs_info:*' formats "%c%u[%b]"
# zstyle ':vcs_info:*' actionformats '[%b|%a]'

# # gitのステータスに応じて色を変える関数
# set_git_prompt_color() {
#   if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
#     if [[ $(git status --porcelain 2>/dev/null) = "" ]]; then
#       # ワーキングディレクトリがクリーンなら緑色
#       GIT_PROMPT_COLOR="%F{green}"
#     else
#       # 変更があるなら赤色
#       GIT_PROMPT_COLOR="%F{magenta}"
#     fi
#   else
#     # Gitリポジトリでない場合は、色をリセット
#     GIT_PROMPT_COLOR=""
#   fi
# }

# # Google Cloud
# load_current_gcp_config() {
#   local config_path="$HOME/.config/gcloud/active_config"
#   if [ -f $config_path ]; then
#     GCP_PROFILE=$(cat $config_path)
#   fi
# }

# # kubernetes context
# load_current_k8s_context() {
#   K8S_CONTEXT=$(kubectl config current-context 2>/dev/null)
# }

# precmd() {
#   set_git_prompt_color
#   vcs_info
#   load_current_gcp_config
#   load_current_k8s_context
#   psvar=()
#   psvar[1]=$vcs_info_msg_0_
#   psvar[2]=$GCP_PROFILE
#   psvar[3]=$K8S_CONTEXT
# }

# local p_git="%1v"
# local p_gcp="[gcp:%2v]"
# local p_k8s="k8s:%3v"

# # プロンプトカスタマイズ
# PROMPT='[%F{cyan}@%n%f%F{green}%~%f]'${GIT_PROMPT_COLOR}$p_git'%f$p_gcp %{$fg[cyan]%}($p_k8s)%{$reset_color%}
# $ '
