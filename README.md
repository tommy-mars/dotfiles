# dotfiles

macOS の個人環境設定を管理するリポジトリ。シェル設定、Homebrew のパッケージ一覧、macOS の各種設定をバージョン管理している。

## 収録ファイル

| ファイル | 内容 |
|---|---|
| `.zshrc` | Zsh の設定（PATH、プラグイン、エイリアスなど） |
| `.Brewfile` | Homebrew でインストールする formula / cask / Mac App Store アプリの一覧 |
| `macos.sh` | `defaults write` による macOS のシステム設定（キーボード、Finder、Dock など） |
| `setup.sh` | シェル設定の配置、パッケージの一括インストール、macOS 設定の適用をまとめて行うセットアップスクリプト |

## セットアップ

新しいマシンでの復元手順。

### 1. リポジトリを取得

```sh
# ghq を使う場合
ghq get tommy-mars/dotfiles

# もしくは通常の clone
git clone https://github.com/tommy-mars/dotfiles.git
```

### 2. セットアップスクリプトを実行

`setup.sh` が Homebrew の導入確認、`.zshrc` の配置（シンボリックリンク）、`.Brewfile` からのパッケージ一括インストール、`macos.sh` による macOS 設定の適用をまとめて行う。

```sh
./setup.sh
```

#### 手動で行う場合

```sh
# シェル設定を配置（コピーまたはシンボリックリンク）
cp .zshrc ~/.zshrc
# または
ln -s "$(pwd)/.zshrc" ~/.zshrc

# Homebrew 未導入なら先にインストール
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# .Brewfile から一括インストール
brew bundle install --file=.Brewfile

# macOS の設定を適用
./macos.sh
```

## メンテナンス

### 現在の環境を `.Brewfile` に反映

パッケージを追加・削除したら、現状をダンプして差分をコミットする。

```sh
brew bundle dump --no-describe --force --file=.Brewfile
git add .Brewfile
git commit -m "update .Brewfile"
git push
```

### `.zshrc` を更新

```sh
cp ~/.zshrc .zshrc
git add .zshrc
git commit -m "update .zshrc"
git push
```

### `macos.sh` を更新

`defaults write` を追記・修正したら、実機で反映確認のうえコミットする。

```sh
./macos.sh
git add macos.sh
git commit -m "update macos.sh"
git push
```
