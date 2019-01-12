#!/bin/bash

ORG_HOME=~/git/org
ORG_SRC_HOME=~/git/org/src
ORG_DATA_HOME=$ORG_HOME/data
export ORG_DATA_HOME

add-project() {
	jq -n -c --arg name $2 --arg priority $3 \
	'{"name":"\($name)", "priority":"\($priority).0"}' >> $ORG_DATA_HOME/projects.json
}

iterate_project_list() {
	PROJECTS=()
	COUNT=0
	for line in "$@"; do
		COUNT=$(( COUNT + 1 ))
		if [[ $COUNT == 4 ]]; then
			PROJECTS+="$line"

		elif [[ $COUNT > 4 ]]; then
			PROJECTS+=" $line"
		fi
	done
	echo $PROJECTS;
}

add-task() {
	arr=$(iterate_project_list $@)
	jq -n -c --arg name $2 --arg cost $3 --arg projects "$arr" \
	'{"name":"\($name)", "cost":"\($cost)", "projects": ($projects|split(" "))}' >> $ORG_DATA_HOME/tasks.json
}

org-add() {
  if [[ $1 == "project" ]]; then
    add-project $@
  fi

  if [[ $1 == "task" ]]; then
    add-task $@
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
	if [[ -z $1 ]]; then
		python $ORG_SRC_HOME/organize.py | less
	fi
	if [[ $1 == "projects" ]]; then
		cat $ORG_DATA_HOME/projects.json
	fi

	if [[ $1 == "tasks" ]]; then
		cat $ORG_DATA_HOME/tasks.json
	fi

	if [[ $1 == "project" ]]; then
		python $ORG_SRC_HOME/show_project.py $2
	fi

}

org-backup() {
	echo "Backing up to Google Drive"
	cp -r $ORG_HOME/data/ ~/Google\ Drive/org-backup/
}
