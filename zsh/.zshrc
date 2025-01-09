#!/bin/bash

# -----------------------------
# Software setting
# -----------------------------
# mise
eval "$(/opt/homebrew/bin/mise activate zsh)"
# sheldon
eval "$(sheldon source)"
# starship
eval "$(starship init zsh)"

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
