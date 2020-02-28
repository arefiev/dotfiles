#
# Mikhail Arefiev's zsh config
#
# Some definitions are stolen from other configs.  Original authors
# are credited wherever I could remember where I stole what.
#
# .zshrc is sourced in interactive shells.  It
# should contain commands to set up aliases, functions,
# options, key bindings, etc.
#


# Search path for the cd command
#cdpath=(.. ~ ~/src ~/zsh)

# Use hard limits, except for a smaller stack and no core dumps

unlimit
limit stack 8192
limit core 0
limit -s

umask 022



### ####################################################################
### Aliases!

# Set up aliases
alias cdp='cd -'                 # cd to the previous directory
alias cdr='cd `pwd -P`'          # cd to the real directory path (not symlinked)
alias dc=cd
alias c=cd
alias j=jobs
alias q='echo $?'
alias pu=pushd
alias po=popd
alias zstyle='noglob zstyle'
alias h=history
#alias grep=egrep
alias mv='nocorrect mv -i'       # no spelling correction on mv
alias mvv='nocorrect mv -vi'     # no spelling correction on mv
alias mkdir='nocorrect mkdir'    # no spelling correction on mkdir
alias cp='nocorrect cp -i'       # no spelling correction on cp
alias cpr='cp -Rv'
alias rp='rsync    --progress                    -aAxX -u '   # A good replacement for cp.
alias rpr='rsync   --progress                    -aAxX -u -r' # A good replacement for cp -r.
alias rpp='rsync   --progress --partial --append -aAxX -u '   # Can resume copying.
alias rppr='rsync  --progress --partial --append -aAxX -u -r' # Can resume copying.
alias mmv='noglob zmv -W'        # E. g. mmv prons(.*).avi $1/
alias curl='nocorrect noglob curl'

alias l='ls'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -al'
alias llh='ls -lh'
alias llt='ls -lt'
alias lth='ls -lth'
alias lsd='ls -ld *(-/DN)'  # List dirs and symlinks that point to dirs.
alias lsda='ls -ld .*'      # List dotfiles only.
alias lat='ls -tlu --time-style=full-iso'  # Sort by access time.

alias rm='rm -i'
alias rmr='rm -r'
alias rmf='nocorrect rm -f'
alias rmrf='nocorrect rm -fR'
alias mf='echo "No."'

alias dfh="df -h"
#alias du="du -h" # See ``function fn'' below.
alias t='tree'

alias g='git'
alias ga='git add'
alias gap='git add -p'  # Interactive patch mode.  USE IT, PLEASE.
alias gc='git checkout'
alias gd='git diff'
alias gds='git diff --staged'
alias gs='git status'
alias gpp='git pull ; git push'
alias gco='git checkout'
alias gsu='git submodule update --recursive --init'
alias gsrs='git submodule foreach "git reset --hard"'

alias gri='nocorrect grep -E -rI --color=always --exclude-dir=.git'

alias r='run-mailcap'
alias nicedate='date +%Y%m%d.%H%M.%s'
#alias vi=$EDITOR # :3
#alias vim=$EDITOR # :3
alias e=$EDITOR
alias se=sudoedit
alias u='urxvtc&'
alias no='nocorrect noglob no'

alias ec='emacsclient -ct'
alias fixperms-644-755='find . -type d -exec chmod 0755 {} \; &&  \
                        find . -type f -exec chmod 0644 {} \;'
alias passwordize='md5sum | sed "s/  -//g" | base64 | sed -r "s/^.{32}//g"'
alias ndate='date +%Y-%m-%d_%H:%M:%S%z'     # Close to ISO.
alias sdate='date +%s'                      # Unix epoch.
alias nsdate='date +%Y-%m-%d_%H:%M:%S%z_%s' # Close to ISO + epoch.
alias expr='noglob expr'
alias apropos='apropos -a'
alias sx='screen -x ; kill -9 $$'
alias make='nocorrect make'
alias cdiff='colordiff -u'
alias exifprobe='exifprobe -c'
alias cal='ncal -M'
alias catwin='iconv -f CP1251 '
alias catdos='iconv -f CP866 '
alias nobuf='stdbuf -i0 -o0 -e0'
alias locksleep='xlock & ; sleep 2 ; sudo acpitool -s'
alias ghcicore="ghci -ddump-simpl -dsuppress-idinfo -dsuppress-coercions -dsuppress-type-applications -dsuppress-uniques -dsuppress-module-prefixes"
alias sep='pushd /tmp ; zile "||||||||||" ; popd'

