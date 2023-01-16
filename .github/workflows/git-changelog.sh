#!/bin/bash

# Generates git log grouped by day and outputs to markdown file
#
# optional parameters
# -a, --author       to filter by author
# -s, --since        to select start date
# -u, --until        to select end date
# -t, --tag          to select the from tag

git-log-to-markdown () {
  local NEXT=$(date +%F)

  local RED="\x1B[31m"
  local YELLOW="\x1B[32m"
  local BLUE="\x1B[34m"
  local RESET="\x1B[0m"

  local SINCE="1970-01-01"
  local UNTIL=$NEXT


  for i in "$@"
  do
  case $i in
    -a=*|--author=*)
    local AUTHOR="${i#*=}"
    shift
    ;;
    -s=*|--since=*)
    SINCE="${i#*=}"
    shift
    ;;
    -u=*|--until=*)
    UNTIL="${i#*=}"
    shift
    ;;
    -t=*|--tag=*)
    TAG="${i#*=}"
    shift
    ;;
    *)
      # unknown option
    ;;
  esac
  done

  local LOG_FORMAT=" %Cgreen*%Creset %s"
  
  if [ -z "$AUTHOR" ]
  then
    LOG_FORMAT="$LOG_FORMAT %Cblue(%an)%Creset"
  else
    echo "# Gitlog"
  fi

  git log --no-merges --author="${AUTHOR}" --since="${SINCE}" --until="${UNTIL}" --format="%cd" --date=short | sort -u | while read DATE ; do

    local GIT_PAGER=$(git log ${TAG}..HEAD --reverse --no-merges --format="${LOG_FORMAT}" --since="${DATE} 00:00:00" --until="${DATE} 23:59:59" --author="${AUTHOR}")
    
    if [ ! -z "$GIT_PAGER" ]
    then
      echo -e "# Changelog:"
      echo -e "## $DATE"
      echo -e "${GIT_PAGER}"
    fi

  done

}

git-log-to-markdown "$@" > ./gitlog.md
cat ./gitlog.md
rm ./gitlog.md