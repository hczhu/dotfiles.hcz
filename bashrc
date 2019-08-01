# Don't run anything for other logins, like scp

# set -ex
function maybeExit() {
  if [ -z "${PS1}" ]; then
    return -1
  fi
  return 0
}

if ! maybeExit 2> /dev/null; then
  return 0
fi

# personal alias
alias chinese='LANG=zh.utf8'
#alias arena='killall scim; /usr/lib/jvm/java-6-openjdk/jre/bin/javaws.real ~/mycode/topcoder/ContestAppletProd.jnlp &'
alias vim='vim -X'
alias emacs='emacs -nw'
alias vir='vim -R -X'
alias lss='ls --color=auto -h'
alias ll='ls -lh'
alias cl='clear'
alias 'grep'='grep --color -a'

# personal export
export PATH=$PATH:$HOME/tools/:$HOME/.local/bin

# for tmux window titles.
settitle() {
  title=$(basename $PWD)
  printf "\033k$title\033\\"
}


set_git_branch() {
  export GIT_BRANCH=$(get_git_branch)
}

get_git_branch() {
  if [ -r '.git' ]; then 
    tag=$(git branch 2> /dev/null | grep \* | cut -d' ' -f2)
  elif [ -r '.hg' -o -r '../.hg' ]; then
    tag=$(hg bookmark 2> /dev/null | grep \* | cut -d' ' -f3)
  fi
  echo $(echo "(${tag})" | sed 's/\n/ /g;s/\t/ /g;')
}

# PROMPT_COMMAND="set_git_branch; $PROMPT_COMMAND"
# PROMPT_COMMAND=""

function prependIfNotHave() {
  pattern="$1"
  value="$2"
  if echo "${value}" | grep -q "$pattern"; then
    echo "${value}"
  else
    echo "${pattern} ${value}"
  fi
}

export PROMPT_COMMAND=$(prependIfNotHave "history -a; history -n;" "$PROMPT_COMMAND")
# export PROMPT_COMMAND=$(prependIfNotHave "history -a; history -c; history -r;" "$PROMPT_COMMAND")

export PS1='[\u@\h \w$(get_git_branch)] ';

# Input method
#export XIM="SCIM"
#export XMODIFIERS=@im=SCIM  #设置scim为xim默认输入法
#export GTK_IM_MODULE="scim-bridge"  #设置scim-bridge为gtk程序默认的输入法
#export QT_IM_MODULE=xim   #设置xim为qt程序默认的输入法
#export XIM_PROGRAM="scim -d" #使可以自动启动

#For Weka
export WEKAROOT='$HOME/packages/weka-3-6-12'
export CLASSPATH="$CLASSPATH:.:$WEKAROOT/weka.jar"
alias weka-lr='java weka.classifiers.functions.LinearRegression'
alias weka-lg='java -Xmx2028m weka.classifiers.functions.Logistic'
alias weka-svm='java -Xmx2028m weka.classifiers.functions.LibSVM'
alias weka='java -Xmx2024m -jar $WEKAROOT/weka.jar'

#Start a single workrave
if [[ -e workrave && $(pgrep workrave | wc -l) = "0" ]]
then
  workrave &
fi

# access the last output by $(L)
alias L='tmux capture-pane; tmux showb -b 0 | tail -n 3 | head -n 1'

alias tmux-new='tmux new -s'

attachTmux() {
  if [ -z "$_IN_TMUX" ]; then
    tmux attach -t work || tmux attach -t hacking || tmux attach -t hack
    export _IN_TMUX='tmux-attached'
  fi
}

# attachTmux > /dev/null 2>&1

alias ts='date +%s'
# example: ds -d '7 days ago'
alias ds='date +%Y-%m-%d'

alias git-new-br='git checkout --track origin/master -b'

# record screen output
#if [ "$SCREEN_RECORDED" = "" ]; then
#  export SCREEN_RECORDED=1
#  script -t -a 2> /tmp/terminal-record-time-$$.txt /tmp/terminal-record-$$.txt
#fi

function vimBinaryDiff() {
  vimdiff <(xxd $1) <(xxd $2)
}

alias vimbdiff='vimBinaryDiff'

