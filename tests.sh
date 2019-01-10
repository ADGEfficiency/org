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
