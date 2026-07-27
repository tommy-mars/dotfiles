#!/bin/bash
# macOS 環境設定スクリプト: 実機の defaults 設定をコマンド化したもの
set -euo pipefail

echo "macOS の設定を適用します..."

###############################################################################
# キーボード                                                                  #
###############################################################################

# キーリピートを有効化し、リピート速度・開始までの時間を高速化
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# 自動大文字化・ピリオド自動置換・スペル自動修正を無効化
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool false

###############################################################################
# 全般                                                                        #
###############################################################################

# すべてのファイル拡張子を表示
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# 操作音のフラッシュ表示を無効化
defaults write NSGlobalDomain com.apple.sound.beep.flash -bool false

###############################################################################
# Finder                                                                      #
###############################################################################

# 隠しファイルを表示
defaults write com.apple.finder AppleShowAllFiles -bool true

# パスバーとウインドウタイトルへのフルパス表示
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# デフォルトのビューをアイコン表示に
defaults write com.apple.finder FXPreferredViewStyle -string "icnv"

# ゴミ箱の古いアイテムを自動削除
defaults write com.apple.finder FXRemoveOldTrashItems -bool true

# ネットワーク・USBボリュームに .DS_Store を作成しない
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

###############################################################################
# Dock                                                                        #
###############################################################################

# 画面左側に配置し、アイコンサイズを縮小
defaults write com.apple.dock orientation -string "left"
defaults write com.apple.dock tilesize -int 65

###############################################################################
# 設定の反映                                                                  #
###############################################################################

for app in "Finder" "Dock"; do
  killall "${app}" &>/dev/null || true
done

echo "macOS の設定を適用しました。一部の項目は再ログインが必要な場合があります。"
