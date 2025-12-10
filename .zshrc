alias y=yazi
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

function cdghq() {
    moveto=$(ghq root)/$(ghq list | fzf)

    if [[ "${moveto}" != "$(ghq root)/" ]]
    then
       cd $moveto
    fi
}
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
