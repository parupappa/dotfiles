#!/bin/bash

# homebrewのパスを設定
export PATH="/opt/homebrew/bin:$PATH"

# krewのパスを設定
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
# gcloudのパスを設定
export PATH=$PATH:/opt/homebrew/share/google-cloud-sdk/bin
# gke-gcloud-auth-pluginの使用を設定
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
# GOのPATHを設定
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
export GOPATH=$HOME/go