# Crappy autocorrection.  Delete it after the issue has been resolved.
# http://unix.stackexchange.com/questions/36061/
alias sudo='nocorrect sudo'
alias killall='nocorrect killall'
alias man='nocorrect man'
alias ssh='nocorrect ssh'
alias sshfs='nocorrect sshfs'

# Kill the shell without writing history, unless the incremental history writing option is set.  Very portable!
alias s='kill -9 $$'

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

# Global aliases (can be used in any position in a command string).
alias -g H='| head -n'
alias -g T='| tail -n'
alias -g CD='| colordiff'
alias -g CDL='| colordiff | less'
alias -g G='| nocorrect grep -E --color=auto'
alias -g N='> /dev/null '
alias -g NE=' 2> /dev/null '
alias -g PERR=' 1> /dev/null 2>&1 '
alias -g L='| less '
alias -g W='| wc '
alias -g WL='| wc -l '
alias -g WC='| wc -m '
alias -g S='| sed -r '
alias -g SN="| sed -r 's/\\\\n/\\n/g'"
alias -g HD='| hd '
alias -g COL='| sed -r "s/(.{50,78} *) /\1\n/g"' # Columnize (78 chars).
alias -g X='| xargs '
alias -g X0='| xargs -0 '
alias -g J='| jq -S '
alias -g NO='&& kill -9 $$ || no 1 failed to execute command'



### ####################################################################
### Variables!

# Where to look for autoloaded function definitions
fpath=($fpath ~/.zfunc)

## Named dirs.
#Ds=${HOME}/Downloads
#p=${HOME}/projects
#s=${HOME}/src
#: ~Ds ~p ~s

