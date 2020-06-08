export TERM="xterm-256color"
export ZSH=/home/op/.oh-my-zsh

ZSH_THEME="nicoulaj"
plugins=(dircycle github z autojump rails archlinux zsh-navigation-tools docker vagrant cp ruby)

source $ZSH/oh-my-zsh.sh
source $HOME/bin/tmux-splash.sh
source ~/.profile

function bin2sc {
    # convert .bin to shellcode
    hexdump -v -e '"\\""x" 1/1 "%02x" ""' ${1}
}

function dockershell() {
    docker run --rm -i -t --entrypoint=/bin/bash "$@"
}

function dockershellsh() {
    docker run --rm -i -t --entrypoint=/bin/sh "$@"
}

function dockershellhere() {
    dirname=${PWD##*/}
    docker run --rm -it --entrypoint=/bin/bash -v `pwd`:/${dirname} -w /${dirname} "$@"
}

function dockershellshhere() {
    docker run --rm -it --entrypoint=/bin/sh -v `pwd`:/${dirname} -w /${dirname} "$@"
}

function dockerwindowshellhere() {
    dirname=${PWD##*/}
    docker -c 2019-box run --rm -it -v "C:${PWD}:C:/source" -w "C:/source" "$@"
}

function impacket() {
    docker run --rm -it rflathers/impacket "$@"
}

function smbservehere() {
    local sharename
    [[ -z $1 ]] && sharename="SHARE" || sharename=$1
    docker run --rm -it -p 445:445 -v "${PWD}:/tmp/serve" rflathers/impacket smbserver.py -smb2support $sharename /tmp/serve
}

function nginxhere() {
    docker run --rm -it -p 80:80 -p 443:443 -v "${PWD}:/srv/data" rflathers/nginxserve
}

function webdavhere() {
    docker run --rm -it -p 80:80 -v "${PWD}:/srv/data/share" rflathers/webdav
}

function metasploit() {
    docker run --rm -it  --network=host metasploitframework/metasploit-framework ./msfconsole "$@"
}

function msfvenomhere() {
    docker run --rm -it -v "${HOME}/.msf4:/home/msf/.msf4" -v "${PWD}:/data" metasploitframework/metasploit-framework ./msfvenom "$@"
}

function reqdump() {
    docker run --rm -it -p 80:3000 rflathers/reqdump
}

function postfiledumphere() {
    docker run --rm -it -p80:3000 -v "${PWD}:/data" rflathers/postfiledump
}

export EDITOR='vim'
export GOPATH=/home/op/go 
export TERM="xterm-256color"
export HOME=/home/op
export PATH="$PATH:$HOME/.rvm/bin:/home/op/go/bin:/home/op/bin" # Add RVM to PATH for scripting

export BIG="/home/op/lists/seclists/Discovery/Web-Content/big.txt"
export WEB="/home/op/lists/seclists/Discovery/Web-Content/"
export DIRS_LARGE="/home/op/lists/seclists/Discovery/Web-Content/raft-large-directories.txt"
export DIRS_SMALL="/home/op/lists/seclists/Discovery/Web-Content/raft-small-directories.txt"
export FILES_LARGE="/home/op/lists/seclists/Discovery/Web-Content/raft-large-files.txt"
export FILES_SMALL="/home/op/lists/seclists/Discovery/Web-Content/raft-small-files.txt"

alias ls=" ls --color -sh"
alias wclone="wget -H -p -k"
alias vim="nvim"


# added by pipsi (https://github.com/mitsuhiko/pipsi)
export PATH="/home/op/.local/bin:$PATH"
source /home/op/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# added by pipsi (https://github.com/mitsuhiko/pipsi)
export PATH="/home/op/.local/bin:$PATH"
export PATH="$PATH:/home/op/.axiom/interact"
