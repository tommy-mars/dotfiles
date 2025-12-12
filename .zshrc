alias y='yazi'
alias zvi='vim ~/.zshrc'
alias so='source ~/.zshrc'
alias co='code .'
alias my='cd ~/'
alias des='cd ~/Desktop'
alias dl='cd ~/Downloads'
alias brdp='brew bundle dump --global'

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

function cdghq() {
    moveto=$(ghq root)/$(ghq list | fzf)

    if [[ "${moveto}" != "$(ghq root)/" ]]
    then
       cd $moveto
    fi
}
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
