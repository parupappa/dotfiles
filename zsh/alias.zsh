#!/bin/bash

alias c='clear'
alias reload='exec $SHELL -l'
alias ll='ls -laG'
alias tf='terraform'
alias k='kubectl'

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

alias sa='switch_aws'
alias sg='switch_gcloud'
