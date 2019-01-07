import json

def load_json(file_name):
    return [json.loads(line) for line in open(file_name, 'r')]

tasks = load_json('tasks.json')
projects = load_json('projects.json')

# print(tasks)
# print(projects)

projects = {project['name']: project for project in projects}

for task in tasks:
    task['priorities'] = [float(projects[project]['priority'])
                          for project in task['projects']]

    task['density'] = sum(task['priorities']) / float(task['cost'])

tasks_dict = {task['name']: task for task in tasks}

tasks = sorted(tasks_dict.items(), key=lambda tup: tup[1]['density'], reverse=True)  
