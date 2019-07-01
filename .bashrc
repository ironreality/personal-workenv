####### source global definitions (if any) #############
if [ -f /etc/bash_completion ]; then
. /etc/bash_completion
elif [ -f /usr/local/etc/bash_completion ]; then
. /usr/local/etc/bash_completion
fi

if [ -f ~/.bash_sensitive ]; then
. ~/.bash_sensitive   # --> Read if present.
fi

############  shell options ############
#some readline fun there
export INPUTRC=~/.inputrc

shopt -s checkwinsize

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# Make bash append rather than overwrite the history on disk
shopt -s histappend

# After each command, save and reload history
#export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

#set vi keyboard mode
set -o vi

#complete command after sudo & man
complete -cf sudo
complete -cf man
complete -cf time
complete -cf nice
complete -cf ionice

############## environment ###################
umask 022

export EDITOR=$(which nvim)
export PAGER=$(which less)
export LESS="-R"
#export PAGER=/usr/share/vim/vim80/macros/less.sh
#alias less='/usr/share/vim/vim80/macros/less.sh'

export GREP_COLORS='ms=01;31:mc=01;31:sl=:cx=:fn=0;49;92:ln=32:bn=32:se=36'

export PATH=$HOME/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/opt/bin:$GOROOT/bin:/home/yamato/.local/bin:/usr/local/go/bin

# Go
export GOROOT=/usr/local/go
export GOPATH=$HOME
export PATH=$PATH:$(go env GOPATH)/bin

export HISTFILESIZE=50000
export HISTSIZE=2000
export HISTTIMEFORMAT="%t%d.%m.%y %H:%M:%S%t"
export HISTCONTROL=ignoredups:erasedups

#Mail stuff
shopt -u mailwarn
unset MAILCHECK 

if [ -d ~/Maildir/ ]; then
export MAIL=~/Maildir/
export MAILDIR=~/Maildir/
elif [ -f /var/mail/${USER} ]; then
export MAIL="/var/mail/${USER}"
fi

# Java env
#export CLASSPATH=".:/home/ubuntu/coding/java/TIJ4/code/:/home/yamato/coding/java/TIJ4/code"
export JAVA_HOME=/usr/lib/jvm/java-8-oracle

# Ruby env
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
    
#############  Shell promts ################

if [ "$UID" -eq 0 -a "$USER" = "root" ]
then
    export PS1=''
#if root - red color in prompt
#http://misc.flogisoft.com/bash/tip_colors_and_formatting
    export PS1='\[\e[37;1m\][\[\e[31;1m\]\u@\H\[\e[37;1m\]][\w]\[\e[m\]:'
else
    #else - light blue color in prompt
    export PS1=''
    if [ "$SSH_CONNECTION" ]
    then
        export PS1='\[\e[37;1m\][\[\e[32;1m\]\u@\H\[\e[37;1m\]][\w]\[\e[m\]:'
    else
        export PS1='\[\e[37;1m\][\[\e[35;1m\]\u@\H\[\e[37;1m\]][\w]\[\e[m\]:'
    fi
fi


############## functions #################

