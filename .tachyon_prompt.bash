###
 # .tachyon_prompt.bash
 # Tachyon Bash Prompt
 ##

## PS1 Bash Prompt Constants
Reset="\[\e[0m\]"
Break=$(echo -e "\xE2\x96\xB6")

# Colors
if tput setaf 1 &> /dev/null; then
  # Reset all current colors
  tput sgr0;
  bold="\[$(tput bold)\]"
  Reset="\[$(tput sgr0)\]"
  
  # Solarized colors, taken from 'https://git.io/solarized-colors'.
  Black="\[$(tput setaf 0)\]"
  Blue="\[$(tput setaf 33)\]"
  Cyan="\[$(tput setaf 37)\]"
  Green="\[$(tput setaf 64)\]"
  Orange="\[$(tput setaf 166)\]" ##E05F27
  Purple="\[$(tput setaf 125)\]"
  Red="\[$(tput setaf 124)\]"
  Violet="\[$(tput setaf 61)\]"
  White="\[$(tput setaf 15)\]"
  Yellow="\[$(tput setaf 136)\]"

  # Bold colors.
  BBlack="\[$(tput bold)\]${Black}"
  BWhite="\[$(tput bold)\]${White}"
else
  Black="\[\e[0;30m\]"
fi;

function get_dir {
  pwd | sed s.$HOME.~.g | awk -F"/" '
  BEGIN { ORS="/" }
  END {
    for (i=1; i <= NF; i++) {
      if ((i == 1 && $1 != "") || i == NF-1 || i == NF) {
        print $i
      }
    else if (i == 1 && $1 == "") {
        print "/"$2
        i++
      }
      else {
        print ".."
      }
    }
  }'
}

user=$(whoami)
host=$(hostname)
export PS1="$Yellow${user:0:6}$BWhite@${host:0:6}$Break$Cyan[\$(get_dir)]$Green\[(\$(git rev-parse --abbrev-ref HEAD 2> /dev/null))\]\n$Green:$Reset "

