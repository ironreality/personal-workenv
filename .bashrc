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
export PROMPT_COMMAND="history -a; history -c; history -r;"

#set vi keyboard mode
set -o vi

# a proper shell variable expansion while shell completion
# https://askubuntu.com/questions/70750/how-to-get-bash-to-stop-escaping-during-tab-completion
shopt -s direxpand

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

export GREP_COLORS='ms=01;31:mc=01;31:sl=:cx=:fn=0;49;92:ln=32:bn=32:se=36'

export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$GOROOT/bin:/home/yamato/.local/bin:/usr/local/go/bin:/usr/local/share/dotnet:/bin:/sbin:/usr/bin:/usr/sbin

# Go
export GOPATH=$HOME
export PATH=$PATH:$(go env GOPATH)/bin

# Kubebuilder
export PATH=$PATH:/usr/local/kubebuilder/bin

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

export HISTFILESIZE=500000
export HISTSIZE=100000
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

#############  Shell promt ################
export PS1='\[\e[37;1m\][\[\e[35;1m\]\u@\H\[\e[37;1m\]][\w]\[\e[m\]:'

# cyan color in prompt
# export PS1='\[\e[0;36m\][\u@\H][\w]\[\e[m\]:'

############## functions #################

myip() { curl -s http://ipinfo.io/ip; }
myspeed() { wget --output-document=/dev/null http://speedtest.wdc01.softlayer.com/downloads/test500.zip; }

# notify shortcut
jobdone() { echo "DONE!" | mail -s "$(hostname): ${1:-Your job is done} [NOSR]" ${2:-ironreality@gmail.com}; }

#shortcut functions
apg_() { $(which apg) -M NC -m $1 -x $1 -n $2; }
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
alias ipcalc='ipcalc --nocolor'

alias d='dirs -v'
alias pu="pushd"
alias po="popd"

# Teraform & Packer related

alias tf='terraform12'

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
#export TF_LOG=WARN
export TF_LOG_PATH="/tmp/terraform.log"

# http://www.cyberciti.biz/faq/linux-which-process-is-using-swap/
alias show_swap_usage='for file in /proc/*/status ; do awk '\''/VmSwap|Name/{printf $2 " " $3}END{ print ""}'\'' $file; done | sort -k 2 -n -r | less'
alias swapclean='sudo swapoff /dev/mapper/mint--vg-swap_1 && sudo swapon /dev/mapper/mint--vg-swap_1'

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

# get shell in pod
kshp() {
	kubectl exec $* -it -- bash || { echo "Bash has failed, trying connect with sh..."; kubectl exec $* -it -- sh; }
}

kcurl() {
  kubectl run --generator=run-pod/v1 --rm testcurl --image=yauritux/busybox-curl -it
}

# a network trouble-shooting container - https://github.com/nicolaka/netshoot
knetshoot() {
  if [[ $1 == '-host' ]]; then
    hostnet='"spec": {"hostNetwork": true}'
  else
    hostnet=
  fi

  #kubectl run --generator=run-pod/v1 tmp-shell --rm -i --tty --overrides='{'"$hostnet"'}' --image nicolaka/netshoot -- /bin/bash
  kubectl run tmp-shell --rm -i --tty --image nicolaka/netshoot -- /bin/bash
}

# autocompletion for k8s objects
_kube_get_nodes()
{
  local curr_arg;
  curr_arg=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $(compgen -W "$(kubectl get nodes --no-headers | awk '{print $1}')" -- $curr_arg ) );
}

_kube_get_namespaces()
{
  local curr_arg;
  curr_arg=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $(compgen -W "$(kubectl get namespaces --no-headers | awk '{print $1}')" -- $curr_arg ) );
}

_kube_get_pods()
{
  local curr_arg;
  curr_arg=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $(compgen -W "$(kubectl get pods --no-headers | awk '{print $1}')" -- $curr_arg ) );
}

_kube_get_deployments()
{
  local curr_arg;
  curr_arg=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $(compgen -W "$(kubectl get deployments --no-headers | awk '{print $1}')" -- $curr_arg ) );
}

_kube_get_services()
{
  local curr_arg;
  curr_arg=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $(compgen -W "$(kubectl get deployments --no-headers | awk '{print $1}')" -- $curr_arg ) );
}

_kube_get_secrets()
{
  local curr_arg;
  curr_arg=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $(compgen -W "$(kubectl get secrets --no-headers | awk '{print $1}')" -- $curr_arg ) );
}

_kube_get_configmaps()
{
  local curr_arg;
  curr_arg=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $(compgen -W "$(kubectl get cm --no-headers | awk '{print $1}')" -- $curr_arg ) );
}

alias k='kubectl'
alias ns='kubens'
alias kaf='kubectl apply -f'
alias kdf='kubectl delete -f'
alias kl='kubectl logs --all-containers'

alias kga='kubectl get all'
alias kgaa='kubectl get all --all-namespaces'
alias kgp='kubectl get pods'
alias kgpo='kubectl get pods -o=yaml'
alias kgs='kubectl get services' 
alias kgso='kubectl get services -o=yaml'
alias kgsc='kubectl get secrets'
alias kgsco='kubectl get secrets -o=yaml'
alias kgcm='kubectl get cm'
alias kgcmo='kubectl get cm -o=yaml'
alias kgns='kubectl get namespaces'
alias kgnso='kubectl get namespaces -o=yaml'
alias kgd='kubectl get deploy' 
alias kgdo='kubectl get deploy -o=yaml'
alias kgr='kubectl get rs' 
alias kgn='kubectl get nodes' 
alias kgno='kubectl get nodes -o=yaml'
alias kgj='kubectl get jobs' 
alias kgc='kubectl get cronjobs'

alias kdp='kubectl describe pod'
alias kds='kubectl describe services' 
alias kdsc='kubectl describe secrets'
alias kdns='kubectl describe namespaces'
alias kdn='kubectl describe nodes' 
alias kdd='kubectl describe deploy' 
alias kdr='kubectl describe rs' 
alias kdj='kubectl describe jobs' 
alias kdc='kubectl describe cronjobs'

alias ktn='kubectl top nodes'
alias ktp='kubectl top pods'

complete -F _kube_get_pods kgp kgpo kdp ktp kshp kl
complete -F _kube_get_services kgs kgso kds
complete -F _kube_get_secrets kgsc kgsco kdsc
complete -F _kube_get_configmaps kgcm kgcmo kdcm
complete -F _kube_get_deployments kgd kgdo kdd
complete -F _kube_get_nodes kgn kgno kdn ktn
complete -F _kube_get_namespaces ns kgns kgnso kdns

alias kt='kubectx'
alias kctx='kubectx'


alias kb='/usr/local/bin/kubie'
kb-init() {
  kubie ctx -f $KUBECONFIG
}

### FINAL ACTIONS BELOW ###

# direnv - https://direnv.net/
eval "$(direnv hook bash)"

# k8s completions
source <(kubectl completion bash | sed s/kubectl/k/g)

# helm completions
source <(helm completion bash)

# stern completions
source <(stern --completion=bash)

# eksctl
source <(eksctl completion bash)

# skaffold
source <(skaffold completion bash)

# ko
# source <(ko completion)

# Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
export WORKON_HOME=~/src/.virtualenvs

# Node.js
source $(brew --prefix nvm)/nvm.sh

# Podman
#alias docker=podman

# Java
#export JAVA_HOME=$(/usr/libexec/java_home -v 11.0.12)

# krew
export PATH="${PATH}:${HOME}/.krew/bin"
source <(kubectl krew completion bash)

# kyverno-cli
source <(kubectl kyverno completion bash)

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
