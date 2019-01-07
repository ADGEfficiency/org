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

add_project "low_priority" 5
add_project "high_priority" 10
add_task "clean_room" 1 "low_priority" "high_priority"
add_task "water_plants" 2 "low_priority"
add_task "start_company" 5 "high_priority"
add_task "build_product" 5 "high_priority"

cat projects.json
echo ""
cat tasks.json

