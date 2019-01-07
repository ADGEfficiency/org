#!/bin/bash

add_project() {
	jq -n -c --arg name $1 --arg priority $2 \
	'{"name":"\($name)", "priority":"\($priority)"}' >> projects.json
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

add_task() {
	arr=$(iterate_project_list $@)
	jq -n -c --arg name $1 --arg cost $2 --arg projects "$arr" \
	'{"name":"\($name)", "cost":"\($cost)", "projects": ($projects|split(" "))}' >> tasks.json
}

reset() {
	rm -f projects.json
	rm -f tasks.json
}

stats() {
	echo "ORG STATS"
	echo "-----"
	wc -l projects.json |
	awk '{ print $1 " projects" }'
	wc -l tasks.json |
	awk '{ print $1 " tasks" }'
}

reset

add_project "test_project" 10
add_task "start" 5 "test_project" "actual_project"
add_task "end" 2 "test_project" "actual_project"

cat projects.json
echo ""
cat tasks.json

