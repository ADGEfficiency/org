#!/bin/bash

ORG_HOME=~/git/org
ORG_DATA_HOME=$ORG_HOME/data

org-add-project() {
	jq -n -c --arg name $1 --arg priority $2 \
	'{"name":"\($name)", "priority":"\($priority).0"}' >> $ORG_DATA_HOME/projects.json
}

iterate_project_list() {
	PROJECTS=()
	COUNT=0
	for line in "$@"; do
		COUNT=$(( COUNT + 1 ))
		if [[ $COUNT == 3 ]]; then
			PROJECTS+="$line"

		elif [[ $COUNT > 3 ]]; then
			PROJECTS+=" $line"
		fi
	done
	echo $PROJECTS;
}

org-add_task() {
	arr=$(iterate_project_list $@)
	jq -n -c --arg name $1 --arg cost $2 --arg projects "$arr" \
	'{"name":"\($name)", "cost":"\($cost)", "projects": ($projects|split(" "))}' >> $ORG_DATA_HOME/tasks.json
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
		python organize.py | less
	fi
	if [[ $1 == "projects" ]]; then
		cat $ORG_DATA_HOME/projects.json
	fi

	if [[ $1 == "tasks" ]]; then
		cat $ORG_DATA_HOME/tasks.json
	fi

	if [[ $1 == "project" ]]; then
		python show_project.py $2 | less
	fi

}

org-backup() {
	echo "Backing up to Google Drive"
	cp -r $ORG_HOME/data/ ~/Google\ Drive/org-backup/
}
