#!/bin/bash

ORG_HOME=~/git/org
ORG_SRC_HOME=~/git/org/src
ORG_DATA_HOME=$ORG_HOME/data
export ORG_DATA_HOME

add-project() {
	jq -n -c --arg name $2 \
	'{"name":"\($name)"}' >> $ORG_DATA_HOME/projects.json
}

add-task() {
  n="$2"
  shift
  shift
  p="$@"
	jq -n -c --arg name "$n" --arg projects "$p" \
	'{"name":"\($name)", "projects": ($projects|split(" "))}' >> $ORG_DATA_HOME/tasks.json
}

org-add() {
  if [[ $1 == "project" ]]; then
    add-project $@
  fi

  if [[ $1 == "task" ]]; then
    add-task "$@"
  fi
}

org-reset() {
	rm -f $ORG_DATA_HOME/projects.json
	rm -f $ORG_DATA_HOME/tasks.json
}

org-stats() {
	echo "ORG STATS"
	echo "-----"
	wc -l $ORG_DATA_HOME/projects.json |
	awk '{ print $1 " projects" }'
	wc -l $ORG_DATA_HOME/tasks.json |
	awk '{ print $1 " tasks" }'
}

org-show() {
  if [[ -z "$1" ]]; then
    cat $ORG_DATA_HOME/tasks.json
  elif [[ $1 == "projects" ]]; then
    echo " "
    echo "Projects"
    echo "--------"
		$ORG_DATA_HOME/projects.json
  else
		python $ORG_SRC_HOME/show_project.py $1
	fi

}

org-backup() {
	echo "Backing up to Google Drive"
	cp -r $ORG_HOME/data/ ~/Google\ Drive/org-backup/
}
