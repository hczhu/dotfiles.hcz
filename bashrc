#personal alias
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
export PATH=$PATH:$HOME/tools/

export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S"
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it
# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r;"

# for tmux window titles.
settitle() {
  title=$(basename $PWD)
  printf "\033k$title\033\\"
}

PROMPT_COMMAND="settitle; $PROMPT_COMMAND"

set_git_branch() {
  export GIT_BRANCH=$(get_git_branch)
}

get_git_branch() {
  if [ -r '.git' ]; then 
    echo "($(git branch 2> /dev/null | grep \* | cut -d' ' -f2))"
  elif [ -r '.hgignore' ]; then
    echo "($(hg bookmark 2> /dev/null | grep \* | cut -d' ' -f3))"
  fi
}

# PROMPT_COMMAND="set_git_branch; $PROMPT_COMMAND"
# PROMPT_COMMAND=""

setPS1() {
  export PS1='[\u@\h \w$(get_git_branch)] ';
}

setPS1

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

tmux attach -t work || tmux attach -t hacking || tmux attach -t hack

alias ds='date +%s -d'

alias git-new-br='git checkout --track origin/master -b'

# record screen output
#if [ "$SCREEN_RECORDED" = "" ]; then
#  export SCREEN_RECORDED=1
#  script -t -a 2> /tmp/terminal-record-time-$$.txt /tmp/terminal-record-$$.txt
#fi

# VimBinaryDiff() {
  # vimdiff <(xxd $1) <(xxd $2)
# }

alias vimbdiff='VimBinaryDiff'

ShowThreadInfo() {
  # expect an input pid.
  pid=$1
  top  -b -H -p $pid -n1 | tail -n+8 |  cut -d':' -f2 \
    | cut -d' ' -f2 | sed  's/[0-9]\+$/*/' \
    | sort | uniq -c  | sort -k1 -n | sed 's/^ \+/    /'
}

# edit command line in bash by vi
# set -o vi

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

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

export HGEDITOR='HgEditor() { file=$1; $HOME/git-hooks/prepare-commit-msg $file template; vim $file; } && HgEditor'
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
alias ctags-src="ctags -h .thrift.h.H.hh.hpp.hxx.h++.inc.def -R"
alias Ctags="ctags-src . /usr/local/include /home/ubuntu/github/"

alias clang-format-diff="hg diff -U0 -r '.^' -r . | clang-format-diff.py -p 2 -i"

hgReverCommit() {
  commit_hash=$1
  hg diff -c $1 --reverse | hg patch --no-commit -
}


# for C++ code
export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/lib:/usr/local/lib64"
export CPATH="$CPATH:/usr/local/include"
export GLOG_logtostderr=1

hgCommitFilePattern() {
  pat=$1
  hg commit -I **${pat}**
}

alias rg='rg -p'
alias hg-my-commits='hg log -k "hongcheng zhu"'
alias clang-format='clang-format-3.9'

clangFormat() {
  clang-format-3.9
}

export PYTHONPATH='/usr/local/lib/python3.4/dist-packages'
if ! pgrep -q ssh-agent > /dev/null 2>&1; then
  ssh-agent -s
fi
ssh-agent -s

alias mysql-start='sudo /etc/init.d/mysql start'
alias mysql-stop='sudo /etc/init.d/mysql stop'
alias mysql-shell='mysql -u root -p'
alias cpu-num='echo $(nproc)'

export LD_LIBRARY_PATH='/usr/local/lib:/lib:/lib64:/usr/lib'
alias nm='nm --demangle'
export CPP_LIBS='-Wl,--start-group -lthriftcpp2 -lasync -lconcurrency -lprotocol -lsecurity -lserver -lthrift -lthrift-core  -lthriftfrozen2 -lthriftprotocol -ltransport -Wl,--end-group -lproxygenhttpserver -lproxygenlib -lReactiveSocket -lyarpl -lwangle -lgssapi_krb5 -lfolly -lcurl -lboost_context   -lboost_chrono   -lboost_date_time   -lboost_filesystem   -lboost_program_options   -lboost_regex   -lboost_system   -lboost_thread   -lboost_atomic   -lpthread   -ldouble-conversion   -lglog   -levent   -lssl   -lcrypto   -ldouble-conversion   -lglog   -lgflags   -lpthread   -levent   -lssl   -lcrypto   -lz   -llzma   -llz4   -lzstd   -lsnappy   -liberty   -ldl   -lpthread    -lgmock   -lgtest' 
export GCC_FLAGS='-g   -std=gnu++14   -Wall   -Wno-deprecated   -Wdeprecated-declarations   -Wno-error=deprecated-declarations   -Wno-sign-compare   -Wno-unused   -Wunused-label   -Wunused-result   -Wnon-virtual-dtor   -fopenmp'

# -lgmock_main -lgtest_main

# Works for a Makefile generated by cmake
alias make-verb='make VERBOSE=1'
