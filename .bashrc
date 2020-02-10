#
# ~/.bashrc
#

### Aliases
alias ll='exa --long --all --git --header'
alias aws='aws2'

### Init NVM
source /usr/share/nvm/init-nvm.sh

### Misc Environment Variables
export QT_QPA_PLATFORMTHEME='qt5ct'

### better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"

### initialize starship prompt
eval "$(starship init bash)"