ShowThreadInfo() {
  # expect an input pid.
  pid=$1
  top  -b -H -p $pid -n1 | tail -n+8 |  cut -d':' -f2 \
    | cut -d' ' -f2 | sed  's/[0-9]\+$/*/' \
    | sort | uniq -c  | sort -k1 -n | sed 's/^ \+/    /'
}

# edit command line in bash by vi
set -o vi
export VISUAL=vim

RepeatRunUntilFail() {
  seconds=$1
  shift
  for((i=0;i<1000000;++i)); do
    #>&2 echo "Running $@"
    $@
    if [ $? -ne 0 ]; then
      echo "$@ failed :("
      break
    fi
    sleep $seconds
  done
}

# export HGEDITOR='HgEditor() { file=$1; $HOME/git-hooks/prepare-commit-msg $file template; vim $file; } && HgEditor'
alias diff-sum='diff -wbBdu'
alias hg-blame='hg blame -dupw'
alias hg-master='hg update master'
alias fix-tmux='tmux detach -a'
export ACLOCAL_PATH=/usr/share/aclocal

alias hdfs='hadoop dfs'
alias hdfs-ls='hadoop dfs -ls 2> /dev/null'
alias hdfs-cat='hadoop dfs -cat 2> /dev/null'

bigDir() {
 du -hs $1/* 2> /dev/null | grep ^[0-9.]*G
}
alias big-dir='bigDir'

alias test-network='iperf3 -P2b -c' 

alias hdfs-du='hdfs -dus'

LS_COLORS=$LS_COLORS:'di=31:'
export LS_COLORS

readableNumber() {
  sed 's/([0-9])[0-9]{3}(\s|$)/\1K\2/g;s/([0-9])[0-9]{3}K/\1M/g;s/([0-9])[0-9]{3}M/\1B/g;s/([0-9])[0-9]{3}B/\1T/g' -
}

alias perlack-context='perlack -A 3 -B 3'

# to edit command lines
set -o vi
alias ctags-cpp='ctags -R --languages=C++,Thrift'
alias ctags-cpp-local='ctags-cpp /usr/include /usr/local/include'

alias ctags-cpp-py='ctags-cpp --languages=C++,Thrift,Python'
alias ctags-cpp-py-local='ctags-cpp-py /usr/include /usr/local/include'


alias clang-format-diff="hg diff -U0 -r '.^' -r . | clang-format-diff.py -p 2 -i"

hgReverCommit() {
  commit_hash=$1
  hg diff -c $1 --reverse | hg patch --no-commit -
}


# for C++ code

export LIBRARY_PATH="${LIBRARY_PATH}:/usr/local/lib:/usr/local/lib64"
export LIBRARY_PATH=$(echo ${LIBRARY_PATH} | sed 's/:/\n/g' | sed '/^$/d' | sort -u | tr '\n' ':' | sed 's/:$//')

export CPATH="$CPATH:/usr/local/include"
export GLOG_logtostderr=1

hgCommitFilePattern() {
  pat=$1
  hg commit -I **${pat}**
}

alias rg-p='rg -p'
alias hg-my-commits='hg log -k "hongcheng zhu"'
alias clang-format='clang-format-3.9'

clangFormat() {
  clang-format-3.9
}

# export PYTHONPATH=$(ls -d /usr/local/lib/python3*/site-packages 2> /dev/null | tail -n1)
# if ! pgrep -q ssh-agent > /dev/null 2>&1; then
  # ssh-agent -s > /dev/null 2>&1
# fi

alias mysql-start='sudo /etc/init.d/mysql start'
alias mysql-stop='sudo /etc/init.d/mysql stop'
alias mysql-shell='mysql'
alias cpu-num='echo $(nproc)'

