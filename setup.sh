#!/bin/bash
# dotfiles セットアップスクリプト: シェル設定の配置、パッケージの一括インストール、macOS 設定の適用
set -euo pipefail

cd "$(dirname "$0")"

# Homebrew 未導入ならインストール
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew が見つからないためインストールします..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# .zshrc を配置（既存があれば .bak として退避）
if [ -e "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
  echo "既存の ~/.zshrc を ~/.zshrc.bak に退避します"
  mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
fi
ln -sf "$(pwd)/.zshrc" "$HOME/.zshrc"
echo "~/.zshrc をシンボリックリンクで配置しました"

# .gitconfig を配置（既存があれば .bak として退避）
if [ -e "$HOME/.gitconfig" ] && [ ! -L "$HOME/.gitconfig" ]; then
  echo "既存の ~/.gitconfig を ~/.gitconfig.bak に退避します"
  mv "$HOME/.gitconfig" "$HOME/.gitconfig.bak"
fi
ln -sf "$(pwd)/.gitconfig" "$HOME/.gitconfig"
echo "~/.gitconfig をシンボリックリンクで配置しました"

# VS Code の settings.json を配置（既存があれば .bak として退避）
VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
mkdir -p "$VSCODE_USER_DIR"
if [ -e "$VSCODE_USER_DIR/settings.json" ] && [ ! -L "$VSCODE_USER_DIR/settings.json" ]; then
  echo "既存の VS Code settings.json を settings.json.bak として退避します"
  mv "$VSCODE_USER_DIR/settings.json" "$VSCODE_USER_DIR/settings.json.bak"
fi
ln -sf "$(pwd)/vscode/settings.json" "$VSCODE_USER_DIR/settings.json"
echo "VS Code の settings.json をシンボリックリンクで配置しました"

# Homebrew パッケージを一括インストール
echo "brew bundle install を実行します..."
brew bundle install --file=.Brewfile

# macOS の設定を適用
echo "macos.sh を実行します..."
./macos.sh

echo "セットアップが完了しました。新しいシェルを開くか 'source ~/.zshrc' を実行してください。"