#myip() { elinks -dump myip.net | grep 'Your IP Address:'; }
myip() { curl -s http://ipinfo.io/ip; }
myspeed() { wget --output-document=/dev/null http://speedtest.wdc01.softlayer.com/downloads/test500.zip; }
spaty() { /usr/bin/sudo /usr/sbin/pm-hibernate; }

# notify shortcut
jobdone() { echo "DONE!" | mail -s "$(hostname): ${1:-Your job is done} [NOSR]" ${2:-ironreality@gmail.com}; }

#shortcut functions
a() { $(which apg) -M NC -m $1 -x $1 -n $2; }
w() { wget --no-check-certificate -S -O /dev/null "$*"; }
# strace wrapper
str() { strace -vyCTrf -s 1024  -o /tmp/strace.log -p "$1"; }

# count size of directories 
dudu() {
ionice -c 3 nice -n 20 du -x -h --max-depth="$1" "$2" > /tmp/du
sort -h /tmp/du > /tmp/du_sorted
jobdone
}

# remove an old SSH key from known
skr() { ssh-keygen -f "/home/yamato/.ssh/known_hosts" -R ${1}; }

# jump to Docker container
to() { id=${1}; docker exec -it ${id} /bin/bash || docker exec -it ${id} /bin/sh; }

# pull all Git repos & subrepos
git_pull_all() { for i in $(find . -type d -name '.git'); do echo "=== ${i} ==="; cd "${i/.git/}"; git pull; cd -; done; }


################# aliases ###################

alias c='clear'
alias s='set -o vi'
alias hi='history'
alias t='top'
alias i='ip addr'
alias v='nvim -u ~/.vimrc'
alias p='pwd'
alias e='egrep --color'
alias sy='systemctl '
alias sudo='sudo '
alias svim='sudo nvim -u ~/.vimrc'
alias ipcalc='ipcalc --nocolor'

alias d='dirs -v'
alias pu="pushd"
alias po="popd"

# Teraform & Packer related

alias tp='terraform validate . && terraform plan 2>&1 | tee /tmp/tf-plan.log'

# terraform plan wrapper
alias tpf='tp'

ta() {
  time terraform apply "$@" -auto-approve 2>&1 | tee /tmp/tf-apply.log
}

alias tpd='terraform plan -destroy 2>&1 | tee /tmp/tf-plan-destroy.log'
alias td='time terraform destroy -force 2>&1 | tee /tmp/tf-destroy.log'
 
export PACKER_LOG=1
export PACKER_LOG_PATH="/tmp/packer.log"
export TF_LOG=WARN
export TF_LOG_PATH="/tmp/terraform.log"

# http://www.cyberciti.biz/faq/linux-which-process-is-using-swap/
alias show_swap_usage='for file in /proc/*/status ; do awk '\''/VmSwap|Name/{printf $2 " " $3}END{ print ""}'\'' $file; done | sort -k 2 -n -r | less'
alias swapclean='sudo swapoff /dev/mapper/mint--vg-swap_1 && sudo swapon /dev/mapper/mint--vg-swap_1'
#alias verseq='cd ${HOME}/.wine/drive_c/Program\ Files\ \(x86\)/VerseQ/ && wine VerseQ.exe >/dev/null &'

alias kbu='setxkbmap us,ua -option "grp:shifts_toggle"'
alias kbr='setxkbmap us,ru -option "grp:shifts_toggle"'

alias config_show="e -v '(^#|^$|^[[:space:]]+#)'"

alias gb='git branch'
alias gs='git status'
alias gl='git log'
alias gd='git diff'
alias gcm='git checkout master'
alias gpom='git push origin master'

alias h='htop'

alias dps="docker ps"
alias dl="docker logs"

alias k='kubectl'
alias kclusterinfo='kubectl cluster-info'
alias kcontextinfo='kubectl config current-context'

alias kaf='kubectl apply -f'
alias kdf='kubectl delete -f'
alias kl='kubectl logs'

# get shell in pod
kshp() {
	pod=${1}
	kubectl exec -it ${pod} bash || { echo "Bash has failed, trying connect with sh..."; kubectl exec -it ${pod} sh; }
}

alias kdp='kubectl describe pod'
alias ktp='kubectl top pods'

# https://github.com/johanhaleby/kubetail - aggregates logs from multiple pods
alias kt='kubetail'

# autocompletion for pod names
_kubetail()
{
  local curr_arg;
  curr_arg=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $(compgen -W "$(kubectl get pods --no-headers | awk '{print $1}')" -- $curr_arg ) );
}
complete -F _kubetail kubetail kt kl kgp kdp ktp kshp
###

alias kgp='kubectl get pods'
alias kgs='kubectl get services' 
alias kgd='kubectl get deploy' 
alias kgr='kubectl get rs' 
alias kgn='kubectl get nodes' 
alias kgj='kubectl get jobs' 
alias kgc='kubectl get cronjobs'

alias kds='kubectl describe services' 
alias kdn='kubectl describe nodes' 
alias kdd='kubectl describe deploy' 
alias kdr='kubectl describe rs' 
alias kdj='kubectl describe jobs' 
alias kdc='kubectl describe cronjobs'

alias ktn='kubectl top nodes'
alias krlstdpl='kubectl rollout status deployment'

alias g='gcloud'
alias gcil='gcloud compute instances list'
alias gssh='gcloud compute ssh'


# go aliases
alias gob='go build'


### FINAL ACTIONS BELOW ###

# direnv - https://direnv.net/
eval "$(direnv hook bash)"

# k8s completions
source <(kubectl completion bash | sed s/kubectl/k/g)

# helm completions
source <(helm completion bash)