export LD_LIBRARY_PATH='/usr/local/lib:/lib:/lib64:/usr/lib'
alias nm='nm --demangle'
export CPP_LIBS='-lthrift -lfolly -lcurl -lboost_context -lboost_chrono -lboost_date_time -lboost_filesystem -lboost_program_options -lboost_regex -lboost_system -lboost_thread -lboost_atomic -lpthread -ldouble-conversion -lglog -levent -lssl -lcrypto -ldouble-conversion -lglog -lgflags -lpthread -levent -lssl -lcrypto -lz -llzma -llz4 -lzstd -lsnappy -liberty -ldl -lpthread -lgmock -lgtest' 
export ADV_CPP_LIBS="-lproxygenhttpserver -lproxygenlib -Wl,--start-group -lthriftcpp2 -lasync -lconcurrency -lprotocol -lsecurity -lserver -lthrift -lthrift-core -lthriftfrozen2 -lthriftprotocol -ltransport -Wl,--end-group -lReactiveSocket -lyarpl -lwangle -lgssapi_krb5 $CPP_LIBS"
export GCC_FLAGS='-g -std=gnu++17 -Wall -Wno-deprecated -Wdeprecated-declarations -Wno-error=deprecated-declarations -Wno-sign-compare -Wno-unused -Wunused-label -Wunused-result -Wnon-virtual-dtor -fopenmp'

# -lgmock_main -lgtest_main

# Works for a Makefile generated by cmake
alias make-verb='make VERBOSE=1'

alias format-all-cpp-files="find . -type f '(' -name '*.cpp' -o -name '*.h' -o -name '*.cc' -o -name '*.hpp' ')' -exec clang-format -style=file -i {} \;"
# for c++ bianry core dump
ulimit -c unlimited

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=1000000                   # big big history
export HISTFILESIZE=10000000              # big big history
shopt -s histappend                      # append to history, don't overwrite it
# Save and reload the history after each command finishes
export nproc=$(lscpu | grep '^CPU(s):' | sed 's/ \+/ /g' | cut -d' ' -f2)
alias make='make -j $(nproc)'

[[ -s /home/ubuntu/.autojump/etc/profile.d/autojump.sh ]] && source /home/ubuntu/.autojump/etc/profile.d/autojump.sh

# alias python3='PYTHONPATH=/usr/local/lib/python3.5/dist-packages && python3'
# alias python2='PYTHONPATH=/usr/local/lib/python2.7/dist-packages && python2'

export PATH="$PATH:/usr/local/go/bin:/usr/local/mysql/bin"
export PATH=$(echo $PATH | tr ':' '\n' | sort -u | tr '\n' ':')
export GOMAXPROCS=$nproc
export Less='2>&1 | less'
alias hg-diff-files='hg status --change'
alias ps-threads=' ps -T -p'
alias top-threads='top -H -p'

function confirm() {
  echo "$@ y/N? "
  read y
  if [ "$y" = "y" ]; then
    return 0
  fi
  return 1
}

filesMatch() {
  pattern=$1
  path_or_files="$2"
  # echo "${path_or_files}"
  # echo ""
  for path_or_file in $(echo ${path_or_files}); do
    # echo Searching "$path_or_file"
    rg -H "$pattern" "$path_or_file" | grep "$path_or_file" | cut -d':' -f1 | sort -u
    # rg -H "$pattern" "$path_or_file"
  done
}

vimOpenMatchedFiles() {
  pattern=$1
  path="$2"
  vim +/"$pattern" $(filesMatch "$pattern" "$path")
  # filesMatch "$pattern" "$path"
}

vimOpenFileAndLocationWithCommands() {
  # file:lineNo
  f_loc=$1
  shift
  read f loc <<<$(echo $f_loc | sed 's/:/ /g')
  vim +:"$loc | $@" $f
}

vimOpenFileNameContain() {
  pattern=$1
  path=$2
  vim $(find $path -name "*$pattern*" -print)
}

function lookup() {
  echo "$@" | aspell -a
}

function fixBuildErrors() {
  testTarget=$1
  errorFile=$2
  filePrefix=$(echo $testTarget | sed 's/\.\.\.//; s/:.*$//')
  echo "Searching for ${filePrefix} in error file: ${errorFile}"
  for f_loc in $(grep -e "^${filePrefix}[^:]*:[0-9]\+" $errorFile | cut -d':' -f1,2 | uniq); do
    searchPattern=$(echo $f_loc | sed 's/\//\\\//g')
    echo "Found a file location: ${f_loc}"
    vimOpenFileAndLocationWithCommands $f_loc ":vs $errorFile | /$searchPattern"
    if ! confirm Continue to next file; then
      break
    fi
  done
}

function hgVimdiff() {
  files=$1
  if [ -z "$files" ]; then
    files=$(hg status --change . | cut -d' ' -f2)
  fi
  echo "Diff files: $files"
  for f in $files; do
    vimdiff <(hg cat -r .^ $f) $f
  done
}

