#!/usr/bin/env python3
"""
MCP サーバー設定を ~/.claude.json に注入するスクリプト。
dotfiles/claude/mcp-servers.json の内容を読み込み、
dotfiles/.env から OBSIDIAN_API_KEY 等のシークレットを展開した上で
~/.claude.json の mcpServers セクションを更新する。
"""
import json
import os
import string
from pathlib import Path

dotfiles_dir = Path(__file__).parent.parent
mcp_file = dotfiles_dir / "claude" / "mcp-servers.json"
claude_json = Path.home() / ".claude.json"

# .env が存在すれば環境変数として読み込む
env_file = dotfiles_dir / ".env"
if env_file.exists():
    for line in env_file.read_text().splitlines():
        line = line.strip()
        if line and not line.startswith("#") and "=" in line:
            key, _, val = line.partition("=")
            os.environ.setdefault(key.strip(), val.strip().strip('"').strip("'"))

# mcp-servers.json の ${VAR} プレースホルダーを展開
mcp_template = mcp_file.read_text()
mcp_expanded = string.Template(mcp_template).safe_substitute(os.environ)
mcp_servers = json.loads(mcp_expanded)

# ~/.claude.json を更新（既存の設定は保持）
if claude_json.exists():
    config = json.loads(claude_json.read_text())
else:
    config = {}

config["mcpServers"] = mcp_servers
claude_json.write_text(json.dumps(config, indent=2, ensure_ascii=False) + "\n")
print("✓ MCP servers injected into ~/.claude.json")
