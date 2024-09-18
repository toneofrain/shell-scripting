c_cyan=`tput setaf 6`
c_red=`tput setaf 1`
c_green=`tput setaf 2`
c_yellow=`tput setaf 3`
c_sgr0=`tput sgr0`

parse_branch ()
{
   if git rev-parse --git-dir >/dev/null 2>&1
   then
           branchname="("$(branch_color)$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')${c_sgr0}")"
   else
      return 0
   fi
   echo -e $branchname
}

branch_color ()
{
   if git rev-parse --git-dir >/dev/null 2>&1
   then
      color=""
      if git diff --quiet 2>/dev/null >&2
      then
         gitstatus=$(git status 2>/dev/null| tail -n1)
         case "$gitstatus" in
            "nothing to commit (working directory clean)" ) color=${c_green};;
            * ) color=${c_yellow};;
         esac
      else
         color=${c_red}
      fi
   else
      return 0
   fi
   echo -ne $color
}

export PS1='\e[01;30m\u@\h \e[0;36m\w \e[0m$(parse_branch)\$ '