alias hg-vimdiff=hgVimdiff
alias hg-head-commit='hg id -i'

function purgeBinaries() {
  find $1 -type f | while read f; do if file $f | grep -q 'ELF 64-bit LSB executable'; then echo "rm $f" && rm $f; fi; done
}

alias hg-revert-file='hg revert -r .^'
alias ps-top-mem='ps aux  --sort=-rss -m | head -n '
alias list-sockets='ss -rpetb'
alias atop='atop -m'
alias ssh-github-keygen='ssh-keygen -t rsa -b 4096 -C "zhuhcheng@gmail.com"'
alias apt-search='apt-cache search'

function NonprintableToWhitespaces() {
  echo "$1" | tr -c '[:print:]\t\r\n' '[ *]'
}

function Pgrep() {
  name=$1
  cmd_part=$2
  if [ -z "$cmd_part" ]; then
    cmd_part="$name"
  fi
  for pid in $(pgrep "${name}"); do
    if cat /proc/${pid}/cmdline | grep -q "${cmd_part}"; then
      echo -e "$pid\t$(cat /proc/${pid}/cmdline | tr -c '[:print:]\t\r\n' '[ *]')"
    fi
  done
}

alias pgrep-name-cmd='Pgrep'

function startMoshServer() {
  # pkill mosh
  if ! Pgrep mosh | grep -q ""; then
    echo "No mosh server running. Starting a new one..."
    mosh-server new -c 256 -s -l LANG=en_US.UTF-8
  fi
}

alias run-ssh-agent='eval $(ssh-agent)'

alias change-hostname='hostnamectl set-hostname'

setupSwapFile() {
  set -ex
  sudo swapoff -a
  size_gb=2
  if [ ! -z "$1" ]; then
    size_gb=$1
    shift
  fi
  root_dir=""
  if [ ! -z "$1" ]; then
    root_dir=$1
    shift
  fi
  sudo rm -fr ${root_dir}/swapfile
  sudo fallocate -l ${size_gb}G ${root_dir}/swapfile
  sudo dd if=/dev/zero of=${root_dir}/swapfile bs=1024 count=$((size_gb * 1024**3 / 1024))
  sudo chmod 600 ${root_dir}/swapfile
  sudo mkswap ${root_dir}/swapfile
  sudo swapon ${root_dir}/swapfile
  if ! grep -q '/swapfile.swap.swap' /etc/fstab; then
    sudo echo -e "${root_dir}/swapfile\tswap\tswap\tdefaults\t0\t0" >> /etc/fstab || true
  fi
  sudo swapon --show
  set +ex
}

function searchForSymbol() {
  for lib in $(ls /usr/local/lib/lib*.a); do echo $lib; nm -C --defined-only $lib | grep "$1"; done | less -r
}

alias git-ci='git commit -am'
alias git-ci-push='git-ci "update" && git push'

portListener() {
  sudo lsof -i :$1
}

alias git-st='git st -uno'

alias cp='cp --backup=numbered'
alias ln='ln --backup=numbered'
alias mv='mv -f --backup=numbered'
alias git-submodule-update='git submodule update --init --recursive'
alias lighttpd-restart='sudo /etc/init.d/lighttpd restart'
alias cron-edit='crontab -e'
alias datadog-restart='sudo systemctl restart datadog-agent'

export PATH=/usr/local/bin:$PATH

function hgBackOut() {
  r=$1
  hg show ${r}
  if confirm "Back out this commit?"; then
    hg strip --keep -r ${r}
  fi
}

alias hg-back-out='hgBackOut'

alias kill-mosh-server='kill $(pidof mosh-server)'
alias hg-unpublish-commit='hg phase -d -f -r'
alias wget-stdout='wget -O -'

upgradeUbuntuRelease() {
  set -x
  sudo apt install ubuntu-release-upgrader-core
  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt-get dist-upgrade
  sudo do-release-upgrade
  set +x
}

testDiskWriteRate() {
  dir=$1
  dd if=/dev/zero of=${dir} conv=fdatasync bs=384k count=10k
  rm -f ${dir}
}

testDiskReadRate() {
  f=$1
  dd if=${f} of=/dev/null conv=fdatasync bs=384k count=10k
}