# Autoload all shell functions from all directories in $fpath (following
# symlinks) that have the executable bit on (the executable bit is not
# necessary, but gives you an easy way to stop the autoloading of a
# particular shell function). $fpath should not be empty for this to work.
for func in $^fpath/*(N-.x:t); autoload $func

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

#manpath=($X11HOME/man /usr/man /usr/lang/man /usr/local/man)
manpath="/usr/man:/usr/share/man:/usr/local/man:/usr/X11R6/man:/opt/qt/doc"
export MANPATH

# Hosts to use for completion (see zstyle below).
hosts=(`hostname`)

# Set prompts
#PROMPT='%m%# '    # default prompt
#PROMPT='[ %n@%m ] %B%~%#%b '
#PROMPT=' %n@%m: %~%# '
PROMPT=' %n@%m: %~%#%1(j. %F{3}j%j%F{reset}.) '

#RPROMPT=' %~'     # prompt for right side of screen
#RPROMPT=' %T %y%b'
PROMPT2='%i> '
SPROMPT="change %R to %r-nyae? "

if test $UID = 0
    then PS1="%B %n@%m: %~%#%b "
fi

if test $SSH_TTY ; then
	MD5CMD=$(command -v md5sum || command -v md5)
	# We use (& 6) instead of (& 7) because 7 will give us red and white.
	# Right now 4 combinations are possible, which means 16 different
	# color pairs for two colors, and 64 triples for three colors.
	SSH_COLOR_1=$[ 16#$(echo $(hostname) abbab | $MD5CMD | cut -c1-8 ) & 7 + 8]
	SSH_COLOR_2=$[ 16#$(hostname               | $MD5CMD | cut -c1-8 ) & 7 + 8]
	SSH_COLOR_3=$[ 16#$(echo $(hostname) etete | $MD5CMD | cut -c1-8 ) & 7 + 8]
	PS1=" %F{$SSH_COLOR_3}%n%F{reset}@%F{$SSH_COLOR_2}%m%F{reset}: %~%#%1(j. %F{3}j%j%F{reset}.) "
	unset MD5CMD
	unset SSH_COLOR_1
	unset SSH_COLOR_2
	unset SSH_COLOR_3
fi

# Some environment variables
export MAIL=/var/spool/mail/$USERNAME
#export LESS=-cex3M
export LESS="-R"
export HELPDIR=/usr/local/lib/zsh/help  # directory for run-help function to find docs

MAILCHECK=300
HISTSIZE=8000
SAVEHIST=16000
DIRSTACKSIZE=20
HISTFILE=~/.zhistory

# Watch for my friends
#watch=( $(<~/.friends) )       # watch for people in .friends file
watch=(notme)                   # watch for everybody but me
LOGCHECK=60                     # check every 5 min for login/logout activity
WATCHFMT='%n %a %l from %m at %t.'
NICEDATEFMT='+%Y-%m-%d_%H-%M-%s' # Left for compatibility.  Do not use.



### ####################################################################
### Zsh options!

# Set/unset  shell options
setopt  notify globdots correct pushdtohome autolist 
setopt  correctall
setopt  autocd         # cd to a directory when "executing" it.
setopt  recexact longlistjobs
setopt  autoresume
setopt  histignoredups pushdsilent noclobber
setopt  autopushd pushdminus mailwarning
setopt  extendedglob
setopt  rcquotes       # Apostrophes inside '' by doubling ': '''' -> '
#setopt  cdablevars     # <--- Very annoying.  Never turn it on.
setopt  shortloops     # for i in * ; echo $i
setopt  ignoreeof      # Ignore ^D.
setopt  dvorak         # Better typo handling.
setopt	nobeep
setopt  noautoresume   # Don't fg a running program when I launch another instance.

setopt  multios  # Allow multiple >s and >>s (zsh will invoke implicit `tee`).
setopt  interactive_comments

unsetopt  flow_control  # Disable ^S and ^Q.
unsetopt bang_hist      # Disable "!"
unsetopt bgnice autoparamslash

setopt	hist_ignore_all_dups
setopt	hist_ignore_space
setopt	hist_reduce_blanks
setopt	append_history

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile
#zmodload zsh/complist				# menu select
autoload -U select-word-style
select-word-style bash
autoload -U edit-command-line
zle -N edit-command-line



### ####################################################################
### Key bindings!

# Some nice key bindings
bindkey '^X^Z' universal-argument ' ' magic-space
#bindkey '^Xa' _expand_alias
#bindkey '^Z' accept-and-hold
#bindkey -s '\M-/' \\\\
#bindkey -s '\M-=' \|
bindkey '^X^K' kill-region

disable r                  # stop executing my last stuff
bindkey -e                 # emacs key bindings
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to_expand
bindkey '^U' edit-command-line
bindkey "^['" forward-char

case $TERM in
	linux)
	bindkey "^[[2~" yank
	bindkey "^[[3~" delete-char
	bindkey "^[[5~" up-line-or-history
	bindkey "^[[6~" down-line-or-history
	bindkey "^[[1~" beginning-of-line
	bindkey "^[[4~" end-of-line
	bindkey "^[e" expand-cmd-path ## C-e for expanding path of typed command
	bindkey "^[[A" up-line-or-search     ## !!! Up arrow for back-history-search
	bindkey "^[[B" down-line-or-search   ## !!! Down arrow for fwd-history-search
	bindkey " " magic-space ## do history expansion on space
	;;
	*xterm*|urxvt|rxvt*|(dt|k|E)term)
	bindkey "^[[2~" yank
	bindkey "^[[3~" delete-char
	bindkey "^[[5~" up-line-or-history
	bindkey "^[[6~" down-line-or-history
	bindkey "^[[7~" beginning-of-line
	bindkey "^[[8~" end-of-line
	bindkey "^[e" expand-cmd-path ## C-e for expanding path of typed command
	bindkey "^[[A" up-line-or-search     ## !!! Up arrow for back-history-search
	bindkey "^[[B" down-line-or-search   ## !!! Down arrow for fwd-history-search
	bindkey " " magic-space ## do history expansion on space
	;;
esac



### ####################################################################
### Completion!

autoload -U compinit
autoload zmv
compinit

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
zstyle '*' hosts $hosts

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
#zstyle ':completion:*:functions' ignored-patterns '_*'

# Testing other completions.
zstyle ':completion:*' accept-exact-dirs 'true'
zstyle ':completion:*' ambiguous 'true'
#zstyle ':completion:*' list-dirs-first 'true'
#zstyle ':completion:*' accept-exact 'true'



### ####################################################################
### Functions!

# Shell functions
function setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }  # csh compatibility
function freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done }

# Search titles of RFCs for a keyword.  Works on Debian.
function rfcs() {
    local INDEX='/usr/share/doc/RFC/rfc-index.txt.gz'
    if [ $1 = "-i" ] ; then
        zgrep -i $2 ${INDEX}
    else
        zgrep $1 ${INDEX}
    fi
}

# Cat an RFC by its number.  Works on Debian.
function rfc() {
	local LOCATION='/usr/share/doc/RFC/links'
	local RFC=${LOCATION}/rfc${1//[^0-9]/}.txt.gz
	if [ -e $RFC ] ; then
		zcat ${LOCATION}/rfc${1//[^0-9]/}.txt.gz
	else
		echo "RFC $1 not found."
	fi
}

# This is an incredibly useful function which I wholeheartedly
# recommend for regular use.  I forgot where the idea came from.
# Works on Zsh.  Does not work elsewhere, AFAIK.
function windows() {
	clear
	echo -e "Microsoft Windows 2000 [Version 5.00.2195]\n(c) Microsoft Corporation, 1985-2000.\n"
	function precmd() {
		PWD=$(pwd)
		PWD=${PWD/\/usr/\/Program Files}
		PWD=${PWD/\/home\/$(whoami)/\/Documents and Settings\\Administrator}
		PWD=${PWD/\/home/\/Documents and Settings}
		PWD=${PWD/\/sbin/\/Windows}
		export PS1="C:${PWD//\//\\}> "
	}
}

# Show grand total if multiple args were supplied.
# Good for looking how much space is occupied by a number
# of files.
function du() {
	echo $#
	if [[ $# > 1 ]] ; then
		/usr/bin/du -hc $@
	else
		/usr/bin/du -h $@
	fi
}

function mkcd() {
	mkdir $1
	cd $1
}

function cdu() {
	colordiff -u $1 $2 | less
}

function flip() {
	echo "$2" "$1"
}

# Unpacks all archives and creates a root directory if the archive has
# no single root directory.  It is needed for stupid zips that spam
# hundreds of files in cwd because the windows lusers who made them
# didn't bother with directory structure.
# To add more formats, add a detector 'if' to DETECTORS and then
# appropriate CKCMD and UNPKCMD to 'case $FORMAT'.
function x() {
	local DIR=
	local FORMAT=
	local UNPKCMD=
        local FILENAME=${1:l}

	# DETECTORS
	if   [ "${FILENAME[-7,-1]}" = ".tar.gz" ] ; then
		FORMAT='tar.gz'
	elif [ "${FILENAME[-4,-1]}" = ".tgz" ] ; then
		FORMAT='tar.gz'
	elif [ "${FILENAME[-8,-1]}" = ".tar.bz2" ] ; then
		FORMAT='tar.bz2'
	elif [ "${FILENAME[-5,-1]}" = ".tbz2" ] ; then
		FORMAT='tar.bz2'
	elif [ "${FILENAME[-7,-1]}" = ".tar.xz" ] ; then
		FORMAT='tar.bz2'
	elif [ "${FILENAME[-4,-1]}" = ".txz" ] ; then
		FORMAT='tar.bz2'
	elif [ "${FILENAME[-4,-1]}" = ".tbz" ] ; then
		FORMAT='tar.bz2'
	elif [ "${FILENAME[-3,-1]}" = ".gz" ] ; then
		FORMAT='gz'
	elif [ "${FILENAME[-4,-1]}" = ".zip" ] ; then
		FORMAT='zip'
	elif [ "${FILENAME[-6,-1]}" = ".nupkg" ] ; then
		FORMAT='zip'
                SUFFIX='nupkg'
	elif [ "${FILENAME[-4,-1]}" = ".rar" ] ; then
		FORMAT='rar'
	elif [ "${FILENAME[-3,-1]}" = ".7z" ] ; then
		FORMAT='7z'
	elif [ "${FILENAME[-4,-1]}" = ".tar" ] ; then
		FORMAT='tar'
	elif [ "${FILENAME[-4,-1]}" = ".jar" ] ; then
		FORMAT='jar'
        else
		echo "Cannot determine archive format from filename $1"
		return 1
	fi

	if [ '!' -e $1 ] ; then
		echo "File does not exist: $1"
		return 1
	fi

	echo "$FORMAT detected, based on filename."

	# Try listing the files to see if the archive is unnice (no root dir).
	case $FORMAT in
	'tar.gz')
		UNPKCMD=(tar vxzf)
	;;
	'tar.bz2')
		UNPKCMD=(tar vxjf)
	;;
	'gz')
		UNPKCMD=gunzip
	;;
	'zip')
		UNPKCMD=unzip
	;;
	'rar')
		UNPKCMD=(unrar x)
	;;
	'7z')
		UNPKCMD=(7z x)
	;;
	'tar')
		UNPKCMD=(tar xvf)
	;;
	'jar')
		UNPKCMD=unzip
	;;
	esac

	if [ -z "$FORMAT" ] ; then
		echo "Unknown format <$FORMAT>, quitting"
		return 1
	fi
	
	DIR=''
        if [ -z "${SUFFIX}" ] ; then
		SUFFIX="${FORMAT}"
	fi
	DIR="$(basename $1 .${SUFFIX})"
	unset SUFFIX

	mkdir $DIR
	cd $DIR
	$UNPKCMD "../$1" || return 1
	if [[ $(ls -a1 | wc -l) == 3 ]] ; then
		local SUBDIR="$(ls -1)"
		mv $SUBDIR ..
		cd ..
		rmdir $DIR
		cd $SUBDIR
	fi
}

function xr ()
{
	x "$@" && /bin/rm "../$1"
}

# Extracts audio from video files (e. g. youtube .flvs downloaded
# with clive).  Requires Mplayer and Oggenc.
function extractaudio () {
	for i
	do echo "Extracting audio from $i"
	local BASENAME="$( basename $i | sed -re 's/\..+$//' | sed -re 's/[ ,:]/_/g' )"
	local DIR="$(dirname $i)"
	echo "$i"
	mplayer -really-quiet -ao "pcm:fast:file=/tmp/${BASENAME}_TEMP" -vo null "$i" > /dev/null
	oggenc "/tmp/${BASENAME}_TEMP" -o "${DIR}/${BASENAME}.ogg"
	rm -f "/tmp/${BASENAME}_TEMP"
	echo 'Done!'
	done
}

# These three are stolen from http://dotfiles.org/~josephholsten/.zshrc
# and slightly modified by me.
function title() {
	if [ -z $DISPLAY ] ; then return ; fi
	# escape '%' chars in $1, make nonprintables visible
	a=${(V)1//\%/\%\%}

	# Truncate command, and join lines.
	#a=$(print -Pn "%40>...>$a" | tr -d "\n")

	case $TERM in
	screen)
		print -Pn "\ek$a \@$3\e\\"      # screen title (in ^A")
		;;
	xterm*|*rxvt*|linux)
		print -Pn "\e]2;$a \@$3$2\a" # plain xterm title
		;;
	esac
}
# precmd is called just before the prompt is printed
function precmd() {
	title "z" "%55<...<%~"
}
# preexec is called just before any command line is executed
function preexec() {
	title "$1" "%35<...<%~"
}

# Countdown timer.  Uses figlet or toilet.
# First argument is the number of seconds
# and the second argument (optional) is the figlet
# font to use.
function countdown() {
	#if $(type -p figlet) ; then
	#	FIGLET_CMD=figlet
	#elif $(type -p toilet) ; then
		FIGLET_CMD=toilet
	#else
	#	echo "No figlet-like command found."
	#	return 1
	#fi
	if [ -z "$2" ] ; then
		font=bigascii12
	else
		font=$2
	fi
	for (( count=$1 ; count >= 0 ; count= $count - 1 )) ; do
		clear
		$FIGLET_CMD -tf $font "$count"
		sleep 1
	done
	clear; $FIGLET_CMD -tf $font "Done."
}

# Very primitive barely cryptographic text encoding
# to use for e. g. family surprises.  Not even remotely
# secure!
function enctext () {
	if [ -z $2 ] ; then
		echo "Usage: enctext <KEY> <your text strings>"
		return 1
	fi
	echo "$*[2,-1]" | openssl des3 -k "$1" | openssl base64 | xargs echo
}
alias enctext='noglob enctext'

function dectext () {
	if [ -z $2 ] ; then
		echo "Usage: dectext <KEY> <encrypted text strings>"
		return 1
	fi
	echo $*[2,-1]  | sed -re 's/\s+/\n/g' | openssl base64 -d | openssl des3 -d -k "$1"
}
alias dectext='noglob dectext'

function ctimeize () {
	for name in $@ ; do
		if [ -z "$name" ] ; then return ; fi
		TIME=$(stat +ctime "$name")
		NEWNAME="$(ndate -d @$TIME)_$(basename $name)"
		/bin/cp -v "$name" "$NEWNAME"
	done
}
alias ctimeize='noglob ctimeize'
function mtimeize () {
	for name in $@ ; do
		if [ -z "$name" ] ; then return ; fi
		TIME=$(stat +mtime "$name")
		NEWNAME="$(ndate -d @$TIME)_$(basename $name)"
		/bin/cp -v "$name" "$NEWNAME"
	done
}
alias mtimeize='noglob mtimeize'

# Clean object files
function cof () {
	for MASK in "*.pyc" "*.pyo" "*.o" "*.hi" "__pycache__" ; do
		find . -name "$MASK" -exec /bin/rm -vrf {} ';'
	done
}


### ####################################################################
### Other configs!

source ~/.zshenv
source ~/.zshrc-osdependent
source ~/.zshrc-local
